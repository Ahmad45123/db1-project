CREATE DATABASE PostGradT494934
GO

USE PostGradT494934
GO

CREATE TABLE PostGradUser
(
    id int PRIMARY KEY identity(1, 1),
    email varchar(50) NOT NULL,
    password varchar(30) NOT NULL
)


CREATE TABLE PostGradPhoneNumber(
phone VARCHAR(20),
id INT,
PRIMARY KEY(id, phone),
FOREIGN KEY(id) references PostGradUser ON DELETE CASCADE ON UPDATE CASCADE
)


CREATE TABLE Admin (   id int PRIMARY KEY
                           FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE
                   )
CREATE TABLE GucianStudent
(
    id int PRIMARY KEY
        FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
    firstName varchar(20),
    lastName varchar(20),
    TYPE varchar(3),
    faculty varchar(30),
    address varchar(50),
    GPA decimal(3, 2),
    undergradID int
)
CREATE TABLE NonGucianStudent
(
    id int PRIMARY KEY
        FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
    firstName varchar(20),
    lastName varchar(20),
    TYPE varchar(3),
    faculty varchar(30),
    address varchar(50),
    GPA decimal(3, 2),
)
CREATE TABLE GUCStudentPhoneNumber
(
    id int PRIMARY KEY
        FOREIGN KEY REFERENCES GucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    phone int
)
CREATE TABLE NonGUCStudentPhoneNumber
(
    id int PRIMARY KEY
        FOREIGN KEY REFERENCES NonGucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    phone int
)
CREATE TABLE Course
(
    id int PRIMARY KEY identity(1, 1),
    fees int,
    creditHours int,
    code varchar(10)
)
CREATE TABLE Supervisor
(
    id int PRIMARY KEY
        FOREIGN KEY REFERENCES PostGradUser,
    name varchar(20),
    faculty varchar(30)
);
CREATE TABLE Examiner
(
    id int PRIMARY KEY
        FOREIGN KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
    name varchar(20),
    fieldOfWork varchar(100),
    isNational BIT
)
CREATE TABLE Payment
(
    id int PRIMARY KEY identity(1, 1),
    amount decimal(7, 2),
    noOfInstallments int,
    fundPercentage decimal(5, 2)
)
CREATE TABLE Thesis
(
    serialNumber int PRIMARY KEY identity(1, 1),
    field varchar(20),
    TYPE varchar(3) NOT NULL,
    title varchar(100) NOT NULL,
    startDate date NOT NULL,
    endDate date NOT NULL,
    defenseDate date,
    years AS (year(endDate) - year(startDate)),
    grade decimal(5, 2),
    payment_id int
        FOREIGN KEY REFERENCES payment ON DELETE CASCADE ON UPDATE CASCADE,
    noOfExtensions int
)
CREATE TABLE Publication
(
    id int PRIMARY KEY identity(1, 1),
    title varchar(100) NOT NULL,
    dateOfPublication date,
    place varchar(100),
    accepted BIT,
    HOST varchar(100)
);
CREATE TABLE Defense
(
    serialNumber int,
    date datetime,
    LOCATION varchar(15),
    grade decimal(5, 2),
    PRIMARY KEY
    (
        serialNumber,
        date
    ),
    FOREIGN KEY (serialNumber) REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE
)
CREATE TABLE GUCianProgressReport
(
    sid int
        FOREIGN KEY REFERENCES GUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    NO int,
    date datetime,
    eval int,
    state int,
    description varchar(200),
    thesisSerialNumber int
        FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
    supid int
        FOREIGN KEY REFERENCES Supervisor,
    PRIMARY KEY
    (
        sid,
        NO
    )
)
CREATE TABLE NonGUCianProgressReport
(
    sid int
        FOREIGN KEY REFERENCES NonGUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    NO int,
    date datetime,
    eval int,
    state int,
    description varchar(200),
    thesisSerialNumber int
        FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
    supid int
        FOREIGN KEY REFERENCES Supervisor,
    PRIMARY KEY
    (
        sid,
        NO
    )
)
CREATE TABLE Installment
(
    date datetime,
    paymentId int
        FOREIGN KEY REFERENCES Payment ON DELETE CASCADE ON UPDATE CASCADE,
    amount decimal(8, 2),
    done bit,
    PRIMARY KEY
    (
        date,
        paymentId
    )
)
CREATE TABLE NonGucianStudentPayForCourse
(
    sid int
        FOREIGN KEY REFERENCES NonGucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    paymentNo int
        FOREIGN KEY REFERENCES Payment ON DELETE CASCADE ON UPDATE CASCADE,
    cid int
        FOREIGN KEY REFERENCES Course ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY
    (
        sid,
        paymentNo,
        cid
    )
)
CREATE TABLE NonGucianStudentTakeCourse
(
    sid int
        FOREIGN KEY REFERENCES NonGUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    cid int
        FOREIGN KEY REFERENCES Course ON DELETE CASCADE ON UPDATE CASCADE,
    grade decimal(5, 2),
    PRIMARY KEY
    (
        sid,
        cid
    )
)
CREATE TABLE GUCianStudentRegisterThesis
(
    sid int
        FOREIGN KEY REFERENCES GUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    supid int
        FOREIGN KEY REFERENCES Supervisor,
    serial_no int
        FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY key
    (
        sid,
        supid,
        serial_no
    )
)
CREATE TABLE NonGUCianStudentRegisterThesis
(
    sid int
        FOREIGN KEY REFERENCES NonGUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    supid int
        FOREIGN KEY REFERENCES Supervisor,
    serial_no int
        FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY
    (
        sid,
        supid,
        serial_no
    )
)
CREATE TABLE ExaminerEvaluateDefense
(
    date datetime,
    serialNo int,
    examinerId int
        FOREIGN KEY REFERENCES Examiner ON DELETE CASCADE ON UPDATE CASCADE,
    COMMENT varchar(300),
    PRIMARY key
    (
        date,
        serialNo,
        examinerId
    ),
    FOREIGN KEY
    (
        serialNo,
        date
    ) REFERENCES Defense
    (
        serialNumber,
        date
    ) ON DELETE CASCADE ON UPDATE CASCADE
)
CREATE TABLE ThesisHasPublication
(
    serialNo int
        FOREIGN KEY REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
    pubid int
        FOREIGN KEY REFERENCES Publication ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY key
    (
        serialNo,
        pubid
    )
)
GO
CREATE proc studentRegister
    @first_name varchar(20),
    @last_name varchar(20),
    @password varchar(20),
    @faculty varchar(20),
    @Gucian bit,
    @email varchar(50),
    @address varchar(50)
