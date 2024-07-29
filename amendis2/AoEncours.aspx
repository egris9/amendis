<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AoEncours.aspx.cs" Inherits="amendis2.AoEncours" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
  
            <div class="mb-5 ml-36 mt-8 flex">
              <div>
                <h2 class="text-3xl font-medium">Appels d'offres en cours</h2>
              </div>
            </div>
            <br />
        <div class="max-w-[85%] mx-auto mb-5 flex w-full items-center justify-end">
            <span class="mr-2 mt-1.5 h-10 text-lg font-medium">Chercher:</span>
             <asp:TextBox ID="SearchTextBox" runat="server" CssClass="h-10 rounded border px-5"></asp:TextBox>
            <asp:LinkButton ID="SearchButton" runat="server" CssClass="ml-2 flex h-10 items-center self-center rounded bg-neutral-500 p-2 text-white" OnClick="SearchButton_Click">
                <span class="material-symbols-outlined self-center text-xl">search</span>
            </asp:LinkButton>
        </div>
        <br />



         <asp:GridView ID="GridView1" runat="server" Visible="true" EnableViewState="true"
                Font-Size="Medium" AutoGenerateColumns="False" DataSourceI="SqlDataSource1"
                AllowPaging="True" PageSize="3" AllowSorting="True" CellPadding="3"
                ForeColor="Black" GridLines="Vertical" BackColor="White"  HorizontalAlign="Center"

                BorderStyle="Solid" BorderWidth="1px" Width="85%" CssClass="gridview-style" OnSorting="GridView1_Sorting" OnPageIndexChanging="GridView1_PageIndexChanging">
                <PagerSettings Mode="Numeric" PageButtonCount="10" Position="Bottom" />

                <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="Site" HeaderText="Site" SortExpression="Site">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Numero_Ao" HeaderText="N° AO" SortExpression="Numero_Ao">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Designa" HeaderText="Désignation" SortExpression="Designa">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="600px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Date_lan" DataFormatString="{0:d}" HtmlEncode="False"
                        HeaderText="Date lan." SortExpression="Date_lan">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Date_rem" DataFormatString="{0:d}" HtmlEncode="False"
                        HeaderText="Date rem." SortExpression="Date_rem">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Date_ouv_adm" DataFormatString="{0:d}" HtmlEncode="False"
                        HeaderText="Date adm." SortExpression="Date_ouv_adm">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Seance_ouv" HeaderText="Seance ouv." SortExpression="Seance_ouv">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Montant_est" DataFormatString="{0:N}" HeaderText="Estimation"
                        HtmlEncode="False" SortExpression="Montant_est">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle Width="100px" HorizontalAlign="center" VerticalAlign="Middle" />
                    </asp:BoundField>
                </Columns>

                <FooterStyle BackColor="#CCCCCC"></FooterStyle>
                <HeaderStyle BackColor="#808080" Font-Bold="True" ForeColor="White"></HeaderStyle>
                <PagerStyle HorizontalAlign="Center" BackColor="#808080" ForeColor="White"></PagerStyle>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>
                <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>
                <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>
                <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>
                <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
            </asp:GridView>


                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'  ProviderName='<%$ ConnectionStrings:DefaultConnection.ProviderName %>' SelectCommand="SET DATEFORMAT DMY; SELECT 
    Numero_Ao,
    Designa,
    Date_lan,
    Date_rec,
    Date_rem,
    Date_ouv_adm,
    Date_ouv_fin,
    Type,
    Nature,
    Type_projet,
    Seance_ouv,
    Direction,
    Res_projet,
    Site,
    Financement,
    Mode_lan,
    Statut,
    Frais_dos,
    Numero_lot,
    Libelle,
    Impu_bud,
    Montant_bud,
    Montant_est,
    Observation,
    DATEDIFF(d, Date_rec, GETDATE()) AS Nbr_jour,
    Date_rep1,
    Date_rep2
FROM v_ao_aoo;
" >
                    <SelectParameters>
                        <asp:Parameter DefaultValue="FD" Name="SearchTerm" Type="String"></asp:Parameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </main>
</asp:Content>
