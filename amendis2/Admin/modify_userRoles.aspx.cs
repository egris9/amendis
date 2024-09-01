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

        private async Task LoadUserDetails(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                StatusMessageLabel.Text = "No user selected.";
                StatusMessageLabel.Visible = true;
                return;
            }

            var user = await _userManager.FindByNameAsync(username);
            if (user != null)
            {
                UsernameTextBox.Text = user.UserName;
                EmailTextBox.Text = user.Email;

                // Load roles
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

                UserDetailsPanel.Visible = true;
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
            await LoadUserDetails(username);
        }

        protected async void SaveChangesButton_Click(object sender, EventArgs e)
        {
            string username = SearchTextBox.Text;
            var user = await _userManager.FindByNameAsync(username);

            if (user != null)
            {
                // Update basic user info
                user.UserName = UsernameTextBox.Text;
                user.Email = EmailTextBox.Text;

                var result = await _userManager.UpdateAsync(user);
                if (result.Succeeded)
                {
                    // Update roles
                    foreach (ListItem item in RolesCheckBoxList.Items)
                    {
                        if (item.Selected && !await _userManager.IsInRoleAsync(user.Id, item.Text))
                        {
                            var roleResult = await _userManager.AddToRoleAsync(user.Id, item.Text);
                            if (!roleResult.Succeeded)
                            {
                                StatusMessageLabel.Text = $"Failed to add role '{item.Text}': " + string.Join(", ", roleResult.Errors);
                                StatusMessageLabel.Visible = true;
                            }
                        }
                        else if (!item.Selected && await _userManager.IsInRoleAsync(user.Id, item.Text))
                        {
                            var roleResult = await _userManager.RemoveFromRoleAsync(user.Id, item.Text);
                            if (!roleResult.Succeeded)
                            {
                                StatusMessageLabel.Text = $"Failed to remove role '{item.Text}': " + string.Join(", ", roleResult.Errors);
                                StatusMessageLabel.Visible = true;
                            }
                        }
                    }

                    // Update password
                    var newPassword = PasswordTextBox.Text;
                    if (!string.IsNullOrEmpty(newPassword))
                    {
                        var passwordResult = await _userManager.RemovePasswordAsync(user.Id);
                        if (passwordResult.Succeeded)
                        {
                            passwordResult = await _userManager.AddPasswordAsync(user.Id, newPassword);
                            if (passwordResult.Succeeded)
                            {
                                StatusMessageLabel.Text = "User updated successfully.";
                                StatusMessageLabel.Visible = true;
                            }
                            else
                            {
                                StatusMessageLabel.Text = $"Failed to update password: " + string.Join(", ", passwordResult.Errors);
                                StatusMessageLabel.Visible = true;
                            }
                        }
                        else
                        {
                            StatusMessageLabel.Text = $"Failed to remove old password: " + string.Join(", ", passwordResult.Errors);
                            StatusMessageLabel.Visible = true;
                        }
                    }
                }
                else
                {
                    StatusMessageLabel.Text = $"Failed to update user: " + string.Join(", ", result.Errors);
                    StatusMessageLabel.Visible = true;
                }
            }
        }

    }
}


