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
            if (!PdfFileUpload.HasFile || PdfFileUpload.PostedFile.ContentType != "application/pdf")
            {
                MessageLabel.Text = "Please upload a valid PDF file.";
                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                MessageLabel.Visible = true;
                return; // Exit if validation fails
            }

            try
            {
                // Save the uploaded file
                string uploadsFolder = Server.MapPath("~/Admin/Uploads/");
                if (!Directory.Exists(uploadsFolder))
                {
                    Directory.CreateDirectory(uploadsFolder);
                }

                string fileName = Path.GetFileName(PdfFileUpload.PostedFile.FileName);
                string filePath = Path.Combine(uploadsFolder, fileName);
                PdfFileUpload.SaveAs(filePath);

                // Save details to the database
                SaveDetailsToDatabase(numeroAo, designation, fileName);

                MessageLabel.Text = "Details and file uploaded successfully.";
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