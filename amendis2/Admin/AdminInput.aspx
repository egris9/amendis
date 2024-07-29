<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminInput.aspx.cs" Inherits="amendis2.Admin.AdminInput" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <main>
        <div class="mb-5 ml-36 mt-8 flex">
            <div>
                <h2 class="text-3xl font-medium">Saisie des Détails d'AO</h2>
            </div>
        </div>
        <br />
        <div class="max-w-[85%] mx-auto mb-5 flex w-full flex-col items-start">
            <div class="mb-4">
                <label for="NumeroAo" class="block text-lg font-medium">Numero_Ao:</label>
                <asp:TextBox ID="NumeroAoTextBox" runat="server" CssClass="h-10 rounded border px-5"></asp:TextBox>
            </div>
            <div class="mb-4">
                <label for="Designation" class="block text-lg font-medium">Désignation:</label>
                <asp:TextBox ID="DesignationTextBox" runat="server" CssClass="h-10 rounded border px-5"></asp:TextBox>
            </div>
            <div class="mb-4">
                <label for="PdfFile" class="block text-lg font-medium">Fichier PDF:</label>
                <asp:FileUpload ID="PdfFileUpload" runat="server" CssClass="h-11 rounded border px-5" />
            </div>
            <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="ml-24 mt-4 rounded bg-neutral-700 px-10 py-2 text-white" OnClick="SubmitButton_Click" />
             <asp:Label ID="MessageLabel" runat="server" CssClass="mt-4 block text-lg font-medium text-red-600" Visible="false"></asp:Label>
        </div>
    </main>
</asp:Content>
