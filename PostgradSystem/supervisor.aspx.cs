using PostgradSystem;
using System;
using System.Data;
using System.Data.SqlClient;

namespace PostgradSystem
{
    public partial class supervisor : System.Web.UI.Page
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
            Session["userId"] = null;
            Session["userType"] = null;

        }

        protected void ListStudentInfo_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable queryInfo = DbManager.CallProc("ViewSupStudentsYears", new SqlParameter("@supervisorID", Session["userId"].ToString()));
                this.outputGrid.DataSource = queryInfo;
                this.outputGrid.DataBind();
                if (queryInfo.Rows.Count < 1)
                {
                    Response.Write("<script language=javascript>alert('Executed Successfully, Empty Table.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert('Error Encountered, Error Message: " + ex.Message.ToString() + "');</script>");
            }
        }

        protected void ViewStudentPublications_Click(object sender, EventArgs e)
        {


            try
            {
                string studentId = this.StudentIDBox.Text;
                DataTable queryInfo = DbManager.CallProc("ViewAStudentPublications", new SqlParameter("@StudentID", studentId));
                this.outputGrid.DataSource = queryInfo;
                this.outputGrid.DataBind();
                if (queryInfo.Rows.Count < 1)
                {
                    Response.Write("<script language=javascript>alert('Executed Successfully, Empty Table due to invalid input.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }

        protected void AddDefense_Click(object sender, EventArgs e)
        {

            try
            {
                int ThesisSerialNo = int.Parse(this.AddDefenseThesis.Text);
                string DefenseDate = DateTime.Parse(this.AddDefenseDatetime.Value).ToString("G");
                string DefenseLocation = this.AddDefenseLocation.Text;

                DataTable temp = DbManager.Query($"SELECT * FROM Thesis T INNER JOIN GUCianStudentRegisterThesis G ON T.serialNumber=G.serial_no WHERE T.serialNumber=\'{ThesisSerialNo}\'");
                if (temp.Rows.Count > 0)
                {
                    //GucianStudent
                    int tableRowCount = DbManager.Query($"SELECT * FROM Defense").Rows.Count;

                    DataTable queryInfo = DbManager.CallProc("AddDefenseGucian",
                    new SqlParameter("@ThesisSerialNo", ThesisSerialNo),
                    new SqlParameter("@DefenseDate", DefenseDate),
                    new SqlParameter("@DefenseLocation", DefenseLocation)
                    );
                    this.outputGrid.DataSource = queryInfo;
                    this.outputGrid.DataBind();

                    int newTableRowCount = DbManager.Query($"SELECT * FROM Defense").Rows.Count;

                    if (tableRowCount == newTableRowCount)
                    {
                        Response.Write("<script language=javascript>alert('Failed to execute successfully due to invalid input');</script>");
                    }
                    else
                    {
                        Response.Write("<script language=javascript>alert('Executed Successfully');</script>");
                    }
                }
                else
                {
                    //Non-Gucian Student;

                    int tableRowCount = DbManager.Query($"SELECT * FROM Defense").Rows.Count;

                    DataTable queryInfo = DbManager.CallProc("AddDefenseNonGucian",
                    new SqlParameter("@ThesisSerialNo", ThesisSerialNo),
                    new SqlParameter("@DefenseDate", DefenseDate),
                    new SqlParameter("@DefenseLocation", DefenseLocation)
                    );
                    this.outputGrid.DataSource = queryInfo;
                    this.outputGrid.DataBind();

                    int newTableRowCount = DbManager.Query($"SELECT * FROM Defense").Rows.Count;

                    if (tableRowCount == newTableRowCount)
                    {
                        Response.Write("<script language=javascript>alert('Failed to execute successfully due to invalid input');</script>");
                    }
                    else
                    {
                        Response.Write("<script language=javascript>alert('Executed Successfully');</script>");
                    }

                }

            }
            catch (Exception ex)
            {
                Response.Write(@"<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }


        }



        protected void AddExaminer_Click(object sender, EventArgs e)
        {
            try
            {
                int ThesisSerialNo = int.Parse(this.AddExaminerThesis.Text);
                string DefenseDate = DateTime.Parse(AddExaminerDate.Value).ToString("G");
                string ExamninerName = this.AddExaminerName.Text;
                string Password = this.AddExaminerPassword.Text;
                int National = this.AddExaminerNational.Checked ? 1 : 0;
                string fieldOfWork = this.AddExaminerField.Text;

                int tableRowCount = DbManager.Query($"SELECT * FROM ExaminerEvaluateDefense").Rows.Count;

                DataTable queryInfo = DbManager.CallProc("AddExaminer",
                new SqlParameter("@ThesisSerialNo", ThesisSerialNo),
                new SqlParameter("@DefenseDate", DefenseDate),
                new SqlParameter("@ExaminerName", ExamninerName),
                new SqlParameter("@Password", Password),
                new SqlParameter("@National", National.ToString()),
                new SqlParameter("@fieldOfWork", fieldOfWork));
                this.outputGrid.DataSource = queryInfo;
                this.outputGrid.DataBind();

                int newTableRowCount = DbManager.Query($"SELECT * FROM ExaminerEvaluateDefense").Rows.Count;

                if (tableRowCount == newTableRowCount)
                {
                    Response.Write("<script language=javascript>alert('Failed to execute successfully due to invalid input');</script>");
                }
                else
                {
                    Response.Write("<script language=javascript>alert('Executed Successfully');</script>");
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }

        }

        protected void EvaluateReport_Click(object sender, EventArgs e)
        {
            try
            {
                int ThesisSerialNo = int.Parse(this.EvaluateThesis.Text);
                string ProgressReportNo = this.EvaluateProgressNo.Text;
                string Evaluation = this.Evaluation.Text;

                DataTable tempGucian = DbManager.Query($"SELECT * FROM GUCianProgressReport");
                DataTable tempNonGucian = DbManager.Query($"SELECT * FROM NonGUCianProgressReport");



                DataTable queryInfo = DbManager.CallProc("EvaluateProgressReport",
                new SqlParameter("@supervisorID", Session["userId"].ToString()),
                new SqlParameter("@thesisSerialNo", ThesisSerialNo),
                new SqlParameter("@progressReportNo", ProgressReportNo),
                new SqlParameter("@evaluation", Evaluation)
                );
                this.outputGrid.DataSource = queryInfo;
                this.outputGrid.DataBind();

                DataTable newTempGucian = DbManager.Query($"SELECT * FROM GUCianProgressReport");
                DataTable newTempNonGucian = DbManager.Query($"SELECT * FROM NonGUCianProgressReport");

                if (tempGucian.Equals(newTempGucian) && tempNonGucian.Equals(newTempNonGucian))
                {
                    Response.Write("<script language=javascript>alert('Failed to change table successfully(evaluation same as current or invalid input');</script>");
                }
                else
                {
                    Response.Write("<script language=javascript>alert('Executed Successfully');</script>");
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }

        }

        protected void CancelThesis_Click(object sender, EventArgs e)
        {
            try
            {
                int ThesisSerialNo = int.Parse(this.CancelNumber.Text);

                int tempThesisRowCount = DbManager.Query($"SELECT * FROM Thesis").Rows.Count;

                DataTable queryInfo = DbManager.CallProc("CancelThesis", new SqlParameter("@ThesisSerialNo", ThesisSerialNo));
                this.outputGrid.DataSource = queryInfo;
                this.outputGrid.DataBind();

                int newTempThesisRowCount = DbManager.Query($"SELECT * FROM Thesis").Rows.Count;

                if (tempThesisRowCount == newTempThesisRowCount)
                {
                    Response.Write("<script language=javascript>alert('Failed to cancel thesis due to invalid inputs or cancel requirements not being met');</script>");
                }
                else
                {
                    Response.Write("<script language=javascript>alert('Executed Successfully');</script>");
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }

    }
}