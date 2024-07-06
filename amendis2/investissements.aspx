<%@ Page Title="investissements" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="investissements.aspx.cs" Inherits="amendis2.investissements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <main aria-labelledby="title">
    <!--#include file="nav.html" -->

    <div class="ml-64 mt-14 flex flex-col gap-y-7">
        <h3 class="text-4xl">Programmes d'investissements​</h3>
        <p>  Pour une communication transparente des appels d'offres, Amendis met à votre disposition le programme prévisionnel des marchés 
            à passer au titre de l'année budgétaire en cours.<br />
            Il est téléchargeable à partir des liens ci-dessous. </p>

        <a class="ml-6 flex flex-row items-center text-blue-600" href="Acceuil.aspx">
            <img class="h-12 w-12 rounded-xl" src="img/pdf.jpg" />
            Télécharger les programmes d'investissements pour Tanger
            </a>


        <a class="ml-6 flex flex-row items-center text-blue-600" href="Acceuil.aspx">
            <img class="h-12 w-12 rounded-xl" src="img/pdf.jpg" />
            Télécharger les programmes d'investissements pour Tetouan
        </a>
            

        
    </div>
      </main>
</asp:Content>
