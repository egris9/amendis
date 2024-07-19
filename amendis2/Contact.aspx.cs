using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            bool isAnonymous = selectedValue == "3";

            PanelCompanyName.Visible = !isAnonymous;
            PanelFullName.Visible = !isAnonymous;
            PanelPhoneNumber.Visible = !isAnonymous;
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Retrieve form values
            string requestType = RequestTypeDropDown.SelectedValue;
            string companyName = CompanyNameTextBox.Text;
            string fullName = FullNameTextBox.Text;
            string phoneNumber = PhoneNumberTextBox.Text;
            string email = EmailTextBox.Text;
            string message = MessageTextBox.Text;

            // Implement your logic here, for example:
            // - Validate input
            // - Save data to a database
            // - Send an email
            // - Display a success message

            // For demonstration, let's display the collected data
            Response.Write("<script>alert('Form Submitted Successfully!');</script>");
            Response.Write("<br />Type de demande: " + requestType);
            Response.Write("<br />Nom de la société: " + companyName);
            Response.Write("<br />Nom/Prénom: " + fullName);
            Response.Write("<br />N° de Téléphone: " + phoneNumber);
            Response.Write("<br />Email: " + email);
            Response.Write("<br />Message: " + message);


            string response = Request["g-recaptcha-response"];
            string secretKey = "6LdsEBQqAAAAAFEmoBWDDTOilOd7OY7jdwecU1Uq";
            var client = new WebClient();
            var result = client.DownloadString($"https://www.google.com/recaptcha/api/siteverify?secret={secretKey}&response={response}");
            var obj = new JavaScriptSerializer().Deserialize<RecaptchaResponse>(result);

            if (obj.success)
            {
                // La validation reCAPTCHA a réussi, procédez avec le traitement du formulaire
                Response.Write("reCAPTCHA validation successful.");
            }
            else
            {
                // La validation reCAPTCHA a échoué, affichez un message d'erreur
                Response.Write("reCAPTCHA validation failed. Please try again.");
            }
        }

    }
    public class RecaptchaResponse
    {
        public bool success { get; set; }
        public string[] errorCodes { get; set; }
    }


}