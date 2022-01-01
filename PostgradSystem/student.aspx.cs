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
    public partial class student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null || Session["userType"] == null || (string)Session["userType"] != "student") {
                Response.Redirect("login.aspx");
            }

            String connect = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection database = new SqlConnection(connect);

            SqlCommand profile = new SqlCommand("viewMyProfile", database);
            profile.CommandType = CommandType.StoredProcedure;

            SqlCommand isGUCian = new SqlCommand("isGUCian", database);
            isGUCian.CommandType = CommandType.StoredProcedure;

            SqlParameter id1 = new SqlParameter("@studentID", SqlDbType.Int);
            id1.Value = Session["userId"];
            SqlParameter id2 = new SqlParameter("@studentID", SqlDbType.Int);
            id2.Value = Session["userId"];
            SqlParameter gucian = new SqlParameter("@GUCian", SqlDbType.Bit);
            gucian.Direction = ParameterDirection.Output;

            profile.Parameters.Add(id1);
            isGUCian.Parameters.Add(id2);
            isGUCian.Parameters.Add(isGUCian);

            database.Open();
            isGUCian.ExecuteNonQuery();
            SqlDataReader reader = profile.ExecuteReader();
            reader.Read();

            String first = reader.GetString(reader.GetOrdinal("firstName"));
            String last = reader.GetString(reader.GetOrdinal("lastName"));
            String type = reader.GetString(reader.GetOrdinal("type"));
            String faculty = reader.GetString(reader.GetOrdinal("faculty"));
            String address = reader.GetString(reader.GetOrdinal("address"));
            decimal gpa = reader.GetDecimal(reader.GetOrdinal("GPA"));
            Welcome.InnerText = "Welcome " + first;
            fullName.InnerText = "Name: " + first + " " + last;
            Type.InnerText = "Type: " + type;
            Faculty.InnerText = "Faculty: " + faculty;
            Address.InnerText = "Address: " + address;
            GPA.InnerText = "GPA: " + gpa;

            if((bool) gucian.Value)
            {
                Courses.Visible = false;
                Courses.Enabled = false;
                underGradID.InnerText = "UnderGrad ID: " + reader.GetInt32(reader.GetOrdinal("undergradID"));
            }
            database.Close();
        }

        protected void ShowTheses(object sender, EventArgs e)
        {
            Response.Redirect("~/Theses.aspx");
        }

        protected void ShowCourses(object sender, EventArgs e)
        {
            Response.Redirect("~/Courses.aspx");
        }
    }
}