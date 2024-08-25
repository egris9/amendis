<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="modify_userRoles.aspx.cs" Inherits="amendis2.Admin.modify_userRoles" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="container mx-auto mb-12 flex flex-col p-4 text-sm sm:text-base 2xl:text-lg">


        <div class="mb-6 flex items-center space-x-4">
           
             
            
            <div class="mx-auto mb-2 flex w-full items-center"> 

                <label for="<%= SearchTextBox.ClientID %>" class="text-xl mr-4 font-medium">entrer l'utilisateur :</label>

                 <asp:TextBox ID="SearchTextBox" CssClass="rounded border border-gray-700 p-1 sm:w-72" runat="server" list="dynamicList" placeholder="type a user ..."></asp:TextBox>
                <datalist id="dynamicList" ClientIDMode="Static" runat="server">
                    <!-- Options will be populated from code-behind -->
                </datalist>
                <asp:LinkButton ID="SearchButton" runat="server" CssClass="ml-2 flex h-10 items-center self-center rounded bg-neutral-500 p-2 text-white" OnClick="SearchButton_Click">
                    <span class="material-symbols-outlined self-center text-xl">search</span>
                </asp:LinkButton>
                
            </div>
                 

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
