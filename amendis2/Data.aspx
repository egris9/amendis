<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Data.aspx.cs" Inherits="amendis2.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="mb-5 ml-36 mt-8">
            <div>
                <h2 class="text-3xl font-medium">Affichage des Détails d'AO</h2>
            </div>
        </div>
        <br />
        <div class="max-w-[90%] mx-auto mb-8 mt-5">
            <table class="w-full table-auto border-collapse flex-col border border-gray-300">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="w-1/3 p-4 text-center text-xl font-medium">Numero_Ao</th>
                        <th class="w-1/3 p-4 text-center text-xl font-medium">Libelle</th>
                        <th class="w-1/3 p-4 text-center text-xl font-medium">Fichiers PDF</th>
                    </tr>
                </thead>
                <tbody>
                    <tr >
                        <td class="p-4 text-center">
                            <asp:Label ID="NumeroAoLabel" runat="server" CssClass="h-10 text-xl"></asp:Label>
                        </td>
                        <td class="p-10 text-center">
                            <asp:Label ID="DesignationLabel" runat="server" CssClass="h-10 text-xl"></asp:Label>
                        </td>
                        <td class="p-4 text-center">
                            <asp:Repeater ID="PdfRepeater" runat="server">
                                <ItemTemplate>
                                    <div class="mb-2">
                                        <asp:HyperLink ID="PdfFileLink" runat="server" Text='<%# Eval("FileName") %>' NavigateUrl='<%# Eval("FileName", "~/Uploads/{0}") %>' Target="_blank" CssClass="hover:text-blue-500 "></asp:HyperLink>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </main>
</asp:Content>
