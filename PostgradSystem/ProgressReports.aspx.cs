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
    public partial class ProgressReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand getPublications = new SqlCommand("viewStudentProgressReports", connection);
            getPublications.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();
            SqlDataReader table = getPublications.ExecuteReader();
            while (table.Read())
            {
                TableRow row = new TableRow();

                TableCell no = new TableCell();
                no.Text = "" + table.GetInt32(table.GetOrdinal("NO"));

                TableCell description = new TableCell();
                description.Text = "" + table.GetString(table.GetOrdinal("description"));

                TableCell date = new TableCell();
                date.Text = "" + table.GetDateTime(table.GetOrdinal("date"));

                TableCell state = new TableCell();
                state.Text = "" + table.GetString(table.GetOrdinal("state"));

                row.Cells.Add(no);
                row.Cells.Add(description);
                row.Cells.Add(date);
                row.Cells.Add(state);
            }
            connection.Close();
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand add = new SqlCommand("AddProgressReportToOngoingThesis", connection);
            add.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter id = new SqlParameter("@studentID", SqlDbType.Int);
            id.Value = (int)Session["userId"];
            SqlParameter no = new SqlParameter("@ReportNo", SqlDbType.Int);
            SqlParameter date = new SqlParameter("@Date", SqlDbType.DateTime);
            SqlParameter success = new SqlParameter("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;
            
            try
            {
                no.Value = Int32.Parse(number1.Text);
            }
            catch(Exception ex)
            {
                Response.Write("Invalid Report Number");
                return;
            }
            if(Calendar.SelectedDate.Date == DateTime.MinValue)
            {
                Response.Write("Please Provide a Date");
                return;
            }
            date.Value = Calendar.SelectedDate.Date;

            add.Parameters.Add(id);
            add.Parameters.Add(no);
            add.Parameters.Add(date);
            add.Parameters.Add(success);

            connection.Open();
            add.ExecuteNonQuery();
            connection.Close();

            if((bool) success.Value)
                Response.Write("You either entered an invalid report number or don't have an ongoing Thesis");
            else
                Response.Write("Done");
        }

        protected void Theses_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Theses.aspx");
        }

        protected void fill_Click(object sender, EventArgs e)
        {
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand fill = new SqlCommand("FillProgressReportForOngoingThesis", connection);
            fill.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter id = new SqlParameter("@studentID", SqlDbType.Int);
            id.Value = (int)Session["userId"];
            SqlParameter no = new SqlParameter("@ReportNo", SqlDbType.Int);
            SqlParameter des = new SqlParameter("@description", SqlDbType.VarChar);
            SqlParameter st = new SqlParameter("@state", SqlDbType.Int);
            SqlParameter success = new SqlParameter("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;

            try
            {
                no.Value = Int32.Parse(number2.Text);
                st.Value = Int32.Parse(state.Text);
            }
            catch (Exception ex)
            {
                Response.Write("Invalid Report Number or State");
                return;
            }

            des.Value = description.Text;
            fill.Parameters.Add(id);
            fill.Parameters.Add(no);
            fill.Parameters.Add(description);
            fill.Parameters.Add(st);
            fill.Parameters.Add(success);

            connection.Open();
            fill.ExecuteNonQuery();
            connection.Close();

            if ((bool) success.Value)
                Response.Write("Invalid Report Number");
            else
                Response.Write("Done");
        }
    }
}