AS
BEGIN
    INSERT INTO PostGradUser
    (
        email,
        password
    )
    VALUES
    (@email, @password)
    DECLARE @id int
    SELECT @id = SCOPE_IDENTITY()
    if (@Gucian = 1)
        INSERT INTO GucianStudent
        (
            id,
            firstName,
            lastName,
            faculty,
            address
        )
        VALUES
        (@id, @first_name, @last_name, @faculty, @address)
    ELSE
        INSERT INTO NonGucianStudent
        (
            id,
            firstName,
            lastName,
            faculty,
            address
        )
        VALUES
        (@id, @first_name, @last_name, @faculty, @address)
END
GO
CREATE proc supervisorRegister
    @first_name varchar(20),
    @last_name varchar(20),
    @password varchar(20),
    @faculty varchar(20),
    @email varchar(50)
AS
BEGIN
    INSERT INTO PostGradUser
    (
        email,
        password
    )
    VALUES
    (@email, @password)
    DECLARE @id int
    SELECT @id = SCOPE_IDENTITY()
    DECLARE @name varchar(50)
    SET @name = CONCAT(@first_name, @last_name)
    INSERT INTO Supervisor
    (
        id,
        name,
        faculty
    )
    VALUES
    (@id, @name, @faculty)
END
GO
CREATE proc userLogin
    @email varchar(50),
    @password varchar(20),
    @id int out
as
begin
    if not exists
    (
        select *
        from PostGradUser
        where email = @email
              and password = @password
    )
        set @id = -1
    else
        select @id = id
        from PostGradUser
        where email = @email
              and password = @password;
end
GO
CREATE proc addMobile
    @ID varchar(20),
    @mobile_number varchar(20)
AS
BEGIN
    IF @ID IS NOT NULL
       AND @mobile_number IS NOT NULL
    BEGIN --check Gucian student or not
        if (exists (SELECT * FROM GucianStudent WHERE id = @ID))
            INSERT INTO GUCStudentPhoneNumber
            VALUES
            (@ID, @mobile_number)
        if (exists (SELECT * FROM NonGucianStudent WHERE id = @ID))
            INSERT INTO NonGUCStudentPhoneNumber
            VALUES
            (@ID, @mobile_number)
    END
END
GO
CREATE Proc AdminListSup
AS
SELECT u.id,
       u.email,
       u.password,
       s.name,
       s.faculty
FROM PostGradUser u
    INNER JOIN Supervisor s
        ON u.id = s.id
GO
CREATE Proc AdminViewSupervisorProfile @supId int
AS
SELECT u.id,
       u.email,
       u.password,
       s.name,
       s.faculty
FROM PostGradUser u
    INNER JOIN Supervisor s
        ON u.id = s.id
WHERE @supId = s.id
GO
CREATE Proc AdminViewAllTheses
AS
SELECT serialNumber,
       field,
       TYPE,
       title,
       startDate,
       endDate,
       defenseDate,
       years,
       grade,
       payment_id,
       noOfExtensions
FROM Thesis
GO
CREATE Proc AdminViewOnGoingTheses @thesesCount int OUTPUT
AS
SELECT @thesesCount = Count(*)
FROM Thesis
WHERE endDate > Convert(Date, CURRENT_TIMESTAMP)
GO
CREATE Proc AdminViewStudentThesisBySupervisor
AS
SELECT s.name,
       t.title,
       gs.firstName
FROM Thesis t
    INNER JOIN GUCianStudentRegisterThesis sr
        ON t.serialNumber = sr.serial_no
    INNER JOIN Supervisor s
        ON s.id = sr.supid
    INNER JOIN GucianStudent gs
        ON sr.sid = gs.id
WHERE t.endDate > Convert(Date, CURRENT_TIMESTAMP)
UNION
SELECT s.name,
       t.title,
       gs.firstName
FROM Thesis t
    INNER JOIN NonGUCianStudentRegisterThesis sr
        ON t.serialNumber = sr.serial_no
    INNER JOIN Supervisors
        ON s.id = sr.supid
    INNER JOIN NonGucianStudent gs
        ON sr.sid = gs.id
WHERE t.endDate > Convert(Date, CURRENT_TIMESTAMP)
GO
GO
CREATE Proc AdminListNonGucianCourse @courseID int
AS
if (exists (SELECT * FROM Course WHERE id = @courseID))
    SELECT ng.firstName,
           ng.lastName,
           c.code,
           n.grade
    FROM NonGucianStudentTakeCourse n
        INNER JOIN Course c
            ON n.cid = c.id
        INNER JOIN NonGucianStudent ng
            ON ng.id = n.sid
    WHERE n.cid = @courseID
