<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="amendis2.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title" class="container mx-auto mt-8">
        <div class="md:flex md:justify-center">
            <div class="rounded-3xl bg-neutral-700 p-10 shadow-md md:w-2/3 lg:w-1/2">
                <section id="loginForm">
                    <h2 id="title" class="mb-6 text-center text-3xl font-medium text-white">Registre</h2>
                    <h4 class="mb-4 flex justify-center text-xl font-medium text-white">Créer un nouveau compte</h4>
                    <hr class="mb-6 border-white"/>
                    <asp:ValidationSummary runat="server" CssClass="mb-4 text-red-500" />

                    <div class="mb-4">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="block text-xl font-medium text-white">Email :</asp:Label>
                        <asp:TextBox runat="server" ID="Email" CssClass="form-input mt-1 block w-full rounded-md border border-gray-300 p-1 text-black" TextMode="Email" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" CssClass="text-sm text-red-500" ErrorMessage="Le champ email est obligatoire." />
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="block text-xl font-medium text-white">Mot de passe :</asp:Label>
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-input mt-1 block w-full rounded-md border border-gray-300 p-1 text-black" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-sm text-red-500" ErrorMessage="Le champ mot de passe est obligatoire." />
                    </div>

                    <div class="mb-4">
                        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="block text-xl font-medium text-white">Confirmr Mot de passe :</asp:Label>
                        <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-input mt-1 block w-full rounded-md border border-gray-300 p-1 text-black" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword" CssClass="text-sm text-red-500" Display="Dynamic" ErrorMessage="Le champ de confirmation du mot de passe est obligatoire." />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" CssClass="text-sm text-red-500" Display="Dynamic" ErrorMessage="Le mot de passe et le mot de passe de confirmation ne correspondent pas." />
                    </div>
                    <div class="mb-4 flex justify-center">
                        <asp:Button runat="server" OnClick="CreateUser_Click" Text="Créer compte" CssClass="btn btn-outline-dark mt-4 cursor-pointer items-center rounded bg-black px-20 py-2 font-bold text-white" />
                    </div>
                </section>
            </div>
        </div>
    </main>
</asp:Content>
