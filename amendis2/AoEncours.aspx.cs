using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace amendis2
{
    public partial class AoEncours : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();

            // Ajouter les colonnes à la DataTable
            dt.Columns.Add(new DataColumn("ID", typeof(int)));
            dt.Columns.Add(new DataColumn("Site", typeof(string)));
            dt.Columns.Add(new DataColumn("Numero_Ao", typeof(string)));
            dt.Columns.Add(new DataColumn("Designa", typeof(string)));
            dt.Columns.Add(new DataColumn("Date_lan", typeof(DateTime)));
            dt.Columns.Add(new DataColumn("Date_rem", typeof(DateTime)));
            dt.Columns.Add(new DataColumn("Date_ouv_adm", typeof(DateTime)));
            dt.Columns.Add(new DataColumn("Seance_ouv", typeof(string)));
            dt.Columns.Add(new DataColumn("Montant_est", typeof(decimal)));

            // Ajouter des lignes de données à la DataTable (exemples)
            dt.Rows.Add(1, "Site A", "AO001", "Description 1", DateTime.Now, DateTime.Now, DateTime.Now, "Morning", 1000.50);
            dt.Rows.Add(2, "Site B", "AO002", "Description 2", DateTime.Now, DateTime.Now, DateTime.Now, "Afternoon", 1500.75);

            // Assigner la DataTable comme source de données pour le GridView
            GridView1.DataSource = dt;
            GridView1.DataBind(); // Obligatoire pour lier les données au GridView
        }
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            // Set the SelectParameter for the search term
            SqlDataSource1.SelectParameters["SearchTerm"].DefaultValue = SearchTextBox.Text.Trim();
            // Rebind the GridView to apply the search filter
            GridView1.DataBind();
        }

    }
}