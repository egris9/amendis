<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="modify_userRoles.aspx.cs" Inherits="amendis2.Admin.modify_userRoles" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container mx-auto mb-12 flex flex-col p-4 text-sm sm:text-base 2xl:text-lg">


        <div class="mb-6 flex items-center space-x-4">
            <label for="<%= UserDropDownList.ClientID %>" class="font-medium">shose user:</label>
            <asp:DropDownList ID="UserDropDownList" CssClass="rounded border border-gray-300 p-1 sm:w-72" runat="server"></asp:DropDownList>
        </div>


         <div class="mb-4 mt-11 flex">
                <asp:Button ID="LoadRolesButton" runat="server" CssClass="ml-52 rounded bg-neutral-700 px-10 py-2 text-white" Text="Load Roles" OnClick="LoadRolesButton_Click" />
         </div>


        <asp:ListBox ID="RolesListBox" runat="server" SelectionMode="Multiple"></asp:ListBox>

        <div class="flex px-3 py-2">
                 <div class="mb-4 mt-11 flex">
                     <asp:Button ID="AddRoleButton" runat="server" CssClass="rounded bg-neutral-700 px-3 text-white" Text="Add Role" OnClick="AddRoleButton_Click" />
                 </div>


                 <div class="mb-4 mt-11 flex"> 
                     <asp:Button ID="RemoveRoleButton" runat="server" CssClass="rounded bg-neutral-700 px-3 text-white" Text="Remove Role" OnClick="RemoveRoleButton_Click" />
                </div>

        </div>

       
        <asp:Label ID="StatusMessageLabel" runat="server" Visible="false"></asp:Label>
    </main>
</asp:Content>
