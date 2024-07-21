using System;
using System.Collections.Generic;
using Email_service.Mailtrap;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using FluentEmail.Core;
using FluentEmail.Core.Models;
using FluentEmail.Smtp;
using FluentEmail.Core.Interfaces;
using Microsoft.Ajax.Utilities;

namespace amendis2
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateFieldVisibility();
            }

        }
        protected void RequestTypeDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateFieldVisibility();
        }

        private void UpdateFieldVisibility()
        {
            string selectedValue = RequestTypeDropDown.SelectedValue;
            bool isAnonymous = selectedValue == "Reclamation anonyme";

            PanelCompanyName.Visible = !isAnonymous;
            PanelFullName.Visible = !isAnonymous;
            PanelPhoneNumber.Visible = !isAnonymous;
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate reCAPTCHA first
                string response = Request["g-recaptcha-response"];
                string secretKey = "6LdsEBQqAAAAAFEmoBWDDTOilOd7OY7jdwecU1Uq";
                var client = new WebClient();
                var result = client.DownloadString($"https://www.google.com/recaptcha/api/siteverify?secret={secretKey}&response={response}");
                var obj = new JavaScriptSerializer().Deserialize<RecaptchaResponse>(result);

                if (!obj.success)
                {
                    // reCAPTCHA validation failed
                    Response.Write("reCAPTCHA validation failed. Please try again.");
                    return; // Stop further processing
                }

                // Gather the form data
                string requestType = RequestTypeDropDown.SelectedValue;
                string companyName = CompanyNameTextBox.Text;
                string fullName = FullNameTextBox.Text;
                string phoneNumber = PhoneNumberTextBox.Text;
                string email = EmailTextBox.Text; // User's email
                string message = MessageTextBox.Text;
                string emailBody;

                if (requestType != "Reclamation anonyme")
                {
                    emailBody =   $"Type de demande: {requestType}\n" +
                                  $"Message: {message}\n" +
                                  $"Nom de la société: {companyName}\n" +
                                  $"Nom/Prénom: {fullName}\n" +
                                  $"N° de Téléphone: {phoneNumber}\n";
                }
                else {
                    emailBody = $"Type de demande: {requestType}\n" +
                                  $"Message: {message}\n";
                                  
                }
               

                


                IFluentEmail fluentEmail = Email
                    .From(System.Web.Configuration.WebConfigurationManager.AppSettings["email_from"])
                    .To(System.Web.Configuration.WebConfigurationManager.AppSettings["email_to"])
                    .Subject("contact us "+ email)
                    .Body(emailBody);

                MailtrapSender test = new MailtrapSender();
                test.Send(fluentEmail);

            }
            catch (Exception ex)
            {
                // Handle any errors
                Response.Write($"<script>alert('Erreur lors de l'envoi du message: {ex.Message}');</script>");
            }
        }
    }
    public class RecaptchaResponse
    {
        public bool success { get; set; }
        public string[] errorCodes { get; set; }
    }


}