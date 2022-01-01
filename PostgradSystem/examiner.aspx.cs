using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace PostgradSystem
{
    public partial class examiner : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null || Session["userType"] == null || (string)Session["userType"] != "examiner")
            {
                Response.Redirect("login.aspx");
            }

            refreshListBtn_OnClick(this, EventArgs.Empty);

            if (!this.IsPostBack)
            {
                var info = DbManager.CallProc("getExaminerData", new SqlParameter("@id", Session["userId"]));
                examinerFirstName.Value = info.Rows[0]["name"].ToString().Split(' ')[0];
                examinerLastName.Value = info.Rows[0]["name"].ToString().Split(' ')[1];
                exmainerEmail.Value = info.Rows[0]["email"].ToString();
                examinerPassword.Value = info.Rows[0]["password"].ToString();
                examinerField.Value = info.Rows[0]["fieldOfWork"].ToString();
                exmainerIsNational.Checked = info.Rows[0]["isNational"].ToString() == "True";
            }
        }

        void ListSupervisors(int thesisId)
        {
            try{
                DataTable res = DbManager.CallProc("listSupervisors", new SqlParameter("@thesisId", thesisId));
                supList.DataSource = res;
                supList.DataBind();

                if (res.Rows.Count < 1)
                {
                    Response.Write("<script language=javascript>alert('Executed Successfully, Empty Table.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }

        protected void refreshListBtn_OnClick(object sender, EventArgs e)
        {
            try{
                var res = DbManager.CallProc("examinerListData", new SqlParameter("@examId", Session["userId"].ToString()));
                lstGrid.DataSource = res;
                lstGrid.DataBind();
                lstGrid.HeaderRow.Cells.Add(new TableHeaderCell() { Text = "Action" });
                foreach (GridViewRow lstGridRow in lstGrid.Rows)
                {
                    Button theCtrl = new Button() { Text = "View Supervisors", CssClass = "btn btn-secondary" };
                    theCtrl.Click += (o, args) =>
                    {
                        ListSupervisors(int.Parse(lstGridRow.Cells[0].Text));
                    };
                    lstGridRow.Cells.Add(new TableCell() { Controls = { theCtrl } });
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }

        protected void examinerRegister_OnClick(object sender, EventArgs e)
        {
            try
            {
                DbManager.CallProc("updateExaminerData", new SqlParameter("@id", int.Parse(Session["userId"].ToString())),
                    new SqlParameter("@email", exmainerEmail.Value), new SqlParameter("@password", examinerPassword.Value),
                    new SqlParameter("@name", examinerFirstName.Value + " " + examinerLastName.Value),
                    new SqlParameter("@fieldOfWork", examinerField.Value),
                    new SqlParameter("@isNational", exmainerIsNational.Checked));
                errorLabel.Visible = true;
                errorLabel.Text = "Saved successfully!";

            }
            catch
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }

        protected void SaveCommentBtn_OnClick(object sender, EventArgs e)
        {
            try
            {
                DbManager.CallProc("AddCommentsGrade",
                    new SqlParameter("@ThesisSerialNo", int.Parse(commentThesisInput.Value)),
                    new SqlParameter("@DefenseDate", DateTime.Parse(commentDateTimeInput.Value).ToString("G")),
                    new SqlParameter("@comments", commentsTextArea.Value));
                addCommentLabel.Text = "Added successfully!";
                addCommentLabel.Visible = true;
            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }

        protected void saveGradeBtn_OnClick(object sender, EventArgs e)
        {
            try
            {
                DbManager.CallProc("AddDefenseGrade",
                    new SqlParameter("@ThesisSerialNo", int.Parse(gradeThesisInput.Value)),
                    new SqlParameter("@DefenseDate", DateTime.Parse(gradeDefenseDate.Value).ToString("G")),
                    new SqlParameter("@grade", SqlDbType.Decimal) { Value = decimal.Parse(gradeValueInput.Value) });
                gradeLabel.Text = "Added successfully!";
                gradeLabel.Visible = true;
            }
            catch (Exception ex)
            {
                gradeLabel.Text = "Error: Grade was not in correct format.\n" + ex.Message;
                gradeLabel.Visible = true;
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
            
        }

        protected void searchBtn_OnClick(object sender, EventArgs e)
        {
            try
            {
                searchResults.DataSource =
                    DbManager.CallProc("searchThesis", new SqlParameter("@keyword", searchText.Value));
                searchResults.DataBind()
            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }

        protected void logOutButton_OnClick(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("login.aspx");
        }
    }
}