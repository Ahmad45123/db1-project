-- Signature:
-- Name: StudentRegister
-- Input: first_name varchar(20), last_name varchar(20), password varchar(20), faculty varchar(20),
-- Gucian bit, email varchar(50), address varchar(50)
-- Output: Nothing


EXEC StudentRegister 'john', 'smith', '123456', 'Computer Science', 1, 
'john.smith@student.guc.edu.eg', 'tagamo3 5th street';

EXEC StudentRegister 'billy', 'smith', '123456', 'Pharmacy', 0, 
'billy.smith@student.guc.edu.eg', 'tagamo3 5th street';

-- Signature:
-- Name: SupervisorRegister
-- Input: first_name varchar(20), last_name varchar(20), password varchar(20), faculty varchar(20),
-- email varchar(50)
-- Output: Nothing

EXEC SupervisorRegister 'mohamed','ahmed','mypassword', 'Pharmacy', 'realemail@gmail.com'

-- Signature:
-- Name: userLogin
-- Input: ID int, password varchar(20)
-- Output: Success bit

DECLARE @successful BIT;
EXEC userLogin 51, '123456', @successful OUTPUT;

-- Signature:
-- Name: addMobile
-- Input: @ID int, @mobile_number varchar(20)
-- Output: Nothing

EXEC addMobile 1,'01002129311'

-- Signature:
-- Name: AdminListSup
-- Input: Nothing
-- Output: table

EXEC AdminListSup

-- Signature:
-- Name: AdminViewSupervisorProfile
-- Input: supId int
-- Output: table

EXEC AdminViewSupervisorProfile 35

-- Signature:
-- Name: AdminViewAllTheses
-- Input: Nothing
-- Output: table

EXEC AdminViewAllTheses

-- Signature:
-- Name: AdminViewOnGoingTheses
-- Input: Nothing
-- Output: thesesCount int

DECLARE @thesisCount INT;
EXEC AdminViewOnGoingTheses @thesisCount OUTPUT;

-- Signature:
-- Name: AdminViewStudentThesisBySupervisor
-- Input: Nothing
-- Output: table

EXEC AdminViewStudentThesisBySupervisor

-- Signature:
-- Name: AdminListNonGucianCourse
-- Input: courseID int
-- Output: table

EXEC AdminListNonGucianCourse 2