
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
