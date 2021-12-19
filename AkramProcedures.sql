-- (3-G) Update the number of thesis extension by 1
CREATE PROCEDURE AdminUpdateExtension
@ThesisSerialNo INT
AS
UPDATE Thesis 
SET noExtension = noExtension + 1
WHERE serialNumber = @ThesisSerialNo;
GO


-- (3-H) Issue a thesis payment
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

-- (3-I) view the profile of any student that contains 
-- all his/her information.
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

-- (3-J) Issue installments as per the number of installments for a
-- certain payment every six months starting from the entered date.
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

-- (3-K) List the title(s) of accepted publication(s) per thesis.
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

-- (3-L) Add courses and link courses to students.
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

-- (3-M) View examiners and supervisor(s) names attending a 
-- thesis defense taking place on a certain date.
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

-- (4-A) Evaluate a student’s progress report, 
-- and give evaluation value 0 to 3.
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

-- (4-B) View all my students’s names and years spent in the thesis.
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
