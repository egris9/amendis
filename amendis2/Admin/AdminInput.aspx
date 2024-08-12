<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminInput.aspx.cs" Inherits="amendis2.Admin.AdminInput" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <main class="mx-auto mt-8 max-w-7xl px-4 py-8">
        <div class="mb-8">
            <h2 class="text-2xl font-medium">Saisie des Détails d'AO</h2>
        </div>
        <div class="space-y-6">
            <div class="flex items-center space-x-4">
                <h3 class="text-lg font-medium">Numero AO:</h3>
                <asp:Label ID="NumeroAoLabel" runat="server" CssClass="text-lg font-medium"></asp:Label>
            </div>

            <div class="flex items-center space-x-4">
                <h3 class="text-lg font-medium">Designation:</h3>
                <asp:Label ID="DesignationLabel" runat="server" CssClass="text-lg font-medium"></asp:Label>
            </div>

            <table id="pdfTable" runat="server" class="w-full border-collapse border border-gray-200">
                <thead>
                    <tr class="bg-gray-100 text-left">
                        <th class="border-b px-6 py-4 text-lg">Libelle</th>
                        <th class="border-b px-6 py-4 text-lg">Fichier PDF</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="border px-8 py-6">
                            <asp:TextBox ID="LibelleTextBox" runat="server" CssClass="h-12 w-full rounded border border-gray-300 px-3 text-center text-lg" aria-label="Libelle"></asp:TextBox>
                        </td>
                        <td class="border px-6 py-4">
                            <asp:FileUpload ID="PdfFileUpload" runat="server" CssClass="h-12 w-full rounded border border-gray-300 px-3 text-lg" aria-label="Fichier PDF" />
                        </td>
                    </tr>
                </tbody>
            </table>

            <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="mt-4 rounded bg-neutral-700 px-10 py-2 text-white" OnClick="SubmitButton_Click" aria-label="Submit" />
            <asp:Label ID="MessageLabel" runat="server" CssClass="mt-4 text-lg font-medium text-red-600" Visible="false"></asp:Label>
        </div>
    </main>
</asp:Content>
