<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminInput.aspx.cs" Inherits="amendis2.Admin.AdminInput" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <main class="mx-auto mt-8 max-w-7xl px-4 py-8">
        <div class="mb-8">
            <h2 class="text-2xl font-medium">Saisie des Détails d'AO</h2>
        </div>
        <div class="space-y-10">
            <div class="flex items-center space-x-4">
                <h3 class="text-xl font-bold">Numero AO:</h3>
                <asp:Label ID="NumeroAoLabel" runat="server" CssClass="ml-2 text-xl"></asp:Label>
            </div>

            <div class="flex items-center space-x-4">
                <h3 class="text-xl font-bold">Designation:</h3>
                <asp:Label ID="DesignationLabel" runat="server" CssClass="max-w-[80%] text-lg font-medium"></asp:Label>
            </div>

             <table class="w-full table-auto border-collapse flex-col border border-gray-300">
                 <thead class="bg-gray-200">
                     <tr>
                         <th class="w-1/3 p-4 text-center text-xl font-medium">Libelle</th>
                         <th class="w-1/3 p-4 text-center text-xl font-medium">Fichiers PDF</th>
                         <th class="w-1/3 p-4 text-center text-xl font-medium">Supprimer Fichiers PDF</th>
                     </tr>
                 </thead>

                 <tbody>
                     <tr >
                         <td class="text-center">
                             <asp:Label ID="LibelleLabel" runat="server" CssClass="h-10 text-xl"></asp:Label>
                         </td>

                        <td class="text-center">
                          <asp:Repeater ID="PdfRepeater" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td class="p-2 text-center">
                                            <asp:Label ID="LibelleLabel" runat="server" CssClass="text-xl"><%# Eval("Libelle") %></asp:Label>
                                        </td>
                                        <td class="p-2 text-left">
                                            <asp:HyperLink ID="PdfFileLink" runat="server" Text='<%# Eval("FileName") %>' NavigateUrl='<%# Eval("FileName", "~/Uploads/{0}") %>' Target="_blank" CssClass="hover:text-blue-500 ml-7"></asp:HyperLink>
                                        </td>
                                        <td class="text-center">
                                            <asp:Button ID="DeleteButton" runat="server" Text="--" CommandArgument='<%# Eval("FileName") %>' OnClick="DeleteButton_Click" CssClass="text-red-500 hover:text-red-700 cursor-pointer" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>

                            <tr id="NoPdfRow" runat="server" visible="false">
                                <td colspan="3" class="p-4 text-center text-xl text-red-600">Veuillez saisir un PDF</td>
                            </tr>
                         </td>

                     </tr>
                 </tbody>
             </table>

            <table id="pdfTable" runat="server" class="mt-7 w-full border-collapse border border-gray-200">
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
        </div>

            <asp:Button ID="SubmitButton" runat="server" Text="Submit" CssClass="mt-4 rounded bg-neutral-700 px-10 py-2 text-white" OnClick="SubmitButton_Click" aria-label="Submit" />
            <asp:Label ID="MessageLabel" runat="server" CssClass="mt-4 text-lg font-medium text-red-600" Visible="false"></asp:Label>
    </main>
</asp:Content>