GO
CREATE Proc AdminUpdateExtension @ThesisSerialNo int
AS
if (exists (SELECT * FROM Thesis WHERE serialNumber = @ThesisSerialNo))
BEGIN
    DECLARE @noOfExtensions int
    SELECT @noOfExtensions = noOfExtensions
    FROM Thesis
    WHERE serialNumber = @ThesisSerialNo
    UPDATE Thesis
    SET noOfExtensions = @noOfExtensions + 1
    WHERE serialNumber = @ThesisSerialNo
END
ELSE BEGIN;
THROW 51001, 'Thesis Serial Number does not exist', 51002;
END
GO

CREATE Proc AdminIssueThesisPayment
    @ThesisSerialNo int,
    @amount decimal,
    @noOfInstallments int,
    @fundPercentage decimal
AS
if (exists (SELECT * FROM Thesis WHERE serialNumber = @ThesisSerialNo))
BEGIN
    INSERT INTO Payment
    (
        amount,
        noOfInstallments,
        fundPercentage
    )
    VALUES
    (@amount, @noOfInstallments, @fundPercentage)
    DECLARE @id int
    SELECT @id = SCOPE_IDENTITY()
    UPDATE Thesis
    SET payment_id = @id
    WHERE serialNumber = @ThesisSerialNo
END
ELSE
BEGIN;
THROW 51001, 'Thesis Serial Number does not exist', 51002
END
GO
CREATE Proc AdminViewStudentProfile @sid int
AS
if (exists (SELECT * FROM GucianStudent WHERE id = @sid))
    SELECT u.id,
           u.email,
           u.password,
           s.firstName,
           s.lastName,
           s.type,
           s.faculty,
           s.address,
           s.address,
           s.GPA
    FROM PostGradUser u
        INNER JOIN GucianStudent s
            ON u.id = s.id
    WHERE @sid = s.id
ELSE if (exists (SELECT * FROM NonGucianStudent WHERE id = @sid))
    SELECT u.id,
           u.email,
           u.password,
           s.firstName,
           s.lastName,
           s.type,
           s.faculty,
           s.address,
           s.address,
           s.GPA
    FROM PostGradUser u
        INNER JOIN NonGucianStudent s
            ON u.id = s.id
    WHERE @sid = s.id
GO
CREATE Proc AdminIssueInstallPayment
    @paymentID int,
    @InstallStartDate date
AS
if (exists (SELECT * FROM Payment WHERE id = @paymentID))
BEGIN
    DECLARE @numOfInst int
    SELECT @numOfInst = noOfInstallments
    FROM Payment
    WHERE id = @paymentID
    DECLARE @payAmount int
    SELECT @payAmount = amount
    FROM Payment
    WHERE id = @paymentID
    DECLARE @Counter INT
    SET @Counter = 1
    DECLARE @instdate date
    SET @instdate = @InstallStartDate
    DECLARE @instAmount int
    SET @instAmount = @payAmount / @numOfInst
    WHILE (@counter <= @numOfInst)
    BEGIN
        if (@counter = 1)
            INSERT INTO Installment
            (
                date,
                paymentId,
                amount,
                done
            )
            VALUES
            (@InstallStartDate, @paymentID, @instAmount, 0)
        ELSE
        BEGIN
            SET @instdate = DATEADD(MM, 6, @instdate);
            INSERT INTO Installment
            (
                date,
                paymentId,
                amount,
                done
            )
            VALUES
            (@instdate, @paymentID, @instAmount, 0)
        END
        SET @counter = @counter + 1
    END
END
ELSE
BEGIN;
THROW 51001, 'Payment ID does not exist', 51002;
END
GO
CREATE Proc AdminListAcceptPublication
AS
SELECT t.serialNumber,
       p.title
FROM ThesisHasPublication tp
    INNER JOIN Thesis t
        ON tp.serialNo = t.serialNumber
    INNER JOIN Publication p
        ON p.id = tp.pubid
WHERE p.accepted = 1
GO
CREATE Proc AddCourse
    @courseCode varchar(10),
    @creditHrs int,
    @fees decimal
AS
INSERT INTO Course
VALUES
(@fees, @creditHrs, @courseCode)
GO
CREATE Proc linkCourseStudent
    @courseID int,
    @studentID int
AS
if (exists (SELECT * FROM Course)
    AND exists
(
    SELECT *
    FROM NonGucianStudent
    WHERE id = @studentID
)
   )
    INSERT INTO NonGucianStudentTakeCourse
    (
        sid,
        cid,
        grade
    )
    VALUES
    (@studentID, @courseID, NULL)
GO
CREATE Proc addStudentCourseGrade
    @courseID int,
    @studentID int,
    @grade decimal
AS
if (exists
(
    SELECT *
    FROM NonGucianStudentTakeCourse
    WHERE sid = @studentID
          AND cid = @courseID
)
   )
    UPDATE NonGucianStudentTakeCourse
    SET grade = @grade
    WHERE cid = @courseID
          AND sid = @studentID
GO
CREATE Proc ViewExamSupDefense @defenseDate datetime
AS
SELECT s.serial_no,
       ee.date,
       e.name,
       sup.name
FROM ExaminerEvaluateDefense ee
    INNER JOIN examiner e
        ON ee.examinerId = e.id
    INNER JOIN GUCianStudentRegisterThesis s
        ON ee.serialNo = s.serial_no
    INNER JOIN Supervisor sup
        ON sup.id = s.supid
