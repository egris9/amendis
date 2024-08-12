<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Data.aspx.cs" Inherits="amendis2.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="mx-auto mt-8 max-w-7xl px-4 py-8">
        <div class="mb-5 mt-8">
            <div>
                <h2 class="text-3xl font-medium">Affichage des Détails d'AO</h2>
            </div>
        </div>
        <br />
        <div class="max-w-[100%] mx-auto mb-8 mt-5">

            <div class="flex items-center p-4 text-center">
                <p class="text-xl font-bold">Numero_Ao: </p>
                <asp:Label ID="NumeroAoLabel" runat="server" CssClass="ml-2 text-xl"></asp:Label>
            </div>

            <div class="flex items-center space-x-4 p-4">
                <h3 class="text-xl font-bold">Designation:</h3>
                <asp:Label ID="DesignationLabel" runat="server" CssClass="max-w-[80%] text-lg font-medium"></asp:Label>
            </div>


            <table class="w-full table-auto border-collapse flex-col border border-gray-300">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="w-1/3 p-4 text-center text-xl font-medium">Libelle</th>
                        <th class="w-1/3 p-4 text-center text-xl font-medium">Fichiers PDF</th>
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
                                        <td class="p-2 text-center">
                                            <asp:HyperLink ID="PdfFileLink" runat="server" Text='<%# Eval("FileName") %>' NavigateUrl='<%# Eval("FileName", "~/Uploads/{0}") %>' Target="_blank" CssClass="hover:text-blue-500"></asp:HyperLink>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>

                    </tr>
                </tbody>
            </table>
        </div>
    </main>
</asp:Content>
