using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace amendis2
{
    public partial class Data : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["Numero_Ao"]))
                {
                    string numeroAo = Request.QueryString["Numero_Ao"];
                    LoadData(numeroAo);
                }
                else
                {
                    // Gérer le cas où Numero_Ao n'est pas fourni
                    Response.Redirect("~/ErrorPage.aspx");
                }
            }
        }
        private void LoadData(string numeroAo)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT Numero_Ao, Designation, FileName FROM AdminUploads WHERE Numero_Ao = @NumeroAo";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@NumeroAo", numeroAo);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            DataTable dataTable = new DataTable();
                            dataTable.Load(reader);

                            if (dataTable.Rows.Count > 0)
                            {
                                DataRow firstRow = dataTable.Rows[0];
                                NumeroAoLabel.Text = firstRow["Numero_Ao"].ToString();
                                DesignationLabel.Text = firstRow["Designation"].ToString();
                                PdfRepeater.DataSource = dataTable;
                                PdfRepeater.DataBind();
                            }
                            else
                            {
                                // Handle the case where no records are found
                                NumeroAoLabel.Text = "Pas d'information pour le moment";
                                DesignationLabel.Text = "Pas d'information pour le moment";
                                PdfRepeater.DataSource = null;
                                PdfRepeater.DataBind();
                            }
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                // Gérer l'exception SQL ou la journaliser
                throw new ApplicationException("Une erreur s'est produite lors de la récupération des détails de la base de données.", ex);
            }
        }
    }
}