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
    public partial class AddPublication : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            if(Title.Text.Length == 0 || Date.SelectedDate.Date == DateTime.MinValue)
                Response.Write("Please Enter Title and Date");
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand add = new SqlCommand("addPublication", connection);
            add.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter title = new SqlParameter("@title", SqlDbType.VarChar);
            title.Value = Title.Text;

            SqlParameter date = new SqlParameter("@pubDate", SqlDbType.DateTime);
            date.Value = Date.SelectedDate.Date;

            SqlParameter host = new SqlParameter("@host", SqlDbType.VarChar);
            host.Value = Host.Text;

            SqlParameter place = new SqlParameter("@place", SqlDbType.VarChar);
            place.Value = Place.Text;

            SqlParameter accept = new SqlParameter("@accepted", SqlDbType.Bit);
            accept.Value = Accept.Checked ? 1 : 0;
            
            add.Parameters.Add(title);
            add.Parameters.Add(date);
            add.Parameters.Add(host);
            add.Parameters.Add(place);
            add.Parameters.Add(accept);

            connection.Open();
            add.ExecuteNonQuery();
            connection.Close();
            Response.Redirect("~/Publications.aspx");
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Publications.aspx");
        }
    }
}