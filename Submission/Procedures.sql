-- 1 a)
-- Inserts student data into postgraduser table and then inserts the corresponding data into either the gucian or non gucian table depending on the gucian bit

GO

CREATE PROC StudentRegister

@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@faculty VARCHAR(20),
@Gucian BIT,
@email VARCHAR(50),
@address VARCHAR(50)

AS

IF @Gucian = 1

BEGIN
    INSERT INTO PostGradUser(email, password) VALUES(@email, @password);
    DECLARE @justInsertedId INT = (SELECT MAX(id) FROM PostGradUser);
    INSERT INTO GucianStudent(id, firstName, lastName, faculty, address) 
    VALUES(@justInsertedId, @first_name, @last_name, @faculty, @address);
END

ELSE

BEGIN
    INSERT INTO PostGradUser(email, password) VALUES(@email, @password);
    DECLARE @justInsertedId2 INT = (SELECT MAX(id) FROM PostGradUser);
    INSERT INTO NonGucianStudent(id, firstName, lastName, faculty, address) 
    VALUES(@justInsertedId2, @first_name, @last_name, @faculty, @address);
END

GO

-- Inserts supervisor data into postgraduser table and then inserts the corresponding data into the supervisor table 

GO

CREATE PROC SupervisorRegister

@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@faculty VARCHAR(20),
@email VARCHAR(50)

AS

INSERT INTO PostGradUser(email, password) VALUES(@email, @password);
DECLARE @justInsertedId INT = (SELECT MAX(id) FROM PostGradUser);
INSERT INTO Supervisor(id, name, faculty) 
VALUES(@justInsertedId, CONCAT(@first_name,' ',@last_name), @faculty);

GO


-- 2 a)
-- Checks if the given password matches the given id

GO

CREATE PROC userLogin

@ID INT,
@password VARCHAR(20),
@success BIT OUTPUT

AS

SET @success = 0;

IF EXISTS(SELECT * FROM PostGradUser WHERE id=@ID AND password=@password)
BEGIN
    SET @success = 1;
END

GO


-- 2 b)
-- Inserts a row into the Gucian or NonGucian phone number tables depending on if the id belongs to a gucian or non gucian

GO

CREATE PROC addMobile

@ID INT,
@mobile_number VARCHAR(20)

AS

IF EXISTS(SELECT * FROM GucianStudent WHERE id=@ID)

BEGIN
    INSERT INTO GUCStudentPhoneNumber(id,phone) VALUES(@ID, @mobile_number);
END

ELSE

BEGIN
    INSERT INTO NonGUCStudentPhoneNumber(id,phone) VALUES(@ID, @mobile_number);
END

GO



-- 3 a)
-- Displays a table listing all the details regarding the supervisors in the system using a select command

GO

CREATE PROC AdminListSup

AS

SELECT * FROM Supervisor;

GO

-- 3 b)
-- Displays a table listing all the details of a supervisor by matching the input id with the supervisor id in the select command

GO

CREATE PROC AdminViewSupervisorProfile

@supId INT

AS

SELECT * FROM Supervisor WHERE id=@supId;

GO

-- 3 c)
-- Displays a table listing all the theses in the system using a select command

GO

CREATE PROC AdminViewAllTheses

AS

SELECT * FROM Thesis

GO

-- 3 d)
-- Displays a table listing all theses whose end date is after the current date using a select command 

GO

CREATE PROC AdminViewOnGoingTheses

@thesesCount INT OUTPUT

AS

SET @thesesCount = (SELECT COUNT(serialNumber) FROM Thesis WHERE endDate > GETDATE() );

GO

-- 3 e)
-- Displays a table that matches the students, theses and supervisors and displays all their information.


GO

CREATE PROC AdminViewStudentThesisBySupervisor

AS

