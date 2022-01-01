using PostgradSystem;
using System;
using System.Data;
using System.Data.SqlClient;

namespace supervisorcomponent
{
    public partial class Supervisor : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null || Session["userType"] == null || (string)Session["userType"] != "supervisor")
            {
                Response.Redirect("login.aspx");
            }

        }

        protected void Logout_Click(object sender, EventArgs e)
        {

            Response.Redirect("login.aspx");

        }

        protected void ListStudentInfo_Click(object sender, EventArgs e)
        {
            DataTable queryInfo = DbManager.CallProc("ViewSupStudentsYears", new SqlParameter("@supervisorID", Session["userId"].ToString()));
            this.outputGrid.DataSource = queryInfo;
            this.outputGrid.DataBind();
        }

        protected void ViewStudentPublications_Click(object sender, EventArgs e)
        {
            string studentId = this.StudentIDBox.Text;

            DataTable queryInfo = DbManager.CallProc("ViewAStudentPublications", new SqlParameter("@StudentID", studentId));
            this.outputGrid.DataSource = queryInfo;
            this.outputGrid.DataBind();
        }

        protected void AddDefense_Click(object sender, EventArgs e)
        {

            string ThesisSerialNo = this.AddDefenseThesis.Text;
            string DefenseDate = this.AddDefenseDatetime.Text;
            string DefenseLocation = this.AddDefenseLocation.Text;

            DataTable temp = DbManager.Query($"SELECT * FROM Thesis T INNER JOIN GUCianStudentRegisterThesis G ON T.serialNumber=G.serial_no WHERE T.serialNumber=\'{ThesisSerialNo}\'");
            if (temp.Rows.Count > 0)
            {
                //GucianStudent
                DataTable queryInfo = DbManager.CallProc("AddDefenseGucian",
                new SqlParameter("@ThesisSerialNo", ThesisSerialNo),
                new SqlParameter("@DefenseDate", DefenseDate),
                new SqlParameter("@DefenseLocation", DefenseLocation)
                );
                this.outputGrid.DataSource = queryInfo;
                this.outputGrid.DataBind();
            }
            else
            {
                //Non-Gucian Student;
                DataTable queryInfo = DbManager.CallProc("AddDefenseNonGucian",
                new SqlParameter("@ThesisSerialNo", ThesisSerialNo),
                new SqlParameter("@DefenseDate", DefenseDate),
                new SqlParameter("@DefenseLocation", DefenseLocation)
                );
                this.outputGrid.DataSource = queryInfo;
                this.outputGrid.DataBind();

            }

        }

        protected void AddExaminer_Click(object sender, EventArgs e)
        {
            string ThesisSerialNo = this.AddExaminerThesis.Text;
            string DefenseDate = this.AddExaminerDate.Text;
            string ExamninerName = this.AddExaminerName.Text;
            string Password = this.AddExaminerPassword.Text;
            int National = this.AddExaminerNational.Checked ? 1 : 0;
            string fieldOfWork = this.AddExaminerField.Text;

            DataTable queryInfo = DbManager.CallProc("AddExaminer",
            new SqlParameter("@ThesisSerialNo", ThesisSerialNo),
            new SqlParameter("@DefenseDate", DefenseDate),
            new SqlParameter("@ExaminerName", ExamninerName),
            new SqlParameter("@Password", Password),
            new SqlParameter("@National", National.ToString()),
            new SqlParameter("@fieldOfWork", fieldOfWork));
            this.outputGrid.DataSource = queryInfo;
            this.outputGrid.DataBind();
        }

        protected void EvaluateReport_Click(object sender, EventArgs e)
        {
            string ThesisSerialNo = this.EvaluateThesis.Text;
            string ProgressReportNo = this.EvaluateProgressNo.Text;
            string Evaluation = this.Evaluation.Text;

            DataTable queryInfo = DbManager.CallProc("EvaluateProgressReport",
            new SqlParameter("@supervisorID", Session["userId"].ToString()),
            new SqlParameter("@thesisSerialNo", ThesisSerialNo),
            new SqlParameter("@progressReportNo", ProgressReportNo),
            new SqlParameter("@evaluation", Evaluation)
            );
            this.outputGrid.DataSource = queryInfo;
            this.outputGrid.DataBind();
        }

        protected void CancelThesis_Click(object sender, EventArgs e)
        {
            string ThesisSerialNo = this.CancelNumber.Text;

            DataTable queryInfo = DbManager.CallProc("CancelThesis", new SqlParameter("@ThesisSerialNo", ThesisSerialNo));
            this.outputGrid.DataSource = queryInfo;
            this.outputGrid.DataBind();
        }

    }
}