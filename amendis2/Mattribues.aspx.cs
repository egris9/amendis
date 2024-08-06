﻿using System;
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
        protected void SearchButton_Clicks(object sender, EventArgs e)
        {
            BindGrid();
        }
        private void BindGrid()
        {
            SqlDataSource1.SelectCommand = $@"SET DATEFORMAT DMY; select Site,Type='Marché',Type as Type_ao,Direction,Type_projet,Numero_Mar, Numero_ao,Numero_lot,Numero_cde_ouv, upper(Designa) as Designa, upper(Libelle) as Libelle,Date_rec,Date_lan,Date_rem,Date_ouv_adm,Date_ouv_fin,Date_rep1,Date_rep2,Date_env_fou,Date_ret_fou,Date_Adj, Date_Not,Date_av_rec =null,Nom as Adjudicataire,Montant,Montant_min,Montant_max,Date_ord_ser,Duree,Montant_cau,Date_rec_pro,Date_rec_def,Date_res_cau,Estim_dac,Financement,Famille,Res_projet,Nature,Mode_lan,Delai,Observation,Montant_n,Montant_n1,Montant_n2,Montant_n3,isnull(Montant_n,0)+isnull(Montant_n1,0)+isnull(Montant_n2,0)+isnull(Montant_n3,0) as Conso from V_AO_Marche
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