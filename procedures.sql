
-- 4c
CREATE PROCEDURE SupViewProfile
    @supervisorID int
AS
SELECT *
FROM Supervisor
WHERE id = @supervisorID


GO;

CREATE PROCEDURE UpdateSupProfile
    @supervisorID int,
    @name varchar(20),
    @faculty varchar(20)
AS
UPDATE Supervisor
SET name = @name, faculty = @faculty
WHERE id = @supervisorID


GO;

-- 4d

CREATE PROCEDURE ViewAStudentPublications
    @StudentID int
AS

IF exists (SELECT *
FROM GucianStudent
WHERE id = @StudentID) -- gucian
return (SELECT P.id, P.title, P.date, P.place, P.accepted, P.host
From Publication P, ThesisHasPublication THP, GUCStudentRegisterThesis GSRT
Where GSRT.sid = @StudentID AND GSRT.serial_no = THP.serialNO AND THP.pubid = P.id)

ELSE-- non gucian
return (SELECT P.id, P.title, P.date, P.place, P.accepted, P.host
From Publication P, ThesisHasPublication THP, NonGucianStudentPayForCourse GSRT
Where GSRT.sid = @StudentID AND GSRT.serial_no = THP.serialNO AND THP.pubid = P.id)


GO;

-- 4e
CREATE PROCEDURE AddDefenseGucian
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @DefenseLocation varchar(15)
AS
INSERT INTO Defense
VALUES
    (@ThesisSerialNo, @DefenseDate, @DefenseLocation, NULL)

GO;


CREATE PROCEDURE AddDefenseNonGucian
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @DefenseLocation varchar(15)
AS
IF (not exists (select *
from NonGUCianStudentTakeCourse a, NonGUCStudentRegisterThesis b
where a.sid = b.sid and a.grade <= 50))
INSERT INTO Defense
VALUES
    (@ThesisSerialNo, @DefenseDate, @DefenseLocation, NULL)


GO;

-- 4f
CREATE PROCEDURE AddExaminer
    -- TODO: an examiner is created every time since there is no way to identify a repeat
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @ExaminerName varchar(20),
    @National bit,
    @fieldOfWork varchar(20)
AS
Declare @ExaminerID int;
INSERT INTO Examiner
OUTPUT id into @ExaminerID
VALUES
    (@ExaminerName, @fieldOfWork, @National)

-- set @ExaminerID = @@IDENTITY;

INSERT INTO ExaminerEvaluateDefense
VALUES
    (@DefenseDate, @ThesisSerialNo, @ExaminerID, NULL)

GO;

-- 4g
CREATE PROCEDURE CancelThesis
    @ThesisSerialNo int
AS

Declare @tmpeval TEXT;

-- gucian
IF EXISTS (SELECT eval
FROM GUCianProgressReport
WHERE thesisSerialNumber = @ThesisSerialNo )
BEGIN
    SELECT @tmpeval = eval
    FROM GUCianProgressReport
    WHERE thesisSerialNumber = @ThesisSerialNo AND date >= ANY(SELECT date
        FROM GUCianProgressReport
        WHERE thesisSerialNumber = @ThesisSerialNo)

    IF (@tmpeval = '0')
    BEGIN
        DELETE 
        FROM Thesis
        WHERE serialNumber = @ThesisSerialNo
    END
END

-- non-gucian
IF EXISTS (SELECT eval
FROM NonGUCianProgressReport
WHERE thesisSerialNumber = @ThesisSerialNo )
BEGIN
    SELECT @tmpeval = eval
    FROM NonGUCianProgressReport
    WHERE thesisSerialNumber = @ThesisSerialNo AND date >= ANY(SELECT date
        FROM NonGUCianProgressReport
        WHERE thesisSerialNumber = @ThesisSerialNo)

    IF (@tmpeval = '0')
    BEGIN
        DELETE 
        FROM Thesis
        WHERE serialNumber = @ThesisSerialNo
    END
END





GO;

-- 4h
CREATE PROCEDURE AddGrade
    @ThesisSerialNo int
AS
BEGIN

    SELECT *
    FROM Thesis
    WHERE serialNumber = @ThesisSerialNo

-- TODO: determine which magic spells to cast here

END


GO;
-- 5a

CREATE PROCEDURE AddDefenseGrade
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @grade decimal(3,2)
as
UPDATE Defense
 SET grade = @grade
 WHERE serialNumber = @ThesisSerialNo and date = @DefenseDate


-- 5b
GO;

CREATE PROCEDURE AddCommentsGrade
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @comments varchar(300)
as
UPDATE Defense
SET comment = @comments
 WHERE serialNumber = @ThesisSerialNo and date = @DefenseDate

GO;

CREATE PROC viewMyProfile (@studentId INT) AS BEGIN
    SELECT * FROM PostGradUser
    INNER JOIN GucianStudent ON GucianStudent.id = PostGradUser.id
    INNER JOIN NonGucianStudent ON NonGucianStudent.id = PostGradUser.id
    WHERE PostGradUser.id = @studentId;
END;

GO;

CREATE PROC editMyProfile (@studentId INT, @firstName VARCHAR(10), @lastName VARCHAR(10),
    @password VARCHAR(10),@email VARCHAR(10), @address VARCHAR(10), @type VARCHAR(10)) AS BEGIN
    
    UPDATE PostGradUser SET email = @email, password = @password WHERE id = @studentId;
    IF EXISTS(SELECT * FROM GucianStudent WHERE id = @studentId)
        UPDATE GucianStudent SET firstName = @firstName, lastName = @lastName, address = @address, type = @type
            WHERE id = @studentId;
    ELSE
        UPDATE NonGucianStudent SET firstName = @firstName, lastName = @lastName, address = @address, type = @type
            WHERE id = @studentId;
END;

GO;

CREATE PROC addUndergradID (@studentId INT, @undergradID VARCHAR(10)) AS BEGIN
    UPDATE GucianStudent SET undergradID = @undergradID WHERE id = @studentId;
END;

GO;

CREATE PROC ViewCoursesGrades (@studentId INT) AS BEGIN
    SELECT Course.code, NonGUCianStudentTakeCourse.grade FROM NonGUCianStudentTakeCourse INNER JOIN Course ON NonGUCianStudentTakeCourse.cid = Course.id WHERE NonGUCianStudentTakeCourse.sid = @studentId;
END;

GO;

CREATE PROC ViewCoursePaymentsInstall (@studentId INT) AS BEGIN
    SELECT NonGucianStudentPayForCourse.cid, Installment.* FROM NonGucianStudentPayForCourse
    INNER JOIN Installment ON Installment.paymentId = NonGucianStudentPayForCourse.paymentNo
    WHERE NonGucianStudentPayForCourse.sid = @studentId; 
END;

GO;
