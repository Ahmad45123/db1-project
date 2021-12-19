USE dbProject3;

GO
-- 1 As an unregistered user I should be able to:

-- a) Register to the website by using my name (First and last name), password, faculty, email, and
-- address.
-- Signature:
-- Name: StudentRegister
-- Input: first_name varchar(20), last_name varchar(20), password varchar(20), faculty varchar(20),
-- Gucian bit, email varchar(50), address varchar(50)
-- Output: Nothing

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


-- Signature:
-- Name: SupervisorRegister
-- Input: first_name varchar(20), last_name varchar(20), password varchar(20), faculty varchar(20),
-- email varchar(50)
-- Output: Nothing

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

-- 2 As any registered User I should be able to:

-- a) login using my username and password.
-- Signature:
-- Name: userLogin
-- Input: ID int, password varchar(20)
-- Output: Success bit

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

-- b) add my mobile number(s).
-- Signature:
-- Name: addMobile
-- Input: @ID int, @mobile_number varchar(20)
-- Output: Nothing


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


-- 3 As an admin I should be able to:

-- a) List all supervisors in the system.
-- Signature:
-- Name: AdminListSup
-- Input: Nothing
-- Output: table


GO

CREATE PROC AdminListSup

AS

SELECT * FROM Supervisor;

GO


-- b) view the profile of any supervisor that contains all his/her information.
-- Signature:
-- Name: AdminViewSupervisorProfile
-- Input: supId int
-- Output: table

GO

CREATE PROC AdminViewSupervisorProfile

@supId INT

AS

SELECT * FROM Supervisor WHERE id=@supId;

GO


-- c) List all Theses in the system.
-- Signature:
-- Name: AdminViewAllTheses
-- Input: Nothing
-- Output: table

GO

CREATE PROC AdminViewAllTheses

AS

SELECT * FROM Thesis

GO


-- d) List the number of on going theses.
-- Signature:
-- Name: AdminViewOnGoingTheses
-- Input: Nothing
-- Output: thesesCount int

GO

CREATE PROC AdminViewOnGoingTheses

@thesesCount INT OUTPUT

AS

SET @thesesCount = (SELECT COUNT(serialNumber) FROM Thesis WHERE endDate > GETDATE() );

GO

-- e) List all supervisors’ names currently supervising students, theses title, student name.
-- Signature:
-- Name: AdminViewStudentThesisBySupervisor
-- Input: Nothing
-- Output: table

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

-- f) List nonGucians names, course code, and respective grade.
-- Signature:
-- Name: AdminListNonGucianCourse
-- Input: courseID int
-- Output: table

GO

CREATE PROC AdminListNonGucianCourse

@courseID INT

AS

SELECT DISTINCT CONCAT(NGS.firstName,' ',NGS.lastName),C.code,NGC.grade FROM NonGUCianStudentTakeCourse NGC INNER JOIN NonGucianStudent NGS ON NGC.sid = NGS.id
        INNER JOIN Course C ON NGC.cid = C.id WHERE NGC.cid=@courseID;

GO
