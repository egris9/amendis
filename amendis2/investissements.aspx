<%@ Page Title="investissements" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="investissements.aspx.cs" Inherits="amendis2.investissements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <main aria-labelledby="title">

    <div class="mx-14 mb-12 mt-14 flex flex-col gap-y-7 lg:ml-60 2xl:text-lg">
        <h3 class="text-2xl md:text-3xl lg:text-4xl">Programmes d'investissements​</h3>
        <p>  Pour une communication transparente des appels d'offres, Amendis met à votre disposition le programme prévisionnel des marchés 
            à passer au titre de l'année budgétaire en cours.<br /><br />
            Il est téléchargeable à partir des liens ci-dessous. </p>

        <a class="ml-6 flex flex-row items-center text-blue-600" href="PDF/Programme%20Prévisionnel%20Tanger.pdf" download="Programme_Previsionnel_Tanger.pdf">
            <img class="h-12 w-12 rounded-xl" src="img/pdf.jpg" alt="PDF Icon" />
            Télécharger les programmes d'investissements pour Tanger
        </a>



        <a class="ml-6 flex flex-row items-center text-blue-600" href="PDF/Programme%20Prévisionnel%20Tétouan.pdf" download="Programme_Previsionnel_Tetouan.pdf">
            <img class="h-12 w-12 rounded-xl" src="img/pdf.jpg" alt="PDF Icon" />
            Télécharger les programmes d'investissements pour Tétouan
        </a>

            

        
    </div>
      </main>
</asp:Content>
