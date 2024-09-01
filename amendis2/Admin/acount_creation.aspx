<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="acount_creation.aspx.cs" Inherits="amendis2.Admin.admin_acount_creation" Async="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <main class="mx-auto mb-12 flex flex-col p-4 text-xl">

        <!-- Header Section -->
    <div class="mb-16 flex justify-center p-7">
        <p class="text-3xl font-medium">Création de Compte</p>
    </div>


    <!-- Username and Email Input Section -->
 <div class="mx-auto mb-6 flex w-full max-w-4xl flex-col items-center justify-between gap-y-10 md:flex-row">
       
     <!--Username-->
        <div class="flex flex-col"> 
        <div class="flex flex-col items-center justify-center gap-y-6 md:flex-row">

            <label for="user" class="font-medium md:mr-16">Username:</label>
            <asp:TextBox ID="UsernameTextBox" placeholder="type a username ..." CssClass="max-w-[288px] w-full rounded border border-gray-300 p-1" runat="server" />
           
        </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                ControlToValidate="UsernameTextBox"
                ErrorMessage="Username is required."
                CssClass="mt-1 text-red-500 md:mt-0" />
        </div>

        <!--Email-->
        <div class="flex flex-col"> 
        <div class="flex flex-col items-center justify-center gap-y-6 md:flex-row">
            <label for="email" class="font-medium md:mr-5">L'email:</label>
            <asp:TextBox ID="EmailTextBox" placeholder="type an email ..." CssClass="max-w-[288px] w-full rounded border border-gray-300 p-1" runat="server" />
            
        </div>
            <asp:RequiredFieldValidator ID="EmailRequiredFieldValidator" runat="server"
                ControlToValidate="EmailTextBox"
                ErrorMessage="Email is required."
                CssClass="mt-1 text-red-500 md:mt-0" />
        </div>
    </div>



    <!-- Password and Activite Input Section -->
    <div class="mx-auto mb-6 mt-10 flex w-full max-w-4xl flex-col items-center justify-between gap-y-10 md:flex-row">

        <!--Password-->
            <div class="flex flex-col"> 
                <div class="flex flex-col items-center justify-center gap-y-6 md:flex-row">

                        <label for="pw" class="shrink-0 font-medium md:mr-9">Mot de Passe:</label>
           
                        <asp:TextBox ID="PasswordTextBox" placeholder="type a password ..."  CssClass="max-w-[288px] w-full rounded border border-gray-300 p-1" runat="server" TextMode="Password" />
           

                  </div>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ControlToValidate="PasswordTextBox"
                        ErrorMessage="Password is required."
                        CssClass="ml-9 mt-1 text-red-500 md:ml-0 md:mt-0" />
            </div>

            <!--Activite-->
            <div class="flex flex-col"> 
                    <div class="flex flex-col items-center justify-center gap-y-6 md:flex-row">
                            <label for="activite" class="font-medium md:mr-3">Activité:</label>
                            <asp:TextBox ID="ActiviteTextBox" placeholder="type the activity ..." CssClass="max-w-[288px] w-full rounded border border-gray-300 p-1" runat="server" />

                    </div> 
                        <asp:RequiredFieldValidator ID="ActiviteRequiredFieldValidator" runat="server"
                                ControlToValidate="ActiviteTextBox"
                                ErrorMessage="Activité is required."
                                CssClass="mt-1 text-red-500 md:ml-0 md:mt-0" />

            </div>
    </div>






       <!-- Nom_deSociete and Role Input Section -->
    <div class="mx-auto mb-6 mt-10 flex w-full max-w-4xl flex-col items-center justify-between gap-y-10 md:flex-row">
       
            <!--Nom_deSociete-->   
            <div class="flex flex-col"> 
             <div class="flex flex-col items-center justify-center gap-y-6 md:flex-row">
                    <label for="nomSociete" class="shrink-0 font-medium md:mr-3">Nom de Société:</label>
                    <asp:TextBox ID="NomSocieteTextBox" placeholder="Société ..." CssClass="max-w-[288px] w-full rounded border border-gray-300 p-1" runat="server" />
             </div>
                <asp:RequiredFieldValidator ID="NomSocieteRequiredFieldValidator" runat="server"
                        ControlToValidate="NomSocieteTextBox"
                        ErrorMessage="Nom de Société is required."
                        CssClass="mt-1 text-red-500" />
            </div>

              <!--Role-->
              <div class="max-w-[315px] flex w-full flex-col"> 
                    <div class="flex-shrink-0 flex flex-col items-center justify-center md:flex-row">
                        <label for="<%= RoleDropDownList.ClientID %>" class=" md:mr-9 font-medium">Rôle:</label>
                        <asp:DropDownList ID="RoleDropDownList"  CssClass="grow rounded border border-gray-300 p-1" runat="server">
                            <asp:ListItem Text="Superuser" Value="Superuser" />
                            <asp:ListItem Text="Admin" Value="Admin" />
                        </asp:DropDownList>
    
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                       ControlToValidate="RoleDropDownList"
                       ErrorMessage="Password is required."
                       CssClass="ml-9 mt-1 text-red-500 md:ml-0 md:mt-0" />
                </div>
      </div>

    <!-- Button Section -->
    <div class="mb-4 mt-14 flex justify-center">
        <asp:Button ID="CreateUserButton" runat="server" Text="Create User" OnClick="CreateUserButton_Click" CssClass="cursor-pointer rounded bg-neutral-700 px-14 py-2 text-white" />
    </div>

       <!-- modify link  -->
       <div class="mt-3 flex justify-center">
     <asp:HyperLink ID="ModifyUserLink" runat="server" NavigateUrl="~/Admin/modify_userRoles.aspx" CssClass="text-blue-500 underline hover:text-blue-800">
         Modifier un Utilisateur
     </asp:HyperLink>
 </div>

    <!-- Success Message -->
    <asp:Label ID="SuccessMessageLabel" runat="server" ForeColor="Green" Visible="false" />
    
</main>

</asp:Content>