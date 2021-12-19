-- Signature:
-- Name: StudentRegister
-- Input: first_name varchar(20), last_name varchar(20), password varchar(20), faculty varchar(20),
-- Gucian bit, email varchar(50), address varchar(50)
-- Output: Nothing
EXEC StudentRegister 'john', 'smith', '123456', 'Computer Science', 1, 
'john.smith@student.guc.edu.eg', 'tagamo3 5th street';
GO

EXEC StudentRegister 'billy', 'smith', '123456', 'Pharmacy', 0, 
'billy.smith@student.guc.edu.eg', 'tagamo3 5th street';
GO

-- Signature:
-- Name: SupervisorRegister
-- Input: first_name varchar(20), last_name varchar(20), password varchar(20), faculty varchar(20),
-- email varchar(50)
-- Output: Nothing

EXEC SupervisorRegister 'mohamed','ahmed','mypassword', 'Pharmacy', 'realemail@gmail.com'
GO

-- Signature:
-- Name: userLogin
-- Input: ID int, password varchar(20)
-- Output: Success bit

DECLARE @successful BIT;
EXEC userLogin 51, '123456', @successful OUTPUT;
GO

-- Signature:
-- Name: addMobile
-- Input: @ID int, @mobile_number varchar(20)
-- Output: Nothing

EXEC addMobile 1,'01002129311'
GO

-- Signature:
-- Name: AdminListSup
-- Input: Nothing
-- Output: table

EXEC AdminListSup
GO

-- Signature:
-- Name: AdminViewSupervisorProfile
-- Input: supId int
-- Output: table

EXEC AdminViewSupervisorProfile 35
GO

-- Signature:
-- Name: AdminViewAllTheses
-- Input: Nothing
-- Output: table

EXEC AdminViewAllTheses
GO

-- Signature:
-- Name: AdminViewOnGoingTheses
-- Input: Nothing
-- Output: thesesCount int

DECLARE @thesisCount INT;
EXEC AdminViewOnGoingTheses @thesisCount OUTPUT;
GO

-- Signature:
-- Name: AdminViewStudentThesisBySupervisor
-- Input: Nothing
-- Output: table

EXEC AdminViewStudentThesisBySupervisor
GO

-- Signature:
-- Name: AdminListNonGucianCourse
-- Input: courseID int
-- Output: table

EXEC AdminListNonGucianCourse 2
GO

---------------------------------

EXECUTE AdminUpdateExtension 1;
GO
------------------------
DECLARE @ans BIT;
EXECUTE AdminIssueThesisPayment 
@ThesisSerialNo = 2, @amount = 2000.0, @noOfInstallments = 2, 
@fundPercentage = 33, @success =  @ans OUTPUT;
SELECT @ans;
GO
------------------------
EXECUTE AdminViewStudentProfile 3;
GO
------------------------
EXECUTE AdminIssueInstallPayment 1, '2015-11-3';
GO
------------------------
EXECUTE AdminListAcceptPublication;
GO
------------------------
EXECUTE AddCourse 'CSEN502', 6, 20000;
GO
------------------------
EXECUTE linkCourseStudent 1, 26;
GO
---------------------------------
EXECUTE addStudentCourseGrade 1, 26, 4.0;
GO
---------------------------------
EXECUTE ViewExamSupDefense '2018-9-7';
GO
---------------------------------
EXECUTE EvaluateProgressReport 39, 1, 1, 3;
---------------------------------
EXECUTE ViewSupStudentsYears 33;
GO
---------------------------------

EXECUTE viewMyProfile 1;
GO

EXECUTE viewMyProfile 20;
GO

EXECUTE editMyProfile 1, 'Ahmed', 'Alwasifey', '123456', 'bla@example.com', 'tagamo3 5th street', 'Dumb';
GO

EXECUTE editMyProfile 20, 'Anas', 'Alwasifey', '123456', 'bla@example.com', 'tagamo3 5th street', 'Dumb';
GO

EXEC addUndergradID 1, '49-4934';
GO

EXEC ViewCoursesGrades 16;
GO

EXEC ViewCoursePaymentsInstall 16;
GO

EXEC ViewThesisPaymentsInstall 5;
GO

EXEC ViewThesisPaymentsInstall 19;
GO

EXEC ViewUpcomingInstallments 6;
GO

EXEC ViewUpcomingInstallments 26;
GO

EXEC ViewMissedInstallments 12;
GO

EXEC ViewMissedInstallments 18;
GO

EXEC AddProgressReport 3, '2021-12-19'
GO

EXEC AddProgressReport 20, '2021-12-19'
GO

EXEC FillProgressReport 3, 1, 29, 'bla bla bla'
GO

EXEC FillProgressReport 20, 1, 80, 'bla bla bla'
GO

EXEC ViewEvalProgressReport 3, 1;
GO

EXEC ViewEvalProgressReport 20, 1;
GO

EXEC addPublication 'My publication', '2021-12-19', 'GUC', 'New Cairo', 1;
GO

EXEC addPublication 'My publication Not Accepted', '2021-12-19', 'GUC', 'New Cairo', 0;
GO

EXEC linkPubThesis 1, 1;
GO

EXEC linkPubThesis 2, 16;
GO

---------------------------------------------

EXECUTE SupViewProfile 33
GO

EXECUTE UpdateSupProfile 33, 'updated_name', 'updated_faculty'
GO

EXECUTE SupViewProfile 33
GO

EXECUTE ViewAStudentPublications 10
GO

EXECUTE ViewAStudentPublications 20
GO

EXECUTE AddDefenseGucian 1, '2021-12-20', 'somewhere'
GO

EXECUTE AddDefenseNonGucian 21 ,'2021-12-20', 'somewhere'
GO


EXECUTE AddExaminer 1,'2021-12-20','Bart Mustafa','0','Electronics'
GO

EXECUTE CancelThesis 11
GO 

EXECUTE CancelThesis 21
GO

EXECUTE AddGrade 5, 1.1
GO


EXECUTE AddDefenseGrade 1, '2021-12-20', 2.9
GO

EXECUTE AddDefenseGrade 21, '2021-12-20', 9.9
GO

EXECUTE AddCommentsGrade 1, '2021-12-20', 'git gud'
GO

EXECUTE AddCommentsGrade 21, '2021-12-20', 'werte gut'
GO
