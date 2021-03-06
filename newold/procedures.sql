USE dbProject3;
GO

-- 4 c)
-- View profile of a a supervisor.
CREATE PROCEDURE SupViewProfile
    @supervisorID int
AS
SELECT *
FROM Supervisor
WHERE id = @supervisorID;


GO

-- 4 c)
-- Updat personal information of a supervisor.
CREATE PROCEDURE UpdateSupProfile
    @supervisorID int,
    @name varchar(20),
    @faculty varchar(20)
AS
UPDATE Supervisor
SET name = @name, faculty = @faculty
WHERE id = @supervisorID;


GO

-- 4d
-- View all publications of a student.
CREATE PROCEDURE ViewAStudentPublications
    @StudentID int
AS

IF exists (SELECT * FROM GucianStudent WHERE id = @StudentID) -- gucian
    (SELECT P.id, P.title, P.date, P.place, P.accepted, P.host
    From Publication P, ThesisHasPublication THP, GUCStudentRegisterThesis GSRT
    Where GSRT.sid = @StudentID AND GSRT.serial_no = THP.serialNO AND THP.pubid = P.id)

ELSE-- non gucian
    (SELECT P.id, P.title, P.date, P.place, P.accepted, P.host
    From Publication P, ThesisHasPublication THP, NonGUCStudentRegisterThesis GSRT
    Where GSRT.sid = @StudentID AND GSRT.serial_no = THP.serialNO AND THP.pubid = P.id);


GO

-- 4 e)
-- Add defense for a thesis.
CREATE PROCEDURE AddDefenseGucian
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @DefenseLocation varchar(15)
AS
INSERT INTO Defense
VALUES
    (@ThesisSerialNo, @DefenseDate, @DefenseLocation, NULL)

GO


-- 4 e)
-- Add defense for a thesis, for nonGucian students all courses’ grades should be greater than 50 percent.
CREATE PROCEDURE AddDefenseNonGucian
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @DefenseLocation varchar(15)
AS
Declare @sid int;
SELECT @sid = sid FROM NonGUCStudentRegisterThesis WHERE serial_no = @ThesisSerialNo

IF (not exists (select *
from NonGUCianStudentTakeCourse a, NonGUCStudentRegisterThesis b
where a.sid = b.sid and a.grade <= 50 and a.sid = @sid))
INSERT INTO Defense
VALUES
    (@ThesisSerialNo, @DefenseDate, @DefenseLocation, NULL)


GO

-- 4 f)
-- Add examiner to a defense with entered data.
CREATE PROCEDURE AddExaminer
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @ExaminerName varchar(20),
    @National bit,
    @fieldOfWork varchar(20)
AS
Declare @ExaminerID int;

SELECT @ExaminerID=id FROM Examiner WHERE name = @ExaminerName and fieldOfWork = @fieldOfWork and isNational = @National; 

-- INSERT INTO Examiner(name,fieldOfWork,isNational)
-- VALUES
--     (@ExaminerName, @fieldOfWork, @National)
-- DECLARE @ExaminerID INT = (SELECT MAX(id) FROM Examiner);

-- set @ExaminerID = @@IDENTITY;

INSERT INTO ExaminerEvaluateDefense
VALUES
    (@DefenseDate, @ThesisSerialNo, @ExaminerID, NULL)

GO

-- 4 g)
-- Cancel a Thesis if the evaluation of the last progress report is zero.
CREATE PROCEDURE CancelThesis
    @ThesisSerialNo int
AS

Declare @tmpeval int;

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

    IF (@tmpeval = 0)
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

    IF (@tmpeval = 0)
    BEGIN
        DELETE 
        FROM Thesis
        WHERE serialNumber = @ThesisSerialNo
    END
END


GO

-- 4 h)
-- Add a grade for a thesis.
CREATE PROCEDURE AddGrade
    @ThesisSerialNo int, @grade DECIMAL(3,2) -- assumed that an extra grade parameter is needed
AS
BEGIN
    Update Thesis
    SET grade = @grade
    WHERE serialNumber = @ThesisSerialNo
END


GO

-- 5 a)
-- Add a grade to a defense.
CREATE PROCEDURE AddDefenseGrade
    @ThesisSerialNo int ,
    @DefenseDate Datetime ,
    @grade decimal(3,2)
as
UPDATE Defense
 SET grade = @grade
 WHERE serialNumber = @ThesisSerialNo and date = @DefenseDate

GO

-- 5 b)
-- Add a comment to a defense.
CREATE PROCEDURE AddCommentsGrade -- TODO: no examiner id
    @ThesisSerialNo int ,
    @DefenseDate Datetime,
    @comments varchar(300)
as
UPDATE ExaminerEvaluateDefense
SET comment = @comments
 WHERE serialNo= @ThesisSerialNo and date = @DefenseDate

GO

