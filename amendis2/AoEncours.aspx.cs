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
        private string SortDirection
        {
            get { return ViewState["SortDirection"] as string ?? "ASC"; }
            set { ViewState["SortDirection"] = value; }
        }

        private string SortExpression
        {
            get { return ViewState["SortExpression"] as string ?? string.Empty; }
            set { ViewState["SortExpression"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string searchTerm = SearchTextBox.Text.Trim();

            // Define the base query with parameters
            SqlDataSource1.SelectCommand = $@"SET DATEFORMAT DMY;
            SELECT Numero_Ao, Designa, Date_lan, Date_rec, Date_rem, Date_ouv_adm, Date_ouv_fin, 
                   Type, Nature, Type_projet, Seance_ouv, Direction, Res_projet, Site, 
                   Financement, Mode_lan, Statut, Frais_dos, Numero_lot, Libelle, 
                   Impu_bud, Montant_bud, Montant_est, Observation, 
                   DATEDIFF(d, Date_rec, GETDATE()) AS Nbr_jour, Date_rep1, Date_rep2 
            FROM v_ao_aoo 
            WHERE Designa LIKE @SearchTerm OR Site LIKE @SearchTerm";



            // Add parameter to SqlDataSource
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("SearchTerm", $"%{searchTerm}%");

            // Rebind the GridView to update the data
            BindGrid();
        }
        private void BindGrid()
        {
            SqlDataSource1.SelectCommand = $@"SET DATEFORMAT DMY; 
            SELECT Numero_Ao, Designa, Date_lan, Date_rec, Date_rem, Date_ouv_adm, Date_ouv_fin, 
                   Type, Nature, Type_projet, Seance_ouv, Direction, Res_projet, Site, 
                   Financement, Mode_lan, Statut, Frais_dos, Numero_lot, Libelle, 
                   Impu_bud, Montant_bud, Montant_est, Observation, 
                   DATEDIFF(d, Date_rec, GETDATE()) AS Nbr_jour, Date_rep1, Date_rep2 
            FROM v_ao_aoo 
            WHERE Designa LIKE @SearchTerm OR Site LIKE @SearchTerm";

            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectParameters.Add("SearchTerm", $"%{SearchTextBox.Text.Trim()}%");
            if (!string.IsNullOrEmpty(SortExpression))
            {
                SqlDataSource1.SelectCommand += $" ORDER BY {SortExpression} {SortDirection}";
            }
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }


        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            // Update the sort expression and direction
            if (SortExpression == e.SortExpression)
            {
                SortDirection = (SortDirection == "ASC") ? "DESC" : "ASC";
            }
            else
            {
                SortExpression = e.SortExpression;
                SortDirection = "ASC";
            }

            // Rebind the GridView with the updated sort order
            BindGrid();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }
    }
}