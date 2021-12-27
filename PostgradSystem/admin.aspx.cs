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
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (false && ( Session["userId"] == null || Session["userType"] == null || (string)Session["userType"] != "admin"))
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void listSup_Click(object sender, EventArgs e)
        {
            DataTable queryInfo = DbManager.CallProc("AdminListSup");
            this.outputGrid.DataSource = queryInfo;
            this.outputGrid.DataBind();
        }

        protected void listThes_Click(object sender, EventArgs e)
        {
            DataTable queryInfo = DbManager.CallProc("AdminViewAllTheses");
            this.outputGrid.DataSource = queryInfo;
            this.outputGrid.DataBind();


            var result = new SqlParameter("@thesesCount", SqlDbType.Int) { Direction = ParameterDirection.Output };
            DbManager.CallProc("AdminViewOnGoingTheses", result);

            this.textOut.Text = "Ongoing Theses: " + result;
            this.textOut.DataBind();

        }

        protected void ThesPay_Click(object sender, EventArgs e)
        {


            DataTable queryInfo = DbManager.CallProc("AdminIssueThesisPayment",
            new SqlParameter("@ThesisSerialNo", this.ThesisSerialNo.Text),
            new SqlParameter("@amount", this.amount.Text),
            new SqlParameter("@noOfInstallments", this.noOfInstallments.Text),
            new SqlParameter("@fundPercentage", this.fundPercentage.Text));

        }

        protected void IsuInsta_Click(object sender, EventArgs e)
        {


            DataTable queryInfo = DbManager.CallProc("AdminIssueInstallPayment",
            new SqlParameter("@paymentID", this.paymentID.Text),
            new SqlParameter("@InstallStartDate", this.InstallStartDate.Text));


        }

        protected void AdminUpdateExtension_Click(object sender, EventArgs e)
        {
            DataTable queryInfo = DbManager.CallProc("AdminUpdateExtension",
       new SqlParameter("@ThesisSerialNo", this.ThesisSerialNo2.Text));

        }
    }
}