GO
CREATE Proc EvaluateProgressReport
    @supervisorID int,
    @thesisSerialNo int,
    @progressReportNo int,
    @evaluation int
AS
if (exists (SELECT * FROM Thesis WHERE serialNumber = @thesisSerialNo)
    AND @evaluation in ( 0, 1, 2, 3 )
   )
BEGIN
    if (exists
    (
        SELECT *
        FROM GUCianStudentRegisterThesis
        WHERE serial_no = @thesisSerialNo
              AND supid = @supervisorID
    )
       )
    BEGIN
        DECLARE @gucSid int
        SELECT @gucSid = sid
        FROM GUCianStudentRegisterThesis
        WHERE serial_no = @thesisSerialNo
        UPDATE GUCianProgressReport
        SET eval = @evaluation
        WHERE sid = @gucSid
              AND thesisSerialNumber = @thesisSerialNo
              AND NO = @progressReportNo
    END
    ELSE if (exists
         (
             SELECT *
             FROM NonGUCianStudentRegisterThesis
             WHERE serial_no = @thesisSerialNo
                   AND supid = @supervisorID
         )
            )
    BEGIN
        DECLARE @nonGucSid int
        SELECT @nonGucSid = sid
        FROM NonGUCianStudentRegisterThesis
        WHERE serial_no = @thesisSerialNo
        UPDATE NonGUCianProgressReport
        SET eval = @evaluation
        WHERE sid = @nonGucSid
              AND thesisSerialNumber = @thesisSerialNo
              AND NO = @progressReportNo
    END
END
GO
CREATE Proc ViewSupStudentsYears @supervisorID int
AS
if (exists (SELECT * FROM Supervisor WHERE id = @supervisorID))
BEGIN
    SELECT s.firstName,
           s.lastName,
           t.years
    FROM GUCianStudentRegisterThesis sr
        INNER JOIN GucianStudent s
            ON sr.sid = s.id
        INNER JOIN Thesis t
            ON t.serialNumber = sr.serial_no
    UNION
    SELECT s.firstName,
           s.lastName,
           t.years
    FROM NonGUCianStudentRegisterThesis sr
        INNER JOIN NonGucianStudent s
            ON sr.sid = s.id
        INNER JOIN Thesis t
            ON t.serialNumber = sr.serial_no
END
GO
CREATE Proc SupViewProfile @supervisorID int
AS
if (exists (SELECT * FROM Supervisor WHERE id = @supervisorID))
BEGIN
    SELECT u.id,
           u.email,
           u.password,
           s.name,
           s.faculty
    FROM PostGradUser u
        INNER JOIN Supervisor s
            ON u.id = s.id
END
GO
---------------------------------------
CREATE proc UpdateSupProfile
    @supervisorID int,
    @name varchar(20),
    @faculty varchar(20)
AS
UPDATE Supervisor
SET name = @name,
    faculty = @faculty
WHERE id = @supervisorID
GO

CREATE proc ViewAStudentPublications @StudentID int
AS
SELECT DISTINCT P.*
FROM GUCianStudentRegisterThesis GUC
    INNER JOIN Thesis T
        ON GUC.serial_no = T.serialNumber
    INNER JOIN ThesisHasPublication TP
        ON T.serialNumber = TP.serialNo
    INNER JOIN Publication P
        ON P.id = TP.pubid
WHERE GUC.sid = @StudentID
UNION ALL
SELECT DISTINCT P.*
FROM NonGUCianStudentRegisterThesis NON
    INNER JOIN Thesis T
        ON NON.serial_no = T.serialNumber
    INNER JOIN ThesisHasPublication TP
        ON T.serialNumber = TP.serialNo
    INNER JOIN Publication P
        ON P.id = TP.pubid
WHERE NON.sid = @StudentID
GO


CREATE proc AddDefenseGucian
    @ThesisSerialNo int,
    @DefenseDate Datetime,
    @DefenseLocation varchar(15)
AS
INSERT INTO Defense
VALUES
(@ThesisSerialNo, @DefenseDate, @DefenseLocation, NULL)
GO
CREATE proc AddDefenseNonGucian
    @ThesisSerialNo int,
    @DefenseDate Datetime,
    @DefenseLocation varchar(15)
AS
DECLARE @idOfStudent int
SELECT @idOfStudent = sid
FROM NonGUCianStudentRegisterThesis
WHERE serial_no = @ThesisSerialNo
if (NOT exists
(
    SELECT grade
    FROM NonGucianStudentTakeCourse
    WHERE sid = @idOfStudent
          AND grade < 50
)
   )
BEGIN
    INSERT INTO Defense
    VALUES
    (@ThesisSerialNo, @DefenseDate, @DefenseLocation, NULL)
END
GO
CREATE proc AddExaminer
    @ThesisSerialNo int,
    @DefenseDate Datetime,
    @ExaminerName varchar(20),
    @Password varchar(30),
    @National bit,
    @fieldOfWork varchar(20)
AS
INSERT INTO PostGradUser
VALUES
(@ExaminerName, @Password)
DECLARE @id int
SET @id = SCOPE_IDENTITY()
INSERT INTO Examiner
VALUES
(@id, @ExaminerName, @fieldOfWork, @National)
INSERT INTO ExaminerEvaluateDefense
VALUES
(@DefenseDate, @ThesisSerialNo, @id, NULL)
GO
CREATE proc CancelThesis @ThesisSerialNo int
AS
if (exists
(
    SELECT *
    FROM GUCianProgressReport
    WHERE thesisSerialNumber = @ThesisSerialNo
)
   )
