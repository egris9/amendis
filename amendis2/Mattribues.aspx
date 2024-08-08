<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mattribues.aspx.cs" Inherits="amendis2.Mattribues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
  
        <div class="mb-3 ml-36 mt-14 flex">
          <div>
            <h2 class="text-4xl font-medium">Marchés attribués</h2>
          </div>
        </div>
        <br />
         


         <div class="max-w-[85%] mx-auto mb-3 flex w-full items-center justify-end">
             <span class="mr-2 mt-1.5 h-10 text-lg font-medium">Chercher:</span>
             <asp:TextBox ID="SearchTextBox" runat="server" CssClass="h-10 rounded border px-5"></asp:TextBox>
             <asp:LinkButton ID="SearchButton1" runat="server" CssClass="ml-2 flex h-10 items-center self-center rounded bg-neutral-500 p-2 text-white" OnClick="SearchButton_Clicks">
                 <span class="material-symbols-outlined self-center text-xl">search</span>
             </asp:LinkButton>
         </div>
         <br />



         <asp:GridView ID="GridView1" runat="server" Visible="true" EnableViewState="true"
                Font-Size="Medium" AutoGenerateColumns="False" DataSourceI="SqlDataSource1"
                AllowPaging="True" AllowSorting="True" CellPadding="3" PagerSettings-Mode="Numeric" PageSize="12"
                ForeColor="Black" GridLines="Vertical" BackColor="White" HorizontalAlign="Center"
                BorderStyle="Solid" BorderWidth="1px" Width="85%" CssClass="gridview-style mb-16" OnSorting="GridView1_Sorting" OnPageIndexChanging="GridView1_PageIndexChanging">
            <PagerSettings Mode="Numeric" PageButtonCount="10" Position="Bottom" />
            <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>
           <Columns>
                <asp:BoundField DataField="Site" HeaderText="Site" SortExpression="Site">
                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Numero_ao" HeaderText="N° AO" SortExpression="Numero_ao">
                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Designa" HeaderText="Désignation" SortExpression="Designa">
                    <ItemStyle Width="600px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Date_lan" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" HeaderText="Date lan." SortExpression="Date_lan">
                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Date_ouv_fin" DataFormatString="{0:dd/MM/yyyy}" HtmlEncode="False" HeaderText="Ouvertur fin." SortExpression="Date_ouv_fin">
                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Montant" DataFormatString="{0:N2}" HtmlEncode="False" HeaderText="Montant DHHT." SortExpression="Montant">
                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Res_projet" HeaderText="Attributaire." SortExpression="Res_projet">
                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Conso" HeaderText="Detail" HtmlEncode="False" SortExpression="Conso">
                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" />
                </asp:BoundField>
            </Columns>


           <FooterStyle BackColor="#CCCCCC"></FooterStyle>
            <HeaderStyle BackColor="#808080" Font-Bold="True" ForeColor="White"></HeaderStyle>
            <PagerStyle HorizontalAlign="Center" CssClass="pager-style" BackColor="#808080" ForeColor="White"></PagerStyle>
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>
            <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>
            <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>
            <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>
            <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
        </asp:GridView>


            <asp:SqlDataSource runat="server" ID="SqlDataSource1" 
                ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                ProviderName='<%$ ConnectionStrings:DefaultConnection.ProviderName %>'  
                SelectCommand="SET DATEFORMAT DMY; select Site,Type='Marché',Type as Type_ao,Direction,Type_projet,Numero_Mar, Numero_ao,Numero_lot,Numero_cde_ouv, upper(Designa) as Designa, upper(Libelle) as Libelle,Date_rec,Date_lan,Date_rem,Date_ouv_adm,Date_ouv_fin,Date_rep1,Date_rep2,Date_env_fou,Date_ret_fou,Date_Adj, Date_Not,Date_av_rec =null,Nom as Adjudicataire,Montant,Montant_min,Montant_max,Date_ord_ser,Duree,Montant_cau,Date_rec_pro,Date_rec_def,Date_res_cau,Estim_dac,Financement,Famille,Res_projet,Nature,Mode_lan,Delai,Observation,Montant_n,Montant_n1,Montant_n2,Montant_n3,isnull(Montant_n,0)+isnull(Montant_n1,0)+isnull(Montant_n2,0)+isnull(Montant_n3,0) as Conso from V_AO_Marche WHERE site ='TANGER' or site = 'TETOUAN' AND YEAR(date_not) = year(getdate()) AND rtrim(isnull(statut,'')) !='ANNULE' AND rtrim(isnull(statut,'')) !='INFRUCTUEUX' AND rtrim(isnull(statut,'')) <> 'AUCUNE OFFRE' ">
                <SelectParameters>
                    <asp:Parameter DefaultValue="FD" Name="Financement" Type="String"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </main>
</asp:Content>
