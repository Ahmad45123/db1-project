EXECUTE StudentRegister 'GUC', 'Sucks', 'forgotten', 'Computer Science', 1, 
'guc.sucks@student.guc.edu.eg', 'tagamo3';
---------------------------------
EXECUTE AdminUpdateExtension 1;
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