BEGIN
    DECLARE @gucianEval int
    SET @gucianEval =
    (
        SELECT top 1
            eval
        FROM GUCianProgressReport
        WHERE thesisSerialNumber = @ThesisSerialNo
        ORDER BY NO DESC
    )
    if (@gucianEval = 0)
    BEGIN
        DELETE FROM Thesis
        WHERE serialNumber = @ThesisSerialNo
    END
END
ELSE
BEGIN
    DECLARE @nonGucianEval int
    SET @nonGucianEval =
    (
        SELECT top 1
            eval
        FROM NonGUCianProgressReport
        WHERE thesisSerialNumber = @ThesisSerialNo
        ORDER BY NO DESC
    )
    if (@nonGucianEval = 0)
    BEGIN
        DELETE FROM Thesis
        WHERE serialNumber = @ThesisSerialNo
    END
END
GO
CREATE proc AddGrade @ThesisSerialNo int
AS
DECLARE @grade decimal(5, 2)
SELECT @grade = grade
FROM Defense
WHERE serialNumber = @ThesisSerialNo
UPDATE Thesis
SET grade = @grade
WHERE serialNumber = @ThesisSerialNo
GO
CREATE proc AddDefenseGrade
    @ThesisSerialNo int,
    @DefenseDate Datetime,
    @grade decimal(5, 2)
AS
UPDATE Defense
SET grade = @grade
WHERE serialNumber = @ThesisSerialNo
      AND date = @DefenseDate
GO
CREATE proc AddCommentsGrade
    @ThesisSerialNo int,
    @DefenseDate Datetime,
    @comments varchar(300)
AS
UPDATE ExaminerEvaluateDefense
SET COMMENT = @comments
WHERE serialNo = @ThesisSerialNo
      AND date = @DefenseDate
GO
CREATE proc viewMyProfile @studentId int
AS
if (exists (SELECT * FROM GucianStudent WHERE id = @studentId))
BEGIN
    SELECT G.*,
           P.email
    FROM GucianStudent G
        INNER JOIN PostGradUser P
            ON G.id = P.id
    WHERE G.id = @studentId
END
ELSE
BEGIN
    SELECT N.*,
           P.email
    FROM NonGucianStudent N
        INNER JOIN PostGradUser P
            ON N.id = P.id
    WHERE N.id = @studentId
END
GO
CREATE proc editMyProfile
    @studentID int,
    @firstName varchar(20),
    @lastName varchar(20),
    @password varchar(30),
    @email varchar(50),
    @address varchar(50),
    @type varchar(3)
AS
UPDATE GucianStudent
SET firstName = @firstName,
    lastName = @lastName,
    address = @address,
    TYPE = @type
WHERE id = @studentID
UPDATE NonGucianStudent
SET firstName = @firstName,
    lastName = @lastName,
    address = @address,
    TYPE = @type
WHERE id = @studentID
UPDATE PostGradUser
SET email = @email,
    password = @password
WHERE id = @studentID
GO
CREATE proc addUndergradID
    @studentID int,
    @undergradID varchar(10)
AS
UPDATE GucianStudent
SET undergradID = @undergradID
WHERE id = @studentID
GO
CREATE PROC ViewCoursesGrades (@studentId INT) AS BEGIN
    SELECT Course.code, NonGUCianStudentTakeCourse.grade, Course.creditHours
    FROM NonGUCianStudentTakeCourse INNER JOIN 
    Course ON NonGUCianStudentTakeCourse.cid = Course.id 
    WHERE NonGUCianStudentTakeCourse.sid = @studentId;
END;
GO
CREATE proc ViewCoursePaymentsInstall @studentID int
AS
SELECT P.id AS 'Payment Number',
       P.amount AS 'Amount of Payment',
       P.fundPercentage AS 'Percentage of
fund for payment',
       P.noOfInstallments AS 'Number of installments',
       I.amount AS 'Installment Amount',
       I.date AS 'Installment date',
       I.done AS 'Installment done or not'
FROM NonGucianStudentPayForCourse NPC
    INNER JOIN Payment P
        ON NPC.paymentNo = P.id
           AND NPC.sid = @studentID
    INNER JOIN Installment I
        ON I.paymentId = P.id
GO
CREATE proc ViewThesisPaymentsInstall @studentID int
AS
SELECT P.id AS 'Payment Number',
       P.amount AS 'Amount of Payment',
       P.fundPercentage AS 'Fund',
       P.noOfInstallments AS 'Number of installments',
       I.amount AS 'Installment amount',
       I.date AS 'Installment date',
       I.done AS 'Installment done or not'
FROM GUCianStudentRegisterThesis G
    INNER JOIN Thesis T
        ON G.serial_no = T.serialNumber
           AND G.sid = @studentID
    INNER JOIN Payment P
        ON T.payment_id = P.id
    INNER JOIN Installment I
        ON I.paymentId = P.id
UNION
SELECT P.id AS 'Payment Number',
       P.amount AS 'Amount of Payment',
       P.fundPercentage AS 'Fund',
       P.noOfInstallments AS 'Number of installments',
       I.amount AS 'Installment amount',
       I.date AS 'Installment date',
       I.done AS 'Installment done or not'
FROM NonGUCianStudentRegisterThesis NG
    INNER JOIN Thesis T
        ON NG.serial_no = T.serialNumber
           AND NG.sid = @studentID
    INNER JOIN Payment P
        ON T.payment_id = P.id
    INNER JOIN Installment I
        ON I.paymentId = P.id
GO
CREATE proc ViewUpcomingInstallments @studentID int
AS
SELECT I.date AS 'Date of Installment',
       I.amount AS 'Amount'
