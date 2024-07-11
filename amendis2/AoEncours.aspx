<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AoEncours.aspx.cs" Inherits="amendis2.AoEncours" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main>
  
            <div class="container mt-3" style="margin-left:-10px">
            <div class="bg-light text-light rounded p-3" style="background-color:lightblue">
              <h2 style="color:dimgray">Appels d'offres en cours​</h2>
            </div>
          </div><br />


                <asp:GridView ID="GridView1" runat="server" Font-Size="Small" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" CellPadding="3" PagerSettings-Mode="Numeric" ForeColor="Black" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#CCCCCC"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField DataField="Site" HeaderText="Site" SortExpression="Site">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Numero_Ao" HeaderText="N° AO" SortExpression="Numero_Ao">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Designa" HeaderText="Désignation" SortExpression="Designa">
                            <ItemStyle Width="600px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Date_lan" DataFormatString="{0:d}" HtmlEncode="False" HeaderText="Date lan." SortExpression="Date_lan">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Date_rem" DataFormatString="{0:d}" HtmlEncode="False" HeaderText="Date rem." SortExpression="Date_rem">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Date_ouv_adm" DataFormatString="{0:d}" HtmlEncode="False" HeaderText="Date adm." SortExpression="Date_ouv_adm">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Seance_ouv" HeaderText="Seance ouv." SortExpression="Seance_ouv">
                            <ItemStyle Width="100px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Montant_est" DataFormatString="{0:N}" HeaderText="Estimation" HtmlEncode="False" SortExpression="Montant_est">
                            <ItemStyle Width="100px" HorizontalAlign="Right" />
                        </asp:BoundField>
                    </Columns>

                    <FooterStyle BackColor="#CCCCCC"></FooterStyle>

                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White"></HeaderStyle>

                    <PagerStyle HorizontalAlign="Center" BackColor="#999999" ForeColor="Black"></PagerStyle>

                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                    <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                    <SortedAscendingHeaderStyle BackColor="#808080"></SortedAscendingHeaderStyle>

                    <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                    <SortedDescendingHeaderStyle BackColor="#383838"></SortedDescendingHeaderStyle>
                </asp:GridView>

                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' ProviderName='<%$ ConnectionStrings:DefaultConnection.ProviderName %>'SelectCommand="SELECT * FROM YourTable" >
                    <SelectParameters>
                        <asp:Parameter DefaultValue="FD" Name="Financement" Type="String"></asp:Parameter>
                    </SelectParameters>
                </asp:SqlDataSource>
            </main>
</asp:Content>
