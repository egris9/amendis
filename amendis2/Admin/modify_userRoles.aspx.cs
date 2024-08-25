using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using amendis2.Models;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.Security;


namespace amendis2.Admin
{
    public partial class modify_userRoles : System.Web.UI.Page
    {
        private UserManager<ApplicationUser> _userManager;
        private RoleManager<IdentityRole> _roleManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialize UserManager and RoleManager
            var context = new ApplicationDbContext();
            _userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
            _roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));

            if (!IsPostBack)
            {
                if (!User.IsInRole("admin"))
                {
                    Response.Redirect("~/Acceuil.aspx"); // Redirect to an access denied page
                }
                PopulateDatalist();
            }
        }

        private void PopulateDatalist()
        {
            var users = _userManager.Users.ToList();

            foreach (var user in users)
            {
                HtmlGenericControl option = new HtmlGenericControl("option");
                option.Attributes.Add("value", user.UserName);
                option.InnerText = user.UserName;
                // Add the <option> to the <datalist>
                dynamicList.Controls.Add(option);
            }
        }

        private async Task LoadRoles(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                System.Diagnostics.Debug.WriteLine("No user selected.");
                return;
            }

            System.Diagnostics.Debug.WriteLine("Loading roles for user: " + username);

            var user = await _userManager.FindByNameAsync(username);
            if (user != null)
            {
                var userRoles = await _userManager.GetRolesAsync(user.Id);
                var roles = _roleManager.Roles.ToList();

                RolesCheckBoxList.Items.Clear();
                foreach (var role in roles)
                {
                    var item = new ListItem
                    {
                        Text = role.Name,
                        Value = role.Id,
                        Selected = userRoles.Contains(role.Name)
                    };
                    RolesCheckBoxList.Items.Add(item);
                }
            }
            else
            {
                StatusMessageLabel.Text = "User not found.";
                StatusMessageLabel.Visible = true;
            }
        }

        protected async void SearchButton_Click(object sender, EventArgs e)
        {
            string username = SearchTextBox.Text;
            await LoadRoles(username);
        }

        protected async void SaveChangesButton_Click(object sender, EventArgs e)
        {
            string username = SearchTextBox.Text;
            var user = await _userManager.FindByNameAsync(username);

            if (user != null)
            {
                foreach (ListItem item in RolesCheckBoxList.Items)
                {
                    if (item.Selected && !await _userManager.IsInRoleAsync(user.Id, item.Text))
                    {
                        var result = await _userManager.AddToRoleAsync(user.Id, item.Text);
                        if (!result.Succeeded)
                        {
                            StatusMessageLabel.Text = $"Failed to add role '{item.Text}': " + string.Join(", ", result.Errors);
                            StatusMessageLabel.Visible = true;
                        }
                    }
                    else if (!item.Selected && await _userManager.IsInRoleAsync(user.Id, item.Text))
                    {
                        var result = await _userManager.RemoveFromRoleAsync(user.Id, item.Text);
                        if (!result.Succeeded)
                        {
                            StatusMessageLabel.Text = $"Failed to remove role '{item.Text}': " + string.Join(", ", result.Errors);
                            StatusMessageLabel.Visible = true;
                        }
                    }
                }

                StatusMessageLabel.Text = "Roles updated successfully.";
                StatusMessageLabel.Visible = true;
            }
        }
    }
}