FROM Installment I
    INNER JOIN NonGucianStudentPayForCourse NPC
        ON I.paymentId = NPC.paymentNo
           AND NPC.sid = @studentID
           AND I.date > CURRENT_TIMESTAMP
UNION
SELECT I.date AS 'Date of Installment',
       I.amount AS 'Amount'
FROM Thesis T
    INNER JOIN Payment P
        ON T.payment_id = P.id
    INNER JOIN Installment I
        ON I.paymentId = P.id
    INNER JOIN GUCianStudentRegisterThesis G
        ON G.serial_no = T.serialNumber
           AND G.sid = @studentID
WHERE I.date > CURRENT_TIMESTAMP
UNION
SELECT I.date AS 'Date of Installment',
       I.amount AS 'Amount'
FROM Thesis T
    INNER JOIN Payment P
        ON T.payment_id = P.id
    INNER JOIN Installment I
        ON I.paymentId = P.id
    INNER JOIN NonGUCianStudentRegisterThesis G
        ON G.serial_no = T.serialNumber
           AND G.sid = @studentID
WHERE I.date > CURRENT_TIMESTAMP
GO
CREATE proc ViewMissedInstallments @studentID int
AS
SELECT I.date AS 'Date of Installment',
       I.amount AS 'Amount'
FROM Installment I
    INNER JOIN NonGucianStudentPayForCourse NPC
        ON I.paymentId = NPC.paymentNo
           AND NPC.sid = @studentID
           AND I.date < CURRENT_TIMESTAMP
           AND I.done = '0'
UNION
SELECT I.date AS 'Date of Installment',
       I.amount AS 'Amount'
FROM Thesis T
    INNER JOIN Payment P
        ON T.payment_id = P.id
    INNER JOIN Installment I
        ON I.paymentId = P.id
    INNER JOIN GUCianStudentRegisterThesis G
        ON G.serial_no = T.serialNumber
           AND G.sid = @studentID
WHERE I.date < CURRENT_TIMESTAMP
      AND I.done = '0'
UNION
SELECT I.date AS 'Date of Installment',
       I.amount AS 'Amount'
FROM Thesis T
    INNER JOIN Payment P
        ON T.payment_id = P.id
    INNER JOIN Installment I
        ON I.paymentId = P.id
    INNER JOIN NonGUCianStudentRegisterThesis G
        ON G.serial_no = T.serialNumber
           AND G.sid = @studentID
WHERE I.date < CURRENT_TIMESTAMP
      AND I.done = '0'
GO
CREATE proc AddProgressReport
    @thesisSerialNo int,
    @progressReportDate date,
    @studentID int,
    @progressReportNo int
AS
DECLARE @gucian int
if (exists (SELECT id FROM GucianStudent WHERE id = @studentID))
BEGIN
    SET @gucian = '1'
END
ELSE
BEGIN
    SET @gucian = '0'
END
IF (@gucian = '1')
BEGIN
    INSERT INTO GUCianProgressReport
    VALUES
    (@studentID, @progressReportNo, @progressReportDate, NULL, NULL, NULL, @thesisSerialNo, NULL)
END
ELSE
BEGIN
    INSERT INTO NonGUCianProgressReport
    VALUES
    (@studentID, @progressReportNo, @progressReportDate, NULL, NULL, NULL, @thesisSerialNo, NULL)
END
GO
CREATE proc FillProgressReport
    @thesisSerialNo int,
    @progressReportNo int,
    @state int,
    @description varchar(200),
    @studentID int
AS
DECLARE @gucian bit
if (exists (SELECT * FROM GucianStudent WHERE id = @studentID))
BEGIN
    SET @gucian = '1'
END
ELSE
BEGIN
    SET @gucian = '0'
END
IF (@gucian = '1')
BEGIN
    UPDATE GUCianProgressReport
    SET state = @state,
        description = @description,
        date = CURRENT_TIMESTAMP
    WHERE thesisSerialNumber = @thesisSerialNo
          AND sid = @studentID
          AND NO = @progressReportNo
END
ELSE
BEGIN
    UPDATE NonGUCianProgressReport
    SET state = @state,
        description = @description,
        date = CURRENT_TIMESTAMP
    WHERE thesisSerialNumber = @thesisSerialNo
          AND sid = @studentID
          AND NO = @progressReportNo
END
GO
CREATE proc ViewEvalProgressReport
    @thesisSerialNo int,
    @progressReportNo int,
    @studentID int
AS
SELECT eval
FROM GUCianProgressReport
WHERE sid = @studentID
      AND thesisSerialNumber = @thesisSerialNo
      AND NO = @progressReportNo
UNION
SELECT eval
FROM NonGUCianProgressReport
WHERE sid = @studentID
      AND thesisSerialNumber = @thesisSerialNo
      AND NO = @progressReportNo
GO
CREATE proc addPublication
    @title varchar(50),
    @pubDate datetime,
    @host varchar(50),
    @place varchar(50),
    @accepted bit
AS
INSERT INTO Publication
VALUES
(@title, @pubDate, @place, @accepted, @host)
GO
CREATE proc linkPubThesis
    @PubID int,
    @thesisSerialNo int,
    @success BIT OUTPUT
AS
BEGIN
    IF EXISTS(SELECT * FROM ThesisHasPublication WHERE serialNo = @thesisSerialNo AND pubid = @PubID)
    BEGIN
        SET @success = 0;
    END
    ELSE BEGIN
        INSERT INTO ThesisHasPublication
        VALUES (@thesisSerialNo, @PubID);
        SET @success = 1;
    END
END
GO

