<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="modify_userRoles.aspx.cs" Inherits="amendis2.Admin.modify_userRoles" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container mx-auto mb-12 flex flex-col p-4 text-sm sm:text-base 2xl:text-lg">


        <div class="mb-6 flex items-center space-x-4">
            <label for="<%= UserDropDownList.ClientID %>" class="font-medium">shose user:</label>
               

                <asp:TextBox 
                    ID="SearchTextBox" 
                    CssClass="mb-2 rounded border border-gray-700 p-1 sm:w-72" 
                    runat="server" 
                    AutoPostBack="true" 
                    OnTextChanged="SearchTextBox_TextChanged" 
                    Placeholder="Search users..." />
            
                <asp:DropDownList 
                    ID="UserDropDownList" 
                    CssClass="rounded border border-gray-300 p-1 sm:w-72" 
                    runat="server" 
                    AutoPostBack="true" 
                    OnSelectedIndexChanged="UserDropDownList_SelectedIndexChanged">
                </asp:DropDownList>        

        </div>


       <asp:CheckBoxList 
            ID="RolesCheckBoxList"  
            runat="server" 
            AutoPostBack="false">
        </asp:CheckBoxList>

        <div class="mb-4 mt-11 flex">
            <asp:Button ID="SaveChangesButton" runat="server" CssClass="rounded bg-neutral-700 px-3 text-white" Text="Save Changes" OnClick="SaveChangesButton_Click" />
        </div>

       
        <asp:Label ID="StatusMessageLabel" runat="server" CssClass="text-green-600" Visible="false"></asp:Label>
    </main>
</asp:Content>
