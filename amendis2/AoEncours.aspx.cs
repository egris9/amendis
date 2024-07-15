using System;
using System.Collections.Generic;
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
            if (!IsPostBack)
            {
                // Optionally, you can bind the GridView here if needed
                BindGrid();
            }
        }
        private void BindGrid()
        {
            SqlDataSource1.Selecting += new SqlDataSourceSelectingEventHandler(SqlDataSource1_Selecting);
            GridView1.DataBind();
        }
        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            // Set the date format before executing the select command
            e.Command.CommandText = "SET DATEFORMAT DMY; " + e.Command.CommandText;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}