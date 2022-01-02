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
            if (Session["userId"] == null || Session["userType"] == null || (string)Session["userType"] != "student") {
                Response.Redirect("login.aspx");
            }

            String connect = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection database = new SqlConnection(connect);

            SqlCommand profile = new SqlCommand("viewMyProfile", database);
            profile.CommandType = CommandType.StoredProcedure;

            SqlCommand isGUCian = new SqlCommand("isGUCian", database);
            isGUCian.CommandType = CommandType.StoredProcedure;

            SqlParameter id1 = new SqlParameter("@studentId", SqlDbType.Int);
            id1.Value = Session["userId"];
            SqlParameter id2 = new SqlParameter("@studentId", SqlDbType.Int);
            id2.Value = Session["userId"];
            SqlParameter gucian = new SqlParameter("@GUCian", SqlDbType.Bit);
            gucian.Direction = ParameterDirection.Output;

            profile.Parameters.Add(id1);
            isGUCian.Parameters.Add(id2);
            isGUCian.Parameters.Add(gucian);

            database.Open();
            isGUCian.ExecuteNonQuery();
            SqlDataReader reader = profile.ExecuteReader();
            reader.Read();

            String first = getString(reader, "firstName");
            String last = getString(reader, "lastName");
            String type = getString(reader, "type");
            String faculty = getString(reader, "faculty");
            String address = getString(reader, "address");
            Welcome.InnerText = "Welcome " + first;
            fullName.InnerText = "Name: " + first + " " + last;
            Type.InnerText = "Type: " + type;
            Faculty.InnerText = "Faculty: " + faculty;
            Address.InnerText = "Address: " + address;
            GPA.InnerText = "GPA: " + getDecimal(reader, "GPA");

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

        protected void LogOut_Click(Object sender, EventArgs e)
        {
            Session["userId"] = null;
            Session["userType"] = null;
            Response.Redirect("~/login.aspx");
        }

        protected bool isNumber(String s)
        {
            for(int i = 0; i < s.Length; i++)
            {
                if (s[i] > '9' || s[i] < '0')
                    return false;
            }
            return true;
        }

        protected void addPhone_Click(Object sender, System.EventArgs e)
        {
            Response.Redirect("ManagePhones.aspx");
        }
    }
}