-- 6 a)
-- Displays information of a profile from studentid
CREATE PROC viewMyProfile (@studentId INT) AS BEGIN
    IF EXISTS (SELECT * FROM PostGradUser
    INNER JOIN GucianStudent ON GucianStudent.id = PostGradUser.id
    WHERE PostGradUser.id = @studentId)
        SELECT * FROM PostGradUser
        INNER JOIN GucianStudent ON GucianStudent.id = PostGradUser.id
        WHERE PostGradUser.id = @studentId
    ELSE
        SELECT * FROM PostGradUser
        INNER JOIN NonGucianStudent ON NonGucianStudent.id = PostGradUser.id
        WHERE PostGradUser.id = @studentId
END;

GO

-- 6 b)
-- Edit information of a profile from studentid.
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

GO

-- 6 c)
-- Add undergradid to a profile with studentid.
CREATE PROC addUndergradID (@studentId INT, @undergradID VARCHAR(10)) AS BEGIN
    UPDATE GucianStudent SET undergradID = @undergradID WHERE id = @studentId;
END;

GO

-- 6 d)
-- View grades of a courage that a nongican takes.
CREATE PROC ViewCoursesGrades (@studentId INT) AS BEGIN
    SELECT Course.code, NonGUCianStudentTakeCourse.grade FROM NonGUCianStudentTakeCourse INNER JOIN Course ON NonGUCianStudentTakeCourse.cid = Course.id WHERE NonGUCianStudentTakeCourse.sid = @studentId;
END;

GO

-- 6 e)
-- View the payments of courses of a studentid.
CREATE PROC ViewCoursePaymentsInstall (@studentId INT) AS BEGIN
    SELECT NonGucianStudentPayForCourse.cid, Installment.* FROM NonGucianStudentPayForCourse
    INNER JOIN Installment ON Installment.paymentId = NonGucianStudentPayForCourse.paymentNo
    WHERE NonGucianStudentPayForCourse.sid = @studentId; 
END;

GO

-- 6 e)
-- View all the installments of a studentid.
CREATE PROC ViewThesisPaymentsInstall (@studentId INT) AS 

    IF EXISTS (SELECT * FROM GucianStudent WHERE GucianStudent.id = @studentId)
        SELECT * FROM Payment
        INNER JOIN Installment ON Installment.paymentId = Payment.id
        INNER JOIN Thesis ON Thesis.payment_id = Payment.id
        INNER JOIN GUCStudentRegisterThesis ON GUCStudentRegisterThesis.serial_no = Thesis.serialNumber
        WHERE GUCStudentRegisterThesis.sid = @studentId;
    ELSE
        SELECT * FROM Payment
        INNER JOIN Installment ON Installment.paymentId = Payment.id
        INNER JOIN Thesis ON Thesis.payment_id = Payment.id
        INNER JOIN NonGUCStudentRegisterThesis ON NonGUCStudentRegisterThesis.serial_no = Thesis.serialNumber
        WHERE NonGUCStudentRegisterThesis.sid = @studentId;
GO

-- 6 e)
-- View all the upcoming installments of a studentid.
CREATE PROC ViewUpcomingInstallments (@studentID INT) AS
    IF EXISTS (SELECT * FROM GucianStudent WHERE GucianStudent.id = @studentId)
        SELECT Installment.*, Payment.id FROM Installment
        INNER JOIN Payment ON Payment.id = Installment.paymentId
        INNER JOIN Thesis ON Thesis.payment_id = Payment.id
        INNER JOIN GUCStudentRegisterThesis ON GUCStudentRegisterThesis.serial_no=Thesis.serialNumber
        WHERE Installment.[date] >= GETDATE() AND GUCStudentRegisterThesis.sid = @studentID;
    ELSE
        SELECT Installment.*, Payment.id FROM Installment
        INNER JOIN Payment ON Payment.id = Installment.paymentId
        INNER JOIN Thesis ON Thesis.payment_id = Payment.id
        INNER JOIN NonGUCStudentRegisterThesis ON NonGUCStudentRegisterThesis.serial_no=Thesis.serialNumber
        WHERE Installment.[date] >= GETDATE() AND NonGUCStudentRegisterThesis.sid = @studentID;
GO

-- 6 e)
-- View all the missed installments of a studentid.
CREATE PROC ViewMissedInstallments (@studentID INT) AS
    IF EXISTS (SELECT * FROM GucianStudent WHERE GucianStudent.id = @studentId)    
        SELECT Installment.*, Payment.id FROM Installment
        INNER JOIN Payment ON Payment.id = Installment.paymentId
        INNER JOIN Thesis ON Thesis.payment_id = Payment.id
        INNER JOIN GUCStudentRegisterThesis ON GUCStudentRegisterThesis.serial_no=Thesis.serialNumber
        WHERE Installment.[date] < GETDATE() AND GUCStudentRegisterThesis.sid = @studentID;
    ELSE
        SELECT Installment.*, Payment.id FROM Installment
        INNER JOIN Payment ON Payment.id = Installment.paymentId
        INNER JOIN Thesis ON Thesis.payment_id = Payment.id
        INNER JOIN NonGUCStudentRegisterThesis ON NonGUCStudentRegisterThesis.serial_no=Thesis.serialNumber
        WHERE Installment.[date] < GETDATE() AND NonGUCStudentRegisterThesis.sid = @studentID;
