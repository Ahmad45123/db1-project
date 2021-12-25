using System;
using System.Data;
using System.Data.SqlClient;

namespace PostgradSystem
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void registerButton_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");
        }

        protected void loginButton_OnClick(object sender, EventArgs e)
        {
            var result = new SqlParameter("@id", SqlDbType.Int) { Direction = ParameterDirection.Output };
            DbManager.CallProc("userLogin", new SqlParameter("@email", emailTextBox.Text),
                new SqlParameter("@password", passwordTextBox.Text), result);
            if ((int)result.Value != -1)
            {
                Session["userId"] = result.Value;
                // check if admin.
                var tmp = DbManager.Query($"SELECT * FROM Admin WHERE id={Session["userId"]}");
                if (tmp.Rows.Count > 0)
                {
                    Session["userType"] = "admin";
                    Response.Redirect("admin.aspx");
                    return;
                }

                tmp = DbManager.Query($"SELECT * FROM Supervisor WHERE id={Session["userId"]}");
                if (tmp.Rows.Count > 0)
                {
                    Session["userType"] = "supervisor";
                    Response.Redirect("supervisor.aspx");
                    return;
                }

                tmp = DbManager.Query($"SELECT * FROM Examiner WHERE id={Session["userId"]}");
                if (tmp.Rows.Count > 0)
                {
                    Session["userType"] = "examiner";
                    Response.Redirect("examiner.aspx");
                    return;
                }

                // if none of above, he must be student
                Session["userType"] = "student";
                Response.Redirect("student.aspx");
            }
            else
            {
                errorLabel.Text = "Wrong email or password!";
                errorLabel.Visible = true;
            }
        }
    }
}