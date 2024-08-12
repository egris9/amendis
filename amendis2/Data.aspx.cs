using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
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
            {       string numeroAo = Request.QueryString["Numero_Ao"];
                    LoadData(numeroAo);
                if (!string.IsNullOrEmpty(Request.QueryString["Numero_Ao"]))
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "SELECT Designa FROM V_AO_AO WHERE Numero_Ao = @Numero_Ao";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Numero_Ao", numeroAo);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            NumeroAoLabel.Text = numeroAo;
                            DesignationLabel.Text = result.ToString();
                        }
                    }
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
            string query = "SELECT Numero_Ao, Libelle, FileName FROM AdminUploads WHERE Numero_Ao = @NumeroAo";

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

                            // Check for any rows in the DataTable
                            Console.WriteLine("DataTable row count: " + dataTable.Rows.Count);
                            foreach (DataRow row in dataTable.Rows)
                            {
                                Console.WriteLine($"Libelle: {row["Libelle"]}, FileName: {row["FileName"]}");
                            }

                            // Bind the data to the Repeater
                            PdfRepeater.DataSource = dataTable;
                            PdfRepeater.DataBind();

                            // Check if the Repeater control is adding any extra rows
                            Console.WriteLine("Repeater row count: " + PdfRepeater.Items.Count);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log it)
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}