GO

-- 6 f)
-- Create a progress report for a thesis with certain serial number.
CREATE PROC AddProgressReport (@thesisSerialNo int, @progressReportDate date) AS BEGIN
    
    DECLARE @supId INT;
    DECLARE @studId INT;
    DECLARE @noId INT;

    IF EXISTS (SELECT * FROM GUCStudentRegisterThesis WHERE GUCStudentRegisterThesis.serial_no = @thesisSerialNo) BEGIN
        SELECT @supId = GUCStudentRegisterThesis.supid FROM GUCStudentRegisterThesis WHERE GUCStudentRegisterThesis.serial_no = @thesisSerialNo;
        SELECT @studId = GUCStudentRegisterThesis.sid FROM GUCStudentRegisterThesis WHERE GUCStudentRegisterThesis.serial_no = @thesisSerialNo;
        SELECT @noId = MAX(GUCianProgressReport.[no]) FROM GUCianProgressReport WHERE GUCianProgressReport.thesisSerialNumber = @thesisSerialNo;
        IF @noId IS NULL BEGIN SET @noId = 0 END;
        INSERT INTO GUCianProgressReport (sid, thesisSerialNumber, date, supId, no) VALUES (@studId, @thesisSerialNo, @progressReportDate, @supId, @noId + 1);
    END;
    ELSE BEGIN
        SELECT @supId = NonGUCStudentRegisterThesis.supid FROM NonGUCStudentRegisterThesis WHERE NonGUCStudentRegisterThesis.serial_no = @thesisSerialNo;
        SELECT @studId = NonGUCStudentRegisterThesis.sid FROM NonGUCStudentRegisterThesis WHERE NonGUCStudentRegisterThesis.serial_no = @thesisSerialNo;
        SELECT @noId = MAX(NonGUCianProgressReport.[no]) FROM NonGUCianProgressReport WHERE NonGUCianProgressReport.thesisSerialNumber = @thesisSerialNo;
        IF @noId IS NULL BEGIN SET @noId = 0 END;
        INSERT INTO NonGUCianProgressReport (sid, thesisSerialNumber, date, supId, no) VALUES (@studId, @thesisSerialNo, @progressReportDate, @supId, @noId + 1);
    END;
END;

GO

-- 6 f)
-- Fill details of a progress report of a thesis with certain serial and no.
CREATE PROC FillProgressReport (@thesisSerialNo int, @progressReportNo int, @state int, @description varchar(200)) AS BEGIN
    IF EXISTS (SELECT * FROM GUCianProgressReport WHERE GUCianProgressReport.thesisSerialNumber = @thesisSerialNo AND GUCianProgressReport.no = @progressReportNo) BEGIN
        UPDATE GUCianProgressReport SET state = @state, report_description = @description WHERE thesisSerialNumber = @thesisSerialNo AND no = @progressReportNo;
    END;
    ELSE BEGIN
        UPDATE NonGUCianProgressReport SET state = @state, report_description = @description WHERE thesisSerialNumber = @thesisSerialNo AND no = @progressReportNo;
    END;
END;

GO

-- 6 g)
-- View progress report with certain number of a thesis.
CREATE PROC ViewEvalProgressReport (@thesisSerialNo int, @progressReportNo int) AS 
    IF EXISTS (SELECT * FROM GUCianProgressReport WHERE GUCianProgressReport.thesisSerialNumber = @thesisSerialNo AND GUCianProgressReport.no = @progressReportNo) BEGIN
        SELECT * FROM GUCianProgressReport WHERE GUCianProgressReport.thesisSerialNumber = @thesisSerialNo AND GUCianProgressReport.no = @progressReportNo;
    END;
    ELSE BEGIN
        SELECT * FROM NonGUCianProgressReport WHERE NonGUCianProgressReport.thesisSerialNumber = @thesisSerialNo AND NonGUCianProgressReport.no = @progressReportNo;
    END;

GO

-- 6 h)
-- Create new publication with given info.
CREATE PROC addPublication (@title varchar(50), @pubDate datetime, @host varchar(50), @place varchar(50), @accepted bit) AS BEGIN
    INSERT INTO Publication (title, [date], host, place, accepted) VALUES (@title, @pubDate, @host, @place, @accepted);
END;

GO

-- 6 i)
-- Link a publication to a thesis.
CREATE PROC linkPubThesis (@pubId int, @thesisSerialNo int) AS BEGIN
    INSERT INTO ThesisHasPublication (pubId, serialNo) VALUES (@pubId, @thesisSerialNo);
END;

GO