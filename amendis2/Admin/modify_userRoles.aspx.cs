using System;
using System.Linq;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using amendis2.Models;
using System.Collections.Generic;

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

                // Load users into the dropdown list
                LoadUsers();

                

                
            }
        }






        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string searchTerm = SearchTextBox.Text.Trim();
            LoadUsers(searchTerm);
        }

        private void LoadUsers(string searchTerm = "")
        {
            var lowerSearchTerm = searchTerm.ToLower();
            var users = _userManager.Users
                .Where(u => u.UserName != null && u.UserName.ToLower().Contains(lowerSearchTerm))
                .ToList();

            BindUsersToDropDown(users);

            if (users.Count == 1)
            {
                UserDropDownList.SelectedValue = users.First().Id;

                // Trigger SelectedIndexChanged manually
                UserDropDownList_SelectedIndexChanged(UserDropDownList, EventArgs.Empty);
            }
            else if (UserDropDownList.SelectedValue != null)
            {
                UserDropDownList_SelectedIndexChanged(UserDropDownList, EventArgs.Empty);
            }
        }


        private void BindUsersToDropDown(IEnumerable<ApplicationUser> users)
        {
            UserDropDownList.DataSource = users;
            UserDropDownList.DataTextField = "UserName";
            UserDropDownList.DataValueField = "Id";
            UserDropDownList.DataBind();
        }

        protected async void UserDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Ensure _userManager is not null
            if (_userManager == null || _roleManager == null)
            {
                StatusMessageLabel.Text = "UserManager or RoleManager is not initialized.";
                StatusMessageLabel.Visible = true;
                return;
            }
            System.Diagnostics.Debug.WriteLine("Selected user ID: " + UserDropDownList.SelectedValue);


            await LoadRoles();
        }

        private async Task LoadRoles()
        {
            if (UserDropDownList.SelectedValue == null)
            {
                System.Diagnostics.Debug.WriteLine("No user selected.");
                return;
            }

            string userId = UserDropDownList.SelectedValue;
            System.Diagnostics.Debug.WriteLine("Loading roles for user ID: " + userId);

            var user = await _userManager.FindByIdAsync(userId);
            if (user != null)
            {
                var userRoles = await _userManager.GetRolesAsync(userId);
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




        protected async void SaveChangesButton_Click(object sender, EventArgs e)
        {
            if (UserDropDownList.SelectedValue == null) return;

            string userId = UserDropDownList.SelectedValue;
            var user = await _userManager.FindByIdAsync(userId);

            if (user != null)
            {
                foreach (ListItem item in RolesCheckBoxList.Items)
                {
                    if (item.Selected && !await _userManager.IsInRoleAsync(userId, item.Text))
                    {
                        var result = await _userManager.AddToRoleAsync(userId, item.Text);
                        if (!result.Succeeded)
                        {
                            StatusMessageLabel.Text = $"Failed to add role '{item.Text}': " + string.Join(", ", result.Errors);
                            StatusMessageLabel.Visible = true;
                        }
                    }
                    else if (!item.Selected && await _userManager.IsInRoleAsync(userId, item.Text))
                    {
                        var result = await _userManager.RemoveFromRoleAsync(userId, item.Text);
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
