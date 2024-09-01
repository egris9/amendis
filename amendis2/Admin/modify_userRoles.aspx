<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="modify_userRoles.aspx.cs" Inherits="amendis2.Admin.modify_userRoles" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <main class="container mx-auto mb-12 flex flex-col p-4 text-sm sm:text-base 2xl:text-lg">
        <h1 class="mb-16 mt-4 text-center text-3xl font-medium">• Modifier Utilisateur</h1>
        
        <div class="mb-16 flex items-center space-x-4">
            <div class="mx-auto mb-2 flex w-full items-center justify-center"> 
                <label for="<%= SearchTextBox.ClientID %>" class="text-xl mr-4 font-medium">Entrer l'utilisateur :</label>
                <asp:TextBox ID="SearchTextBox" CssClass="rounded border border-gray-700 p-1 sm:w-72" runat="server" list="dynamicList" placeholder="type a user ..."></asp:TextBox>
                <datalist id="dynamicList" ClientIDMode="Static" runat="server"></datalist>
                <asp:LinkButton ID="SearchButton" runat="server" CssClass="ml-2 flex h-10 items-center self-center rounded bg-neutral-500 p-2 text-white" OnClick="SearchButton_Click">
                    <span class="material-symbols-outlined self-center text-xl">search</span>
                </asp:LinkButton>
            </div>
        </div>

        <!-- Panel to show or hide the input fields -->
         <asp:Panel ID="UserDetailsPanel" runat="server" Visible="false">
            <div class="mb-6 flex justify-center space-x-4">
                <asp:Label ID="UsernameLabel" runat="server" CssClass="mr-4 font-medium">Username:</asp:Label>
                <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="rounded border border-gray-700 p-1 sm:w-72"></asp:TextBox>
            </div>

            <div class="mb-6 flex justify-center space-x-4">
                <asp:Label ID="EmailLabel" runat="server" CssClass="mr-14 font-medium">Email:</asp:Label>
                <asp:TextBox ID="EmailTextBox" runat="server" CssClass="rounded border border-gray-700 p-1 sm:w-72"></asp:TextBox>
            </div>

            <div class="mb-6 flex justify-center space-x-4">
                <asp:Label ID="PasswordLabel" runat="server" CssClass="mr-6 font-medium">Password:</asp:Label>
                <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="rounded border border-gray-700 p-1 sm:w-72"></asp:TextBox>
            </div>

            <asp:CheckBoxList 
                ID="RolesCheckBoxList"  
                runat="server" 
                AutoPostBack="false"
                CssClass="cll flex flex-col items-center">
            </asp:CheckBoxList>

            <div class="mb-4 mt-11 flex justify-center">
                <asp:Button ID="SaveChangesButton" runat="server" CssClass="cursor-pointer rounded bg-neutral-700 p-2 px-6 text-white" Text="Save Changes" OnClick="SaveChangesButton_Click" />
            </div>
        </asp:Panel>

        <asp:Label ID="StatusMessageLabel" runat="server" CssClass="mt-2 text-center text-xl text-green-600" Visible="false"></asp:Label>
    </main>
</asp:Content>
