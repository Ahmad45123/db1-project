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
            if (Session["userId"] == null || Session["userType"] == null || (string)Session["userType"] != "admin")
            {
                Response.Redirect("login.aspx");
            }
        }

        protected void listSup_Click(object sender, EventArgs e)
        {
            DataTable queryInfo = DbManager.CallProc("AdminListSup");
            this.supOutputGrid.DataSource = queryInfo;
            this.supOutputGrid.DataBind();
        }

        protected void listThes_Click(object sender, EventArgs e)
        {
            DataTable queryInfo = DbManager.CallProc("AdminViewAllTheses");
            this.thesisGrid.DataSource = queryInfo;
            this.thesisGrid.DataBind();

                
            var result = new SqlParameter("@thesesCount", SqlDbType.Int) { Direction = ParameterDirection.Output };
            DbManager.CallProc("AdminViewOnGoingTheses", result);
            countLabel.InnerText = "Ongoing Theses: " + result.Value.ToString();
        }

        protected void ThesPay_Click(object sender, EventArgs e)
        {
            DbManager.CallProc("AdminIssueThesisPayment",
            new SqlParameter("@ThesisSerialNo", int.Parse(paymentThesisSerial.Value)),
            new SqlParameter("@amount", float.Parse(paymentAmount.Value)),
            new SqlParameter("@noOfInstallments", int.Parse(paymentNoInstallments.Value)),
            new SqlParameter("@fundPercentage", float.Parse(paymentFuncPerc.Value)));

            savePaymentLabel.Text = "Successfully saved payment!";
            savePaymentLabel.Visible = true;
        }

        protected void IsuInsta_Click(object sender, EventArgs e)
        {
            DbManager.CallProc("AdminIssueInstallPayment",
            new SqlParameter("@paymentID", int.Parse(installmentPaymentId.Value)),
            new SqlParameter("@InstallStartDate", installmentDate.Value));

            installmentLabel.Text = "Successfully saved installment!";
            installmentLabel.Visible = true;
        }

        protected void AdminUpdateExtension_Click(object sender, EventArgs e)
        { 
            DbManager.CallProc("AdminUpdateExtension",
               new SqlParameter("@ThesisSerialNo", int.Parse(this.extensionThesisSerial.Value)));

            updateExtensionLabel.Text = "Successfully updated thesis extension.";
            updateExtensionLabel.Visible = true;
        }
    }
}