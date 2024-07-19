<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mattribues.aspx.cs" Inherits="amendis2.Mattribues" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
  
        <div class="mb-5 ml-36 mt-8 flex">
          <div>
            <h2 class="text-3xl font-medium">Marchés attribués</h2>
          </div>
        </div>
        <br />
         


         <div class="max-w-[85%] mx-auto mb-5 flex w-full items-center justify-end">
             <span class="mr-2 mt-1.5 h-10 text-lg font-medium">Chercher:</span>
             <asp:TextBox ID="SearchTextBox" runat="server" CssClass="h-10 rounded border px-5"></asp:TextBox>
             <asp:LinkButton ID="SearchButton1" runat="server" CssClass="ml-2 flex h-10 items-center self-center rounded bg-neutral-500 p-2 text-white" OnClick="SearchButton_Clicks">
                 <span class="material-symbols-outlined self-center text-xl">search</span>
             </asp:LinkButton>
         </div>
         <br />



         <asp:GridView ID="GridView1" runat="server" Visible="true" EnableViewState="true"
                Font-Size="Medium" AutoGenerateColumns="False" DataSourceI="SqlDataSource1"
                AllowPaging="True" AllowSorting="True" CellPadding="3" PagerSettings-Mode="Numeric"
                ForeColor="Black" GridLines="Vertical" BackColor="White" HorizontalAlign="Center"
                BorderStyle="Solid" BorderWidth="1px" Width="85%" CssClass="gridview-style">
            <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="Site" HeaderText="Site" SortExpression="Site">
                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Numero_Ao" HeaderText="N° AO" SortExpression="Numero_Ao">
                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Designa" HeaderText="Désignation" SortExpression="Designa">
                    <ItemStyle Width="600px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Date_lan" DataFormatString="{0:d}" HtmlEncode="False" HeaderText="Date lan." SortExpression="Date_lan">
                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Ouvertur_fin" DataFormatString="{0:d}" HtmlEncode="False" HeaderText="Ouvertur fin." SortExpression="Ouvertur_fin">
                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Montant_dhht" DataFormatString="{0:d}" HtmlEncode="False" HeaderText="Montant DHHT." SortExpression="Montant_dhht">
                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Attributaire" HeaderText="Attributaire." SortExpression="Attributaire">
                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="Detail" HeaderText="Detail" HtmlEncode="False" SortExpression="Detail">
                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
            </Columns>

           <FooterStyle BackColor="#CCCCCC"></FooterStyle>
            <HeaderStyle BackColor="#808080" Font-Bold="True" ForeColor="White"></HeaderStyle>
            <PagerStyle HorizontalAlign="Center" BackColor="#999999" ForeColor="Black"></PagerStyle>
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>
            <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>
            <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>
            <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>
            <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
        </asp:GridView>


            <asp:SqlDataSource runat="server" ID="SqlDataSource1" 
                ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                ProviderName='<%$ ConnectionStrings:DefaultConnection.ProviderName %>' >
                <SelectParameters>
                    <asp:Parameter DefaultValue="FD" Name="Financement" Type="String"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
        </main>
</asp:Content>
