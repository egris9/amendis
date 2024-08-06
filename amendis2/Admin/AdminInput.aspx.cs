using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
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
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Trim the values from the text boxes
            string numeroAo = NumeroAoTextBox.Text.Trim();
            string designation = DesignationTextBox.Text.Trim();

            // Check if the required fields are not empty
            if (string.IsNullOrEmpty(numeroAo))
            {
                MessageLabel.Text = "Numero_Ao is required.";
                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                MessageLabel.Visible = true;
                return; // Exit if validation fails
            }

            if (string.IsNullOrEmpty(designation))
            {
                MessageLabel.Text = "Désignation is required.";
                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                MessageLabel.Visible = true;
                return; // Exit if validation fails
            }

            // Validate PDF file upload
            if (PdfFileUpload.HasFiles)
            {
                bool allFilesValid = true;
                foreach (HttpPostedFile uploadedFile in PdfFileUpload.PostedFiles)
                {
                    if (uploadedFile.ContentType != "application/pdf")
                    {
                        allFilesValid = false;
                        break;
                    }
                }

                if (!allFilesValid)
                {
                    MessageLabel.Text = "Please upload only PDF files.";
                    MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                    MessageLabel.Visible = true;
                    return; // Exit if validation fails
                }

                try
                {
                    // Save the uploaded files
                    string uploadsFolder = Server.MapPath("~/Uploads");
                    if (!Directory.Exists(uploadsFolder))
                    {
                        Directory.CreateDirectory(uploadsFolder);
                    }

                    foreach (HttpPostedFile uploadedFile in PdfFileUpload.PostedFiles)
                    {
                        string fileName = Path.GetFileName(uploadedFile.FileName);
                        string filePath = Path.Combine(uploadsFolder, fileName);
                        if (FileExistsInDatabase(numeroAo, fileName))
                        {
                            MessageLabel.Text = "The file already exists for this Numero_Ao.";
                            MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                            MessageLabel.Visible = true;
                            return; // Exit if the file already exists
                        }
                        uploadedFile.SaveAs(filePath);

                        // Save details to the database for each file
                        SaveDetailsToDatabase(numeroAo, designation, fileName);
                    }

                    MessageLabel.Text = "Details and files uploaded successfully.";
                    MessageLabel.CssClass = "mt-4 block text-lg font-medium text-green-600";
                    MessageLabel.Visible = true;
                }
                catch (Exception ex)
                {
                    MessageLabel.Text = "An error occurred: " + ex.Message;
                    MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                    MessageLabel.Visible = true;
                }
            }
            else
            {
                MessageLabel.Text = "Please upload at least one PDF file.";
                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                MessageLabel.Visible = true;
            }
        }
        private bool FileExistsInDatabase(string numeroAo, string fileName)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
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

        private void SaveDetailsToDatabase(string numeroAo, string designation, string filename)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string query = "INSERT INTO AdminUploads (Numero_Ao, Designation, FileName) VALUES (@NumeroAo, @Designation, @FileName)";

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Use parameters to prevent SQL injection
                        command.Parameters.Add("@NumeroAo", SqlDbType.NVarChar, 100).Value = numeroAo;
                        command.Parameters.Add("@Designation", SqlDbType.NVarChar, 255).Value = designation;
                        command.Parameters.Add("@FileName", SqlDbType.NVarChar, 255).Value = filename;

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