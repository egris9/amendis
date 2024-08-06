<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Data.aspx.cs" Inherits="amendis2.Data" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <div class="mb-5 ml-36 mt-8 flex">
            <div>
                <h2 class="text-3xl font-medium">Affichage des Détails d'AO</h2>
            </div>
        </div>
        <br />
      <div class="max-w-[85%] mx-auto mb-5 flex flex-col">
            <div class="mb-7 flex">
                <div class="w-1/3 text-2xl font-medium">Numero_Ao:</div>
                <div class="w-2/3">
                    <asp:Label ID="NumeroAoLabel" runat="server" CssClass="h-10 rounded border px-5 text-2xl"></asp:Label>
                </div>
            </div>
            <div class="mb-7 flex">
                <div class="w-1/3 text-2xl font-medium">Libelle:</div>
                <div class="w-2/3">
                    <asp:Label ID="DesignationLabel" runat="server" CssClass="h-10 rounded border px-5 text-2xl"></asp:Label>
                </div>
            </div>
            <div class="mb-4 flex">
                <div class="w-1/3 text-2xl font-medium">Fichier PDF:</div>
                <div class="w-2/3">
                  <asp:GridView ID="PdfGridView" runat="server" AutoGenerateColumns="False" CssClass="w-full table-auto text-center">
                        <Columns>
                            <asp:TemplateField HeaderText="Fichier PDF">
                                <ItemTemplate>
                                    <div class="text-center"><%# Eval("FileName") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Télécharger">
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:HyperLink ID="PdfFileLink" runat="server" Text='<%# Eval("FileName") %>' NavigateUrl='<%# Eval("FileName", "~/Uploads/{0}") %>' Target="_blank" CssClass="hover:text-blue-500"></asp:HyperLink>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </main>
</asp:Content>
