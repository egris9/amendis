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
                }
            }
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            string numeroAo = NumeroAoLabel.Text;
            string designation = DesignationLabel.Text;

            if (pdfTable.Rows.Count > 0)
            {
                foreach (TableRow row in pdfTable.Rows)
                {
                    var libelleTextBox = (TextBox)row.FindControl("LibelleTextBox");
                    var fileUpload = (FileUpload)row.FindControl("PdfFileUpload");

                    if (libelleTextBox != null && fileUpload != null)
                    {
                        string fileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                        if (fileUpload.HasFile)
                        {
                            if (fileUpload.PostedFile.ContentType != "application/pdf")
                            {
                                MessageLabel.Text = "Please upload only PDF files.";
                                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                                MessageLabel.Visible = true;
                                return;
                            }

                            if (FileExistsInDatabase(numeroAo, fileName))
                            {
                                MessageLabel.Text = "The file already exists for this Numero_Ao.";
                                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                                MessageLabel.Visible = true;
                                return;
                            }

                            try
                            {
                                string uploadsFolder = Server.MapPath("~/Uploads");
                                if (!Directory.Exists(uploadsFolder))
                                {
                                    Directory.CreateDirectory(uploadsFolder);
                                }

                                string filePath = Path.Combine(uploadsFolder, fileName);
                                fileUpload.SaveAs(filePath);
                                SaveDetailsToDatabase(numeroAo, libelleTextBox.Text, fileName);
                            }
                            catch (Exception ex)
                            {
                                MessageLabel.Text = "An error occurred: " + ex.Message;
                                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                                MessageLabel.Visible = true;
                                return;
                            }
                        }
                    }
                }

                MessageLabel.Text = "Details and files uploaded successfully.";
                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-green-600";
                MessageLabel.Visible = true;
            }
            else
            {
                MessageLabel.Text = "Please upload at least one PDF file.";
                MessageLabel.CssClass = "mt-4 block text-lg font-medium text-red-600";
                MessageLabel.Visible = true;
            }
        }
        protected void AddRowButton_Click(object sender, EventArgs e)
        {
            HtmlTableRow newRow = new HtmlTableRow();

            HtmlTableCell libelleCell = new HtmlTableCell();
            TextBox libelleTextBox = new TextBox();
            libelleTextBox.ID = "LibelleTextBox" + pdfTable.Rows.Count;
            libelleTextBox.CssClass = "h-11 max-w-64 rounded border px-1";
            libelleCell.Controls.Add(libelleTextBox);
            newRow.Cells.Add(libelleCell);

            HtmlTableCell fileUploadCell = new HtmlTableCell();
            FileUpload fileUpload = new FileUpload();
            fileUpload.ID = "PdfFileUpload" + pdfTable.Rows.Count;
            fileUpload.CssClass = "h-11 max-w-64 rounded border px-1";
            fileUploadCell.Controls.Add(fileUpload);
            newRow.Cells.Add(fileUploadCell);

            HtmlTableCell buttonCell = new HtmlTableCell();
            Button addButton = new Button();
            addButton.ID = "AddRowButton" + pdfTable.Rows.Count;
            addButton.Text = "+";
            addButton.CssClass = "text-xl font-bold text-blue-500";
            addButton.Click += new EventHandler(AddRowButton_Click);
            buttonCell.Controls.Add(addButton);
            newRow.Cells.Add(buttonCell);

            pdfTable.Rows.Add(newRow);
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