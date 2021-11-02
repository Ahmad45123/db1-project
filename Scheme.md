Academic(<span class="primary">ID</span>, FirstName, LastName, Email, Faculty).

Student(<span class="foreign primary">Academic_ID</span>, Type, GPA, Address, PhoneNumber1, PhoneNumber2).

GUCian(<span class="foreign primary">Student_ID</span>, Undergrad_ID).

Supervisor(<span class="foreign primary">Academic_ID</span>)

Publication(<span class="primary">ID</span>, <span class="foreign">Payment_ID</span>, Accepted, Date, Title, Host, Place).

PublishedOn(<span class="foreign primary">ThesisSN, PublicationID</span>).

Payment(<span class="primary">ID</span>, TotalAmount, FundPercentage, NoOfInstallments).

Installment(<span class="primary">InstallmentID</span>, <span class="foreign">PaymentID</span>, Date, Amount, Status).

Examiner(<span class="primary">ExaminerID</span>, Type, FieldOfWork, FirstName, LastName).

Evalutes(<span class="foreign primary">ExaminerID, ThesisSN</span>, Comment).

Defense(<span class="primary foreign">ThesisSN</span>, Location, Grade, Date).

Thesis(<span class="primary">SerialNumber</span>, <span class="foreign">PaymentID</span>, Title, Type, Field, ExtensionsNeeded, StartDate, EndDate, SeminarDate, YearsSpent).

ProgressReport(<span class="primary">Report_ID</span>, <span class="foreign">ThesisSN</span>, Description, Date, Evalution, State).

Supervisor(StudentID, <span class="foreign primary">SupervisorID, ThesisSN</span>).

## Relationships


<style>

    * {
        font-family: 'Muli';
        text-underline-offset: 3px;
    }

    .foreign {
        border-bottom: 1px dashed;
        padding-bottom: 5px;
    }

    .primary {
        text-decoration: underline;
    }


</style>