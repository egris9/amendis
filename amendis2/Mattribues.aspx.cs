using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace amendis2
{
    public partial class Mattribues : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Créer une DataTable
                DataTable dt = new DataTable();

                // Ajouter les colonnes à la DataTable
                dt.Columns.Add(new DataColumn("Site", typeof(string)));
                dt.Columns.Add(new DataColumn("Numero_Ao", typeof(string)));
                dt.Columns.Add(new DataColumn("Designa", typeof(string)));
                dt.Columns.Add(new DataColumn("Date_lan", typeof(DateTime)));
                dt.Columns.Add(new DataColumn("Ouvertur_fin", typeof(DateTime)));
                dt.Columns.Add(new DataColumn("Montant_dhht", typeof(DateTime)));
                dt.Columns.Add(new DataColumn("Attributaire", typeof(string)));
                dt.Columns.Add(new DataColumn("Detail", typeof(string)));

                // Exemple de données
                DataRow dr1 = dt.NewRow();
                dr1["Site"] = "Site A";
                dr1["Numero_Ao"] = "AO-001";
                dr1["Designa"] = "Désignation 1";
                dr1["Date_lan"] = new DateTime(2024, 7, 15);
                dr1["Ouvertur_fin"] = new DateTime(2024, 7, 20);
                dr1["Montant_dhht"] = new DateTime(2024, 7, 25);
                dr1["Attributaire"] = "Attribué 1";
                dr1["Detail"] = "Détail 1";
                dt.Rows.Add(dr1);

                DataRow dr2 = dt.NewRow();
                dr2["Site"] = "Site B";
                dr2["Numero_Ao"] = "AO-002";
                dr2["Designa"] = "Désignation 2";
                dr2["Date_lan"] = new DateTime(2024, 7, 16);
                dr2["Ouvertur_fin"] = new DateTime(2024, 7, 21);
                dr2["Montant_dhht"] = new DateTime(2024, 7, 26);
                dr2["Attributaire"] = "Attribué 2";
                dr2["Detail"] = "Détail 2";
                dt.Rows.Add(dr2);

                // Lier la DataTable au GridView
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }

        }
        protected void SearchButton_Clicks(object sender, EventArgs e)
        {
            // Set the SelectParameter for the search term
            SqlDataSource1.SelectParameters["SearchTerm"].DefaultValue = SearchTextBox.Text.Trim();
            // Rebind the GridView to apply the search filter
            GridView1.DataBind();
        }

    }
}