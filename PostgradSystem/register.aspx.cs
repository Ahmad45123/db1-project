using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostgradSystem
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void studentSubmit_OnServerClick(object sender, EventArgs e)
        {
            DbManager.CallProc("studentRegister", new SqlParameter("@first_name", studentFirstName.Value),
                new SqlParameter("@last_name", studentLastName.Value),
                new SqlParameter("@password", studentPassword.Value),
                new SqlParameter("@faculty", studentFaculty.Value), new SqlParameter("@Gucian", studentGucian.Checked),
                new SqlParameter("@email", studentEmail.Value), new SqlParameter("@address", studentAddress.Value));
            Response.Redirect("login.aspx");
        }

        protected void supervisorRegsister_OnClick(object sender, EventArgs e)
        {
            DbManager.CallProc("supervisorRegister", new SqlParameter("@first_name", supervisorFirstName.Value),
                new SqlParameter("@last_name", supervisorLastName.Value),
                new SqlParameter("@password", supervisorPassword.Value),
                new SqlParameter("@faculty", supervisorFaculty.Value),
                new SqlParameter("@email", supervisorEmail.Value));
            Response.Redirect("login.aspx");
        }

        protected void examinerRegister_OnClick(object sender, EventArgs e)
        {
            DbManager.CallProc("examinerRegister", new SqlParameter("@first_name", examinerFirstName.Value),
                new SqlParameter("@last_name", examinerLastName.Value),
                new SqlParameter("@password", examinerPassword.Value), new SqlParameter("@email", supervisorEmail.Value),
                new SqlParameter("@fieldOfWork", examinerField.Value),
                new SqlParameter("@isNational", exmainerIsNational.Checked));
            Response.Redirect("login.aspx");
        }

        protected void alreadyHaveAccountBtn_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}