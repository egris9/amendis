using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace amendis2.Admin
{
    public partial class Dashb : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.IsInRole("admin"))
            {
                Response.Redirect("~/Acceuil.aspx"); // Rediriger vers une page d'accès refusé
            }
        }

    }
}