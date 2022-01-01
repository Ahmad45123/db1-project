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
        protected String getString(SqlDataReader reader, String parameter)
        {
            if (reader.IsDBNull(reader.GetOrdinal(parameter)))
                return "NULL";
            return reader.GetString(reader.GetOrdinal(parameter));
        }

        protected String getDecimal(SqlDataReader reader, String parameter)
        {
            if (reader.IsDBNull(reader.GetOrdinal(parameter)))
                return "NULL";
            return "" + reader.GetDecimal(reader.GetOrdinal(parameter));
        }

        protected String getDate(SqlDataReader reader, String parameter)
        {
            if (reader.IsDBNull(reader.GetOrdinal(parameter)))
                return "NULL";
            return "" + reader.GetDateTime(reader.GetOrdinal(parameter));
        }

        protected String getInt(SqlDataReader reader, String parameter)
        {
            if (reader.IsDBNull(reader.GetOrdinal(parameter)))
                return "NULL";
            return "" + reader.GetInt32(reader.GetOrdinal(parameter));
        }

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
                serialNumber.Text = getInt(table, "serialNumber");
                
                TableCell field = new TableCell();
                field.Text = getString(table, "field");
                
                TableCell type = new TableCell();
                type.Text = getString(table, "TYPE");
                
                TableCell title = new TableCell();
                title.Text = getString(table, "title");
                
                TableCell startDate = new TableCell();
                startDate.Text = getDate(table, "startDate");
                
                TableCell endDate = new TableCell();
                endDate.Text = getDate(table, "endDate");

                TableCell defenseDate = new TableCell();
                defenseDate.Text = getDate(table, "defenseDate");

                TableCell grade = new TableCell();
                grade.Text = getDecimal(table, "Grade");
                
                TableCell extensions = new TableCell();
                extensions.Text = getInt(table, "noOfExtensions");
                
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