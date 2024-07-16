using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
        }
    }
}