﻿using System;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand getPublications = new SqlCommand("ViewAllPublications", connection);
            getPublications.CommandType = System.Data.CommandType.StoredProcedure;

            connection.Open();
            SqlDataReader table = getPublications.ExecuteReader();
            connection.Close();
            while (table.Read())
            {
                TableRow row = new TableRow();
                
                TableCell id = new TableCell();
                id.Text = "" + table.GetInt32(table.GetOrdinal("id"));
                
                TableCell title = new TableCell();
                title.Text = "" + table.GetString(table.GetOrdinal("title"));
                
                TableCell dateOfPublication = new TableCell();
                dateOfPublication.Text = "" + table.GetDateTime(table.GetOrdinal("dateOfPublication"));
                
                TableCell place = new TableCell();
                place.Text = "" + table.GetString(table.GetOrdinal("place"));
                
                TableCell accepted = new TableCell();
                accepted.Text = "" + (table.GetInt32(table.GetOrdinal("accepted")) == 1 ? "YES" : "NO");
                
                TableCell HOST = new TableCell();
                HOST.Text = "" + table.GetString(table.GetOrdinal("HOST"));

                row.Cells.Add(id);
                row.Cells.Add(title);
                row.Cells.Add(dateOfPublication);
                row.Cells.Add(place);
                row.Cells.Add(accepted);
                row.Cells.Add(HOST);
                Publication.Rows.Add(row);
            }
        }

        protected void Theses_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Thesis.aspx");
        }

        protected void Link_Click(object sender, EventArgs e)
        {
            String connectionString = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection connection = new SqlConnection(connectionString);

            SqlCommand linkPublication = new SqlCommand("LinkPublicationToOngoingThesis", connection);
            linkPublication.CommandType = System.Data.CommandType.StoredProcedure;

            SqlParameter sid = new SqlParameter("@StudentID", SqlDbType.Int);
            sid.Value = (int)Session["userId"];

            SqlParameter pubID = new SqlParameter("@pubID", SqlDbType.Int);
            sid.Value = PublicationID.Text;

            SqlParameter success = new SqlParameter("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;

            linkPublication.Parameters.Add(sid);
            linkPublication.Parameters.Add(pubID);

            connection.Open();
            linkPublication.ExecuteNonQuery();
            connection.Close();

            if ((int)success.Value == 0)
                Response.Write("Error: You either have no ongoing Thesis or entered a wrong publication ID.");
            else
                Response.Write("Done");
        }

        protected void add_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AddPublication.aspx");
        }
    }
}