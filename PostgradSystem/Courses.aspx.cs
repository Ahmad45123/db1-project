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
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand grades = new SqlCommand("ViewCoursesGrades", connection);
            grades.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter id = new SqlParameter("@studentID", SqlDbType.Int);
            id.Value = (int)Session["userId"];

            grades.Parameters.Add(id);
            connection.Open();
            SqlDataReader table = grades.ExecuteReader();
            while (table.Read())
            {
                TableRow row = new TableRow();
                
                TableCell code = new TableCell();
                code.Text = "" + table.GetString(table.GetOrdinal("code"));
                
                TableCell grade = new TableCell();
                grade.Text = "" + table.GetDecimal(table.GetOrdinal("grade"));
                
                TableCell creditHours = new TableCell();
                creditHours.Text = "" + table.GetInt32(table.GetOrdinal("creditHours"));
                
                row.Cells.Add(code);
                row.Cells.Add(grade);
                row.Cells.Add(creditHours);
                Course.Rows.Add(row);
            }

            connection.Close();
        }

        protected void Student_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/student.aspx");
        }
    }
}