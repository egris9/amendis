<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="amendis2.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <main aria-labelledby="title">
            <div class="container mx-auto mb-12 flex flex-col p-4 text-sm sm:text-base 2xl:text-lg">
                <h2 class="mb-10 flex justify-center text-3xl font-medium lg:text-4xl">Nous Contacter</h2>
                <div class="mb-6 flex items-center space-x-4">
                    <label for="<%= RequestTypeDropDown.ClientID %>" class="font-medium">Type de demande :</label>
                    <asp:DropDownList ID="RequestTypeDropDown" runat="server" CssClass="rounded border border-gray-300 p-1 sm:w-72" AutoPostBack="true" OnSelectedIndexChanged="RequestTypeDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="Demande d'info" Value="Demande d'info"></asp:ListItem>
                        <asp:ListItem Text="Reclamation" Value="Reclamation"></asp:ListItem>
                        <asp:ListItem Text="Reclamation anonyme" Value="Reclamation anonyme"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <asp:Panel ID="PanelCompanyName" runat="server">
                    <div class="mb-6 flex items-center space-x-4">
                        <label for="companyName" class="font-medium">Nom de la société :</label>
                        <asp:TextBox ID="CompanyNameTextBox" runat="server" CssClass="rounded border border-gray-300 p-1 sm:w-72" Placeholder="Nom de la société" />
                    </div>
                </asp:Panel>


                <asp:Panel ID="PanelFullName" runat="server">
                    <div class="mb-6 flex items-center space-x-12">
                        <label for="fullName" class="font-medium">Nom/Prénom :</label>
                        <asp:TextBox ID="FullNameTextBox" runat="server" CssClass="rounded border border-gray-300 p-1 sm:w-72" Placeholder="Nom/Prénom" />
                    </div>
                </asp:Panel>


                <asp:Panel ID="PanelPhoneNumber" runat="server">
                    <div class="mb-6 flex items-center space-x-6">
                        <label for="phoneNumber" class="font-medium">N° de Téléphone :</label>
                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" CssClass="rounded border border-gray-300 p-1 sm:w-72" Placeholder="N° de Téléphone" />
                    </div>
                </asp:Panel>


                <div class="mb-4 flex items-center">
                    <label for="email" class="block font-medium">Email :</label>
                    <asp:TextBox ID="EmailTextBox" runat="server" CssClass="ml-28 rounded border border-gray-300 p-1 sm:ml-28 sm:w-72" Placeholder="Email" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="EmailTextBox" runat="server" ErrorMessage="Saisir une adresse email valide" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
                </div>
                <div class="mb-4 flex items-center space-x-20">
                    <label for="message" class="block font-medium">Message :</label>
                    <asp:TextBox ID="MessageTextBox" runat="server" TextMode="MultiLine" CssClass="rounded border border-gray-300 p-2 sm:w-72" Height="92px" Placeholder="Message" />
                </div>
                <div class="g-recaptcha ml-28 mt-7" data-sitekey="6LdsEBQqAAAAAGYAyu6lzR0Tn7a7TnhKlyqy2Jfz"></div>
                <div class="mb-4 mt-11 flex">
                    <asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" CssClass="ml-52 rounded bg-neutral-700 px-10 py-2 text-white"/>
                </div>
            </div>
        </main>
</asp:Content>
