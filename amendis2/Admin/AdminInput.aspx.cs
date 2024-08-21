using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace amendis2.Admin
{
    public partial class AdminInput : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.IsInRole("admin"))
            {
                Response.Redirect("~/Acceuil.aspx"); // Rediriger vers une page d'accès refusé
            }
            if (!IsPostBack)
            {
                string numeroAo = Request.QueryString["Numero_Ao"];
                if (!string.IsNullOrEmpty(numeroAo))
                {
                    // Fetch the Designation from the database based on Numero_Ao
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
                    BindPdfRepeater();
                }
            }
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string numeroAo = NumeroAoLabel.Text;

            // Ensure that the PDF upload controls are present on the page
            var libelleTextBox = LibelleTextBox;
            var fileUpload = PdfFileUpload;

            if (libelleTextBox != null && fileUpload != null)
            {
                string libelle = libelleTextBox.Text.Trim();
                string fileName = Path.GetFileName(fileUpload.PostedFile.FileName); // Get the file name only

                if (fileUpload.HasFile)
                {
                    // Validate file type
                    if (fileUpload.PostedFile.ContentType != "application/pdf")
                    {
                        MessageLabel.Text = "Please upload only PDF files.";
                        MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                        MessageLabel.Visible = true;
                        return;
                    }

                    // Check if the file already exists in the database
                    if (FileExistsInDatabase(numeroAo, fileName))
                    {
                        MessageLabel.Text = "The file already exists for this Numero_Ao.";
                        MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                        MessageLabel.Visible = true;
                        return;
                    }

                    try
                    {
                        // Save the uploaded file
                        string uploadsFolder = Server.MapPath("~/Uploads");
                        if (!Directory.Exists(uploadsFolder))
                        {
                            Directory.CreateDirectory(uploadsFolder);
                        }

                        string filePath = Path.Combine(uploadsFolder, fileName);
                        fileUpload.SaveAs(filePath);

                        // Save file details to the database
                        SaveDetailsToDatabase(numeroAo, libelle, fileName);
                        BindPdfRepeater();

                        // Provide feedback to the user
                        MessageLabel.Text = "File uploaded successfully.";
                        MessageLabel.CssClass = "mt-4 block text-lg font-medium text-green-600";
                        MessageLabel.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        // Handle errors during file save or database update
                        MessageLabel.Text = "An error occurred: " + ex.Message;
                        MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                        MessageLabel.Visible = true;
                    }
                }
                else
                {
                    MessageLabel.Text = "Please select a file.";
                    MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                    MessageLabel.Visible = true;
                }
            }
            else
            {
                MessageLabel.Text = "Please enter a libelle and upload a file.";
                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                MessageLabel.Visible = true;
            }
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            string fileName = (sender as Button).CommandArgument;
            string numeroAo = NumeroAoLabel.Text;

            if (!string.IsNullOrEmpty(fileName))
            {
                // Delete file from the server
                string filePath = Server.MapPath("~/Uploads/" + fileName);
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }

                // Delete file details from the database
                DeleteFileFromDatabase(numeroAo, fileName);

                // Refresh the Repeater control to reflect the changes
                BindPdfRepeater();
            }
        }

        private void DeleteFileFromDatabase(string numeroAo, string fileName)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "DELETE FROM AdminUploads WHERE Numero_Ao = @NumeroAo AND FileName = @FileName";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@NumeroAo", numeroAo);
                        command.Parameters.AddWithValue("@FileName", fileName);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                // Handle SQL exception or log it as needed
                throw new ApplicationException("An error occurred while deleting the file from the database.", ex);
            }
        }
        private void BindPdfRepeater()
        {
            // Fetch the updated data from the database and bind it to the Repeater control
            string numeroAo = NumeroAoLabel.Text;
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT Libelle, FileName FROM AdminUploads WHERE Numero_Ao = @NumeroAo";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@NumeroAo", numeroAo);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    PdfRepeater.DataSource = reader;
                    PdfRepeater.DataBind();
                }
            }
        }
        private bool FileExistsInDatabase(string numeroAo, string fileName)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "SELECT COUNT(*) FROM AdminUploads WHERE Numero_Ao = @NumeroAo AND FileName = @FileName";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@NumeroAo", numeroAo);
                        command.Parameters.AddWithValue("@FileName", fileName);

                        connection.Open();
                        int count = (int)command.ExecuteScalar();
                        return count > 0;
                    }
                }
            }
            catch (SqlException ex)
            {
                // Handle SQL exception or log it as needed
                throw new ApplicationException("An error occurred while checking file existence in the database.", ex);
            }
        }

        private void SaveDetailsToDatabase(string numeroAo, string libelle, string fileName)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "INSERT INTO AdminUploads (Numero_Ao, Libelle, FileName) VALUES (@NumeroAo, @Libelle, @FileName)";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@NumeroAo", SqlDbType.NVarChar, 100).Value = numeroAo;
                        command.Parameters.Add("@Libelle", SqlDbType.NVarChar, 255).Value = libelle;
                        command.Parameters.Add("@FileName", SqlDbType.NVarChar, 255).Value = fileName;

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (SqlException ex)
            {
                // Log the SQL exception or handle it as needed
                throw new ApplicationException("An error occurred while saving details to the database.", ex);
            }
            catch (Exception ex)
            {
                // Log general exceptions or handle them as needed
                throw new ApplicationException("An unexpected error occurred.", ex);
            }
        }
    }
}