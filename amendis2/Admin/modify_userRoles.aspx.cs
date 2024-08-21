using System;
using System.Threading.Tasks;
using amendis2.Models;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System.Linq;

namespace amendis2.Admin
{
    public partial class modify_userRoles : System.Web.UI.Page
    {
        private UserManager<ApplicationUser> _userManager;
        private RoleManager<IdentityRole> _roleManager;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!User.IsInRole("admin"))
                {
                    Response.Redirect("~/Acceuil.aspx"); // Redirect to an access denied page
                }

                // Initialize UserManager and RoleManager
                var context = new ApplicationDbContext();
                _userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(context));
                _roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(context));

                // Load users into the dropdown list
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            if (_userManager == null)
            {
                // Handle the case where _userManager is null
                StatusMessageLabel.Text = "UserManager is not initialized.";
                StatusMessageLabel.Visible = true;
                return;
            }

            var users = _userManager.Users.ToList(); // Convert to a list
            if (UserDropDownList != null)
            {
                UserDropDownList.DataSource = users;
                UserDropDownList.DataTextField = "UserName";
                UserDropDownList.DataValueField = "Id";
                UserDropDownList.DataBind();
            }
            else
            {
                // Handle the case where UserDropDownList is null
                StatusMessageLabel.Text = "UserDropDownList control is not found.";
                StatusMessageLabel.Visible = true;
            }
        }

        protected async void LoadRolesButton_Click(object sender, EventArgs e)
        {
            if (UserDropDownList.SelectedValue == null) return;

            string userId = UserDropDownList.SelectedValue;
            var user = await _userManager.FindByIdAsync(userId);

            if (user != null)
            {
                var userRoles = await _userManager.GetRolesAsync(userId);
                var roles = _roleManager.Roles.ToList(); // Convert to a list

                if (RolesListBox != null)
                {
                    RolesListBox.Items.Clear();
                    foreach (var role in roles)
                    {
                        var item = new ListItem
                        {
                            Text = role.Name,
                            Value = role.Id,
                            Selected = userRoles.Contains(role.Name)
                        };
                        RolesListBox.Items.Add(item);
                    }
                }
                else
                {
                    // Handle the case where RolesListBox is null
                    StatusMessageLabel.Text = "RolesListBox control is not found.";
                    StatusMessageLabel.Visible = true;
                }
            }
            else
            {
                // Handle the case where the user is null
                StatusMessageLabel.Text = "User not found.";
                StatusMessageLabel.Visible = true;
            }
        }


        protected async void AddRoleButton_Click(object sender, EventArgs e)
        {
            if (UserDropDownList.SelectedValue == null) return;

            string userId = UserDropDownList.SelectedValue;
            var user = await _userManager.FindByIdAsync(userId);

            if (user != null)
            {
                foreach (ListItem item in RolesListBox.Items)
                {
                    if (item.Selected && !await _userManager.IsInRoleAsync(userId, item.Text))
                    {
                        var result = await _userManager.AddToRoleAsync(userId, item.Text);
                        if (result.Succeeded)
                        {
                            StatusMessageLabel.Text = $"Role '{item.Text}' added successfully.";
                        }
                        else
                        {
                            StatusMessageLabel.Text = $"Failed to add role '{item.Text}': " + string.Join(", ", result.Errors);
                        }
                    }
                }

                StatusMessageLabel.Visible = true;
            }
        }

        protected async void RemoveRoleButton_Click(object sender, EventArgs e)
        {
            if (UserDropDownList.SelectedValue == null) return;

            string userId = UserDropDownList.SelectedValue;
            var user = await _userManager.FindByIdAsync(userId);

            if (user != null)
            {
                foreach (ListItem item in RolesListBox.Items)
                {
                    if (!item.Selected && await _userManager.IsInRoleAsync(userId, item.Text))
                    {
                        var result = await _userManager.RemoveFromRoleAsync(userId, item.Text);
                        if (result.Succeeded)
                        {
                            StatusMessageLabel.Text = $"Role '{item.Text}' removed successfully.";
                        }
                        else
                        {
                            StatusMessageLabel.Text = $"Failed to remove role '{item.Text}': " + string.Join(", ", result.Errors);
                        }
                    }
                }

                StatusMessageLabel.Visible = true;
            }
        }
    }
}
