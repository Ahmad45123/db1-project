using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostgradSystem
{
    public partial class ManagePhones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null || Session["userType"] == null)
            {
                Response.Redirect("login.aspx");
            }

            var result = DbManager.Query($"SELECT phone FROM PostGradPhoneNumber WHERE id = {Session["userId"]}");
            numbersGrid.DataSource = result;
            numbersGrid.DataBind();
        }

        protected void saveButton_OnClick(object sender, EventArgs e)
        {
            try
            {
                var result = new SqlParameter("@success", SqlDbType.Bit) { Direction = ParameterDirection.Output };
                DbManager.CallProc("AddUserPhone",
                    new SqlParameter("@userID", int.Parse(Session["userId"].ToString())),
                    new SqlParameter("@phoneNo", numberInput.Value),
                    result);


                if ((bool)result.Value == false)
                    throw new Exception("This phone number already exists!");

                saveNumberLabel.Visible = true;
                saveNumberLabel.Text = "Number added successfully!";
                Page_Load(this, EventArgs.Empty);
            }
            catch (Exception ex)
            {
                Response.Write("<script language=javascript>alert(`Error Encountered, Error Message: " + ex.Message.ToString() + "`);</script>");
            }
        }
    }
}