using System;
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

            var info = DbManager.CallProc("getExaminerData", new SqlParameter("@id", Session["userId"]));
            examinerFirstName.Value = info.Rows[0]["name"].ToString().Split(' ')[0];
            examinerLastName.Value = info.Rows[0]["name"].ToString().Split(' ')[1];
            exmainerEmail.Value = info.Rows[0]["email"].ToString();
            examinerPassword.Value = info.Rows[0]["password"].ToString();
            examinerField.Value = info.Rows[0]["fieldOfWork"].ToString();
            exmainerIsNational.Checked = info.Rows[0]["isNational"].ToString() == "True";
        }

        void ListSupervisors(int thesisId)
        {
            var res = DbManager.CallProc("listSupervisors", new SqlParameter("@thesisId", thesisId));
            supList.DataSource = res;
            supList.DataBind();
        }

        protected void refreshListBtn_OnClick(object sender, EventArgs e)
        {
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

        protected void examinerRegister_OnClick(object sender, EventArgs e)
        {
            DbManager.CallProc("updateExaminerData", new SqlParameter("@id", int.Parse(Session["userId"].ToString())),
                new SqlParameter("@email", exmainerEmail.Value), new SqlParameter("@password", examinerPassword.Value),
                new SqlParameter("@name", examinerFirstName.Value + " " + examinerLastName.Value),
                new SqlParameter("@fieldOfWork", examinerField.Value),
                new SqlParameter("@isNational", exmainerIsNational.Checked));
            errorLabel.Visible = true;
            errorLabel.Text = "Saved successfully!";
        }
    }
}