(SELECT DISTINCT GS.name, GT.title, CONCAT(GST.firstName,' ',GST.lastName) 
    FROM GUCStudentRegisterThesis GSRT
    INNER JOIN GucianStudent GST ON GSRT.sid=GST.id
    INNER JOIN Supervisor GS ON GSRT.supid=GS.id
    INNER JOIN Thesis GT ON GSRT.serial_no=GT.serialNumber
)
UNION
(SELECT DISTINCT NGS.name, NGT.title, CONCAT(NGST.firstName,' ',NGST.lastName) 
    FROM NonGUCStudentRegisterThesis NGSRT
    INNER JOIN NonGucianStudent NGST ON NGSRT.sid=NGST.id
    INNER JOIN Supervisor NGS ON NGSRT.supid=NGS.id
    INNER JOIN Thesis NGT ON NGSRT.serial_no=NGT.serialNumber
)

GO

-- 3 f)
-- Displays a table that lists all gucians enrolled in the course that has the id given as the input.

GO

CREATE PROC AdminListNonGucianCourse

@courseID INT

AS

SELECT DISTINCT CONCAT(NGS.firstName,' ',NGS.lastName),C.code,NGC.grade FROM NonGUCianStudentTakeCourse NGC INNER JOIN NonGucianStudent NGS ON NGC.sid = NGS.id
        INNER JOIN Course C ON NGC.cid = C.id WHERE NGC.cid=@courseID;

GO

-- 3 g)
-- Updates the number of thesis extensions by 1 for the thesis given in the input as the id.

GO

CREATE PROCEDURE AdminUpdateExtension
@ThesisSerialNo INT
AS
UPDATE Thesis 
SET noExtension = noExtension + 1
WHERE serialNumber = @ThesisSerialNo;

GO

-- 3 h)
-- Inserts a payment for the thesis regarding its amount, number of installments and fund percentage for the given thesis id

GO

CREATE PROCEDURE AdminIssueThesisPayment
@ThesisSerialNo INT, 
@amount DECIMAL(10, 2), 
@noOfInstallments INT, 
@fundPercentage DECIMAL(10, 2),
@success BIT OUTPUT
AS
BEGIN
    IF @ThesisSerialNo IN (SELECT serialNumber FROM Thesis)
    BEGIN
        INSERT INTO Payment(amount, no_Installments, fundPercentage)
        VALUES(@amount, @noOfInstallments, @fundPercentage);
        DECLARE @payment_id INT = (SELECT COUNT(*) 
        FROM Payment);

        UPDATE Thesis SET payment_id = @payment_id
        WHERE serialNumber = @ThesisSerialNo;
        SET @success = 1;
    END
    ELSE
    BEGIN
        SET @success = 0;
    END
END

GO

-- 3 i)
-- Displays a table that lists all the information of the given student based on their id

GO

CREATE PROCEDURE AdminViewStudentProfile
@sid INT
AS
BEGIN
    IF Exists(
        SELECT id FROM GUCianStudent
        WHERE id = @sid
    )
    BEGIN
        SELECT * FROM GUCianStudent
        WHERE id = @sid;
    END

    ELSE
    BEGIN
        SELECT * FROM NonGUCianStudent
        WHERE id = @sid;
    END
END

GO

-- 3 j)
-- Inserts installments to the given payment in the input with the given install start date

GO

CREATE PROCEDURE AdminIssueInstallPayment
@paymentID INT, 
@InstallStartDate DATE
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @no_Installments INT = (
        SELECT no_Installments 
        FROM Payment
        WHERE id = @paymentID
    );
    DECLARE @amount DECIMAL(10, 2) = (
        SELECT amount 
        FROM Payment
        WHERE id = @paymentID
    );
    WHILE @i <= @no_Installments
    BEGIN
        INSERT INTO Installment
        (paymentId, amount, date, done)
        VALUES(@paymentID, @amount/@no_Installments,
        DATEADD(MONTH, 6*@i, @InstallStartDate), 0);
        SET @i = @i + 1;
    END
END

GO

-- 3 k)
-- Displays all the accepted publications for every thesis in the datapush

GO

CREATE PROCEDURE AdminListAcceptPublication
AS
SELECT P.title, Th.*
FROM Publication P
INNER JOIN ThesisHasPublication TP
ON TP.pubid = P.id
INNER JOIN Thesis Th
ON Th.serialNumber = TP.serialNo
WHERE P.accepted = 1;

GO

-- 3 l)
-- Inserts courses for non gucians as well as linking students to given courses and adding each students grade

GO

CREATE PROCEDURE AddCourse
@courseCode VARCHAR(10),
@creditHrs INT,
@fees DECIMAL(10, 2)
AS
INSERT INTO Course(code, fees, creditHours)
VALUES(@courseCode, @fees, @creditHrs);

GO

CREATE PROCEDURE linkCourseStudent
@courseID INT,
@studentID INT
AS
INSERT INTO NonGUCianStudentTakeCourse(cid, sid)
VALUES(@courseID, @studentID);

GO

CREATE PROCEDURE addStudentCourseGrade
@courseID INT,
@studentID INT,
@grade DECIMAL(10, 2)
AS
UPDATE NonGUCianStudentTakeCourse
SET grade = @grade
WHERE cid = @courseID AND sid = @studentID;

GO

-- 3 m)
-- Displays the names of all supervisors and examiners that will attend a thesis defense on a given date

GO

CREATE PROCEDURE ViewExamSupDefense
@defenseDate datetime
AS
SELECT Ex.name
FROM Examiner Ex
INNER JOIN
ExaminerEvaluateDefense Eval
ON Ex.id = Eval.examinerId
WHERE Eval.[date] = @defenseDate
UNION
SELECT Sup.name
FROM Supervisor sup
INNER JOIN
GUCStudentRegisterThesis reg
ON sup.id = reg.supid
INNER JOIN
Thesis Th
ON Th.serialNumber = reg.serial_no
WHERE Th.defenseDate = @defenseDate
UNION
SELECT super.name
FROM Supervisor super
INNER JOIN
NonGUCStudentRegisterThesis regist
ON super.id = regist.supid
INNER JOIN
Thesis T
ON T.serialNumber = regist.serial_no
WHERE T.defenseDate = @defenseDate

GO

-- 4 a)
-- Inserts an evaluation for a given thesis progress report with a specific evaluation

GO

CREATE PROCEDURE EvaluateProgressReport
@supervisorID INT,
@thesisSerialNo INT,
@progressReportNo INT,
@evaluation INT
AS
BEGIN
    IF Exists(
        SELECT [no] FROM GUCianProgressReport
        WHERE thesisSerialNumber = @thesisSerialNo
        AND [no] = @progressReportNo
    )
    BEGIN
        UPDATE GUCianProgressReport
        SET eval = @evaluation
        WHERE thesisSerialNumber = @thesisSerialNo
        AND [no] = @progressReportNo;
    END

    ELSE
    BEGIN
        UPDATE NonGUCianProgressReport
        SET eval = @evaluation
        WHERE thesisSerialNumber = @thesisSerialNo
        AND [no] = @progressReportNo;
    END
END

GO

-- 4 b)
-- Display all students under a certain supervisor and the number of years they have spent writing their theses

GO

CREATE PROCEDURE ViewSupStudentsYears
@supervisorID INT
AS
SELECT gucian.firstName, gucian.lastName, Th.years
FROM GucianStudent gucian
INNER JOIN GUCStudentRegisterThesis GT
ON gucian.id = GT.sid
INNER JOIN Thesis Th
ON Th.serialNumber = GT.serial_no
WHERE GT.supid = @supervisorID
UNION
SELECT non.firstName, non.lastName, Th.years
FROM NonGucianStudent non
INNER JOIN GUCStudentRegisterThesis GT
ON non.id = GT.sid
INNER JOIN Thesis Th
ON Th.serialNumber = GT.serial_no
WHERE GT.supid = @supervisorID;

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