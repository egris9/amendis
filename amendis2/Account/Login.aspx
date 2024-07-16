<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="amendis2.Account.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title" class="container mx-auto mt-8">
        <div class="md:flex md:justify-center">
            <div class="mx-14 mb-12 rounded-3xl bg-neutral-500 p-16 shadow-md md:w-2/3 lg:w-1/2">
                <section id="loginForm">
                    <h2 id="title" class="mb-6 text-center text-3xl font-medium text-white">Se connecter</h2>
                    <h4 class="mb-4 flex justify-center text-xl font-medium text-white">Utilisez un compte local pour vous connecter.</h4>
                    <hr class="mb-6 border-white"/>
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-red-500">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="mb-4">
                        <asp:Label runat="server" AssociatedControlID="UsernameOrEmail" CssClass="block text-xl font-medium text-white">Nom d'utilisateur ou Email :</asp:Label>
                        <asp:TextBox runat="server" ID="UsernameOrEmail" CssClass="form-input mt-1 block w-full rounded-md border border-gray-300 p-1" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="UsernameOrEmail" CssClass="text-sm text-red-500" ErrorMessage="The username or email field is required." />
                    </div>
                    <div class="mb-4">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="block text-xl font-medium text-white">Mot de passe :</asp:Label>
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-input mt-1 block w-full rounded-md border border-gray-300 p-1" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-sm text-red-500" ErrorMessage="The password field is required." />
                    </div>
                    <div class="mb-4 flex items-center">
                        <asp:CheckBox runat="server" ID="RememberMe" CssClass="mr-2"/>
                        <asp:Label runat="server" AssociatedControlID="RememberMe" CssClass="text-white">Se souvenir de moi ?</asp:Label>
                    </div>
                    <div class="mb-4 flex justify-center">
                        <asp:Button runat="server" OnClick="LogIn" Text="Se connecter" CssClass="btn btn-outline-dark cursor-pointer items-center rounded bg-black px-20 py-2 font-bold text-white" />
                    </div>

                    <p class="mt-4 flex justify-center">
                        <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled" CssClass="text-white">Inscrivez-vous en tant que nouvel utilisateur</asp:HyperLink>
                    </p>
                    <p class="mt-2">
                        <%-- Enable this once you have account confirmation enabled for password reset functionality
                        <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled" CssClass="text-blue-500 hover:text-blue-700">Forgot your password?</asp:HyperLink>
                        --%>
                    </p>
                </section>
            </div>
        </div>


        <!-- !!! must do some Search-->
        <div>
            <div>
                <section id="socialLoginForm">
                    <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
                </section>
            </div>
        </div>
    </main>
</asp:Content>
