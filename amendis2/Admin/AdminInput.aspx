<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminInput.aspx.cs" Inherits="amendis2.Admin.AdminInput" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <main>
        <div class="mb-5 ml-20 mt-8 flex sm:ml-36">
            
                <h2 class="text-xl font-medium sm:text-3xl">Saisie des Détails d'AO</h2>
            
        </div>
        <br />
        <div class="max-w-[85%] mx-auto mb-5 flex w-full flex-col items-start">
            <div class="mb-4 flex items-center space-x-4">
                <h2 class="text-xl font-medium">Numero AO:</h2>
                <asp:Label ID="NumeroAoLabel" runat="server" CssClass="label-class text-xl"></asp:Label>
            </div>
            <div class="mb-4 flex items-center space-x-4">
                <h2 class="text-xl font-medium">Designation:</h2>
                <asp:Label ID="DesignationLabel" runat="server" CssClass="label-class text-xl"></asp:Label>
            </div>
           <table id="pdfTable" runat="server" class="w-full border-collapse">
                <thead>
                    <tr>
                        <th class="border-b-2 px-4 py-2 text-center">Libelle</th>
                        <th class="border-b-2 px-4 py-2 text-center">Fichier PDF</th>
                        <th class="border-b-2 px-4 py-2"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="border px-4 py-2">
                            <asp:TextBox ID="LibelleTextBox" runat="server" CssClass="h-11 w-full rounded border px-1 text-center"></asp:TextBox>
                        </td>
                        <td class="border px-4 py-2">
                            <asp:FileUpload ID="PdfFileUpload" runat="server" CssClass="h-11 w-full items-center rounded border px-1" />
                        </td>
                        <td class="border px-4 py-2">
                            <asp:Button ID="AddRowButton" runat="server" Text="+" OnClick="AddRowButton_Click" CssClass="text-xl font-bold text-blue-500" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="ml-24 mt-8 rounded bg-neutral-700 px-10 py-2 text-white" OnClick="SubmitButton_Click" />
             <asp:Label ID="MessageLabel" runat="server" CssClass="mt-4 block text-lg font-medium text-red-600" Visible="false"></asp:Label>
        </div>
    </main>
</asp:Content>
