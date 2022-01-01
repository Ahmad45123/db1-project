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
    public partial class Publications : System.Web.UI.Page
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

            SqlCommand getPublications = new SqlCommand("ViewAllPublications", connection);
            getPublications.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();
            SqlDataReader table = getPublications.ExecuteReader();
            
            while (table.Read())
            {
                TableRow row = new TableRow();
                
                TableCell id = new TableCell();
                id.Text = getInt(table, "id");
                
                TableCell title = new TableCell();
                title.Text = getString(table, "title");
                
                TableCell dateOfPublication = new TableCell();
                dateOfPublication.Text = getDate(table, "dateOfPublication");
                
                TableCell place = new TableCell();
                place.Text = getString(table, "place");

                TableCell accepted = new TableCell();
                accepted.Text = (table.GetBoolean(table.GetOrdinal("accepted")) == true ? "YES" : "NO");
                
                TableCell HOST = new TableCell();
                HOST.Text = getString(table, "HOST");

                row.Cells.Add(id);
                row.Cells.Add(title);
                row.Cells.Add(dateOfPublication);
                row.Cells.Add(place);
                row.Cells.Add(accepted);
                row.Cells.Add(HOST);
                Publication.Rows.Add(row);
            }

            connection.Close();
        }

        protected void Theses_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Theses.aspx");
        }

        protected void Link_Click(object sender, EventArgs e)
        {
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand linkPublication = new SqlCommand("LinkPublicationToOngoingThesis", connection);
            linkPublication.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter sid = new SqlParameter("@sID", SqlDbType.Int);
            sid.Value = (int)Session["userId"];

            SqlParameter pubID;
            try
            {
                pubID = new SqlParameter("@pubID", SqlDbType.Int);
                pubID.Value = Int32.Parse(PublicationID.Text);
            }catch(Exception ex)
            {
                Response.Write("Error: You either have no ongoing Thesis or entered a wrong publication ID.");
                return;
            }

            SqlParameter success = new SqlParameter("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;

            linkPublication.Parameters.Add(sid);
            linkPublication.Parameters.Add(pubID);
            linkPublication.Parameters.Add(success);

            connection.Open();
            linkPublication.ExecuteNonQuery();
            connection.Close();

            if (!(bool)success.Value)
                Response.Write("Error: You either have no ongoing Thesis or entered invalid publication ID.");
            else
            {
                Response.Write("<script language=javascript>alert('Done');</script>");
            }
        }

        protected void add_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AddPublication.aspx");
        }
    }
}