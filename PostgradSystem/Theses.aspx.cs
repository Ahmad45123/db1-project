using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostgradSystem
{
    public partial class Theses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null || Session["userType"] == null || (string)Session["userType"] != "student")
            {
                Response.Redirect("login.aspx");
            }

            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand getTheses = new SqlCommand("getStudentTheses", connection);
            getTheses.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter id = new SqlParameter("@studentID", SqlDbType.Int);
            id.Value = (int) Session["userId"];

            getTheses.Parameters.Add(id);
            connection.Open();
            SqlDataReader table = getTheses.ExecuteReader();
            while (table.Read())
            {
                TableRow row = new TableRow();
                
                TableCell serialNumber = new TableCell();
                serialNumber.Text = "" + table.GetInt32(table.GetOrdinal("serialNumber"));
                
                TableCell field = new TableCell();
                field.Text = "" + table.GetString(table.GetOrdinal("field"));
                
                TableCell type = new TableCell();
                type.Text = "" + table.GetString(table.GetOrdinal("TYPE"));
                
                TableCell title = new TableCell();
                title.Text = "" + table.GetString(table.GetOrdinal("title"));
                
                TableCell startDate = new TableCell();
                startDate.Text = "" + table.GetDateTime(table.GetOrdinal("startDate"));
                
                TableCell endDate = new TableCell();
                endDate.Text = "" + table.GetDateTime(table.GetOrdinal("endDate"));
                
                TableCell defenseDate = new TableCell();
                defenseDate.Text = "" + table.GetDateTime(table.GetOrdinal("defenseDate"));
                
                TableCell grade = new TableCell();
                grade.Text = "" + table.GetDecimal(table.GetOrdinal("Grade"));
                
                TableCell extensions = new TableCell();
                extensions.Text = "" + table.GetInt32(table.GetOrdinal("noOfExtensions"));
                
                row.Cells.Add(serialNumber);
                row.Cells.Add(field);
                row.Cells.Add(type);
                row.Cells.Add(title);
                row.Cells.Add(startDate);
                row.Cells.Add(endDate);
                row.Cells.Add(defenseDate);
                row.Cells.Add(grade);
                row.Cells.Add(extensions);
                Thesis.Rows.Add(row);
            }
            connection.Close();
        }

        protected void Publication_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Publications.aspx");
        }

        protected void ProgressReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ProgressReports.aspx");
        }

        protected void Student_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student.aspx");
        }
    }
}