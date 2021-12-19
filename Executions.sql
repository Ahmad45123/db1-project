
USE dbProject3;

GO

EXEC StudentRegister 'john', 'smith', '123456', 'Computer Science', 1, 
'john.smith@student.guc.edu.eg', 'tagamo3 5th street';

EXEC StudentRegister 'billy', 'smith', '123456', 'Pharmacy', 0, 
'billy.smith@student.guc.edu.eg', 'tagamo3 5th street';

EXEC SupervisorRegister 'mohamed','ahmed','mypassword', 'Pharmacy', 'yeet@gmail.com'


DECLARE @bla BIT;
EXEC userLogin 51, '123456', @bla OUTPUT;

EXEC addMobile 1,'01002129311'

EXEC AdminListSup


---------------------------------
SELECT * FROM Thesis;
EXECUTE AdminUpdateExtension 1;
SELECT * FROM Thesis;
GO
------------------------
DECLARE @ans BIT;
EXECUTE AdminIssueThesisPayment 
@ThesisSerialNo = 2, @amount = 2000.0, @noOfInstallments = 2, 
@fundPercentage = 33, @success =  @ans OUTPUT;
SELECT @ans;
SELECT * FROM Payment;
SELECT * FROM Thesis;
GO
------------------------
EXECUTE AdminViewStudentProfile 3;
GO
------------------------
EXECUTE AdminIssueInstallPayment 1, '2015-11-3';
SELECT * FROM Installment;
GO
------------------------
EXECUTE AdminListAcceptPublication;
GO
------------------------
EXECUTE AddCourse 'CSEN502', 6, 20000;
SELECT * FROM Course;
GO
------------------------
EXECUTE linkCourseStudent 1, 26;
SELECT * FROM NonGUCianStudentTakeCourse;
GO
---------------------------------
EXECUTE addStudentCourseGrade 1, 26, 4.0;
SELECT * FROM NonGUCianStudentTakeCourse;
GO
---------------------------------
EXECUTE ViewExamSupDefense '2018-9-7';
GO
---------------------------------
-- EXECUTE EvaluateProgressReport 33, 
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

EXEC ViewCoursePaymentsInstall 18;
GO

EXEC ViewThesisPaymentsInstall 5;
GO

EXEC ViewThesisPaymentsInstall 19;
GO

EXEC ViewUpcomingInstallments 6;
GO

EXEC ViewUpcomingInstallments 20;
GO

EXEC ViewMissedInstallments 12;
GO

EXEC ViewMissedInstallments 18;
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


-- TODO: This function has an incorrect signature. So, it can't be properly tested
-- EXECUTE AddExaminer

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