CREATE TRIGGER deleteSupervisor
ON Supervisor
INSTEAD OF DELETE
AS
DELETE FROM GUCianProgressReport
WHERE supid in (
                   SELECT id FROM deleted
               )
DELETE FROM NonGUCianProgressReport
WHERE supid in (
                   SELECT id FROM deleted
               )
DELETE FROM GUCianStudentRegisterThesis
WHERE supid in (
                   SELECT id FROM deleted
               )
DELETE FROM NonGUCianStudentRegisterThesis
WHERE supid in (
                   SELECT id FROM deleted
               )
DELETE FROM Supervisor
WHERE id in (
                SELECT id FROM deleted
            )
DELETE FROM PostGradUser
WHERE id in (
                SELECT id FROM deleted
            )
GO

CREATE proc examinerRegister
    @first_name varchar(20),
    @last_name varchar(20),
    @password varchar(20),
    @email varchar(50),
    @fieldOfWork varchar(50),
    @isNational BIT
AS
BEGIN
    INSERT INTO PostGradUser
    (
        email,
        password
    )
    VALUES
    (@email, @password)
    DECLARE @id int
    SELECT @id = SCOPE_IDENTITY()
    DECLARE @name varchar(50)
    SET @name = CONCAT(@first_name, @last_name)
    INSERT INTO Examiner VALUES
    (@id, @name, @fieldOfWork, @isNational);
END
GO

CREATE PROC examinerListData (@examId INT) AS BEGIN
    SELECT Thesis.serialNumber, Thesis.title, (GucianStudent.firstName + ' ' + GucianStudent.lastName) AS 'Name' FROM ExaminerEvaluateDefense
        INNER JOIN Thesis ON ExaminerEvaluateDefense.serialNo = Thesis.serialNumber
        INNER JOIN GUCianStudentRegisterThesis ON GUCianStudentRegisterThesis.serial_no = Thesis.serialNumber
        INNER JOIN GucianStudent ON GucianStudent.id = GUCianStudentRegisterThesis.sid
        WHERE ExaminerEvaluateDefense.examinerId = @examId
    UNION
    SELECT Thesis.serialNumber, Thesis.title, (NonGucianStudent.firstName + ' ' + NonGucianStudent.lastName) AS 'Name' FROM ExaminerEvaluateDefense
        INNER JOIN Thesis ON ExaminerEvaluateDefense.serialNo = Thesis.serialNumber
        INNER JOIN NonGUCianStudentRegisterThesis ON NonGUCianStudentRegisterThesis.serial_no = Thesis.serialNumber
        INNER JOIN NonGucianStudent ON NonGucianStudent.id = NonGUCianStudentRegisterThesis.sid
        WHERE ExaminerEvaluateDefense.examinerId = @examId;
END
GO

CREATE PROC listSupervisors (@thesisId INT) AS BEGIN
    SELECT Supervisor.id, Supervisor.name FROM Supervisor
        INNER JOIN GUCianStudentRegisterThesis ON GUCianStudentRegisterThesis.supid = Supervisor.id
        WHERE GUCianStudentRegisterThesis.serial_no = @thesisId
    UNION
    SELECT Supervisor.id, Supervisor.name FROM Supervisor
        INNER JOIN NonGUCianStudentRegisterThesis ON NonGUCianStudentRegisterThesis.supid = Supervisor.id
        WHERE NonGUCianStudentRegisterThesis.serial_no = @thesisId;
END
GO

CREATE PROC getExaminerData (@id INT) AS SELECT * FROM Examiner INNER JOIN PostGradUser ON PostGradUser.id = Examiner.id WHERE Examiner.id = @id;
GO

CREATE PROC updateExaminerData (@id INT, @email VARCHAR(50), @password VARCHAR(20), @name VARCHAR(50), @fieldOfWork VARCHAR(50), @isNational BIT) AS BEGIN
    UPDATE PostGradUser SET email = @email, password = @password WHERE id = @id;
    UPDATE Examiner SET name = @name, fieldOfWork = @fieldOfWork, isNational = @isNational WHERE id = @id;
END;
GO

CREATE PROC searchThesis (@keyword VARCHAR(50)) AS SELECT * FROM Thesis WHERE title LIKE '%' + @keyword + '%';
GO

CREATE PROCEDURE getStudentTheses
@studentID INT
AS
BEGIN
    IF(@studentID in (SELECT id from GucianStudent)) BEGIN
        SELECT DISTINCT Thesis.* FROM Thesis
        INNER JOIN GUCianStudentRegisterThesis GUC
        ON Thesis.serialNumber = GUC.serial_no
        WHERE GUC.sid = @studentID;
    END
    ELSE BEGIN
        SELECT DISTINCT Thesis.* FROM Thesis
        INNER JOIN NonGUCianStudentRegisterThesis nonGUC
        ON Thesis.serialNumber = nonGUC.serial_no
        WHERE nonGUC.sid = @studentID;
    END
END
GO

CREATE PROCEDURE getOngoingThesis
@studentID INT
AS
BEGIN
    IF(@studentID in (SELECT id from GucianStudent)) BEGIN
        SELECT DISTINCT Thesis.* FROM Thesis
        INNER JOIN GUCianStudentRegisterThesis GUC
        ON Thesis.serialNumber = GUC.serial_no
        WHERE GUC.sid = @studentID AND 
        Thesis.endDate >= GETDATE();
    END
    ELSE BEGIN
        SELECT DISTINCT Thesis.* FROM Thesis
        INNER JOIN NonGUCianStudentRegisterThesis nonGUC
        ON Thesis.serialNumber = nonGUC.serial_no
        WHERE nonGUC.sid = @studentID AND 
        Thesis.endDate >= GETDATE();
    END
END
GO

CREATE PROCEDURE getOngoingThesisSerialNo
@studentID INT,
@success BIT OUTPUT,
@ThesisSN INT OUTPUT
AS
BEGIN
    IF(@studentID in (SELECT id from GucianStudent)) BEGIN
        IF EXISTS(SELECT Thesis.* FROM Thesis
        INNER JOIN GUCianStudentRegisterThesis GUC
        ON Thesis.serialNumber = GUC.serial_no
        WHERE GUC.sid = @studentID AND 
        Thesis.endDate >= GETDATE()) BEGIN
            SELECT DISTINCT @ThesisSN = Thesis.serialNumber FROM Thesis
            INNER JOIN GUCianStudentRegisterThesis GUC
            ON Thesis.serialNumber = GUC.serial_no
            WHERE GUC.sid = @studentID AND 
            Thesis.endDate >= GETDATE();
            SET @success = 1;
        END
        ELSE BEGIN
            SET @success = 0;
        END
    END
    ELSE BEGIN
        IF EXISTS(SELECT Thesis.* FROM Thesis
        INNER JOIN NonGUCianStudentRegisterThesis nonGUC
        ON Thesis.serialNumber = nonGUC.serial_no
        WHERE nonGUC.sid = @studentID AND 
        Thesis.endDate >= GETDATE()) BEGIN
            SELECT DISTINCT @ThesisSN = Thesis.serialNumber FROM Thesis
            INNER JOIN NonGUCianStudentRegisterThesis nonGUC
            ON Thesis.serialNumber = nonGUC.serial_no
            WHERE nonGUC.sid = @studentID AND 
            Thesis.endDate >= GETDATE();
            SET @success = 1;
        END
        ELSE BEGIN
            SET @success = 0;
        END
    END
END
GO



CREATE PROCEDURE isGUCian
@studentId INT,
@GUCian BIT OUTPUT
AS
BEGIN
    IF (@studentID IN (SELECT id FROM GucianStudent)) BEGIN
        SET @GUCian = 1;
    END
    ELSE BEGIN
        SET @GUCian = 0;
    END
END;
GO

CREATE PROCEDURE LinkPublicationToOngoingThesis
@sID INT,
@pubID INT,
@success BIT OUTPUT
AS
BEGIN
DECLARE @ThesisSN INT, @success1 BIT;
EXECUTE getOngoingThesisSerialNo @sID, @success1 OUTPUT, @ThesisSN OUTPUT;
IF @success1 = 1 BEGIN
    EXECUTE linkPubThesis @pubID, @ThesisSN, @success OUTPUT;
END
ELSE BEGIN
    SET @success = 0;
END
END
GO


CREATE PROCEDURE ViewAllPublications
AS
SELECT * FROM Publication;
GO

CREATE PROCEDURE viewStudentProgressReports
@studentID INT
AS
    SELECT pg1.*
    FROM GUCianProgressReport pg1
    INNER JOIN GucianStudent guc
    ON guc.id = pg1.sid
    WHERE guc.id = @studentID

    UNION

    SELECT pg2.*
    FROM NonGUCianProgressReport pg2
    INNER JOIN NonGucianStudent nonGuc
    ON nonGuc.id = pg2.sid
    WHERE nonGuc.id = @studentID
GO

CREATE PROCEDURE AddProgressReportToOngoingThesis
@studentID INT,
@Date DATETIME,
@ReportNo INT,
@success BIT OUTPUT
AS
BEGIN
    DECLARE @thesisSN INT;
    EXECUTE getOngoingThesisSerialNo @studentID, @success OUT, @thesisSN OUT
    IF @success = 1 BEGIN
        IF EXISTS(
            SELECT * FROM
            GUCianProgressReport
            WHERE sid = @studentID AND [NO] = @ReportNo

            UNION

            SELECT * FROM
            NonGUCianProgressReport
            WHERE sid = @studentID AND [NO] = @ReportNo
        ) BEGIN
            SET @success = 0;
        END
        ELSE BEGIN
            EXECUTE AddProgressReport @thesisSN, @Date, @studentID, @ReportNo;
        END
    END
END
GO

CREATE PROCEDURE FillProgressReportForOngoingThesis
@ReportNo int,
@state int,
@description varchar(200),
@studentID int,
@success BIT OUTPUT
AS
BEGIN
    DECLARE @thesisSN INT;
    EXECUTE getOngoingThesisSerialNo @studentID, @success OUT, @thesisSN OUT
    IF @success = 1 BEGIN
        IF NOT EXISTS(
            SELECT * FROM
            GUCianProgressReport
            WHERE sid = @studentID AND [NO] = @ReportNo

            UNION

            SELECT * FROM
            NonGUCianProgressReport
            WHERE sid = @studentID AND [NO] = @ReportNo
        ) BEGIN
            SET @success = 0;
        END
        ELSE BEGIN
            EXECUTE FillProgressReport @thesisSN, @ReportNo, @state, @description, @studentID;
        END
    END
END

GO

CREATE PROC AddUserPhone
@userID INT,
@phoneNo VARCHAR(20),
@success BIT OUTPUT
AS
BEGIN
    SET @success = 0;
    IF EXISTS(SELECT * FROM PostGradUser WHERE id = @userID) AND 
    NOT EXISTS(SELECT * FROM PostGradPhoneNumber WHERE id = @userID AND phone = @phoneNo) 
    BEGIN
        SET @success = 1;
        INSERT INTO PostGradPhoneNumber VALUES(@phoneNo, @userID);
    END
END

GO
