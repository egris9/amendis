using System;
using System.Web.UI;
using amendis2.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;

namespace amendis2.Admin
{
    public partial class admin_acount_creation : System.Web.UI.Page
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
            }

            // Initialize UserManager and RoleManager
            _userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            _roleManager = new RoleManager<IdentityRole>(new RoleStore<IdentityRole>(new ApplicationDbContext()));
        }

        protected async void CreateUserButton_Click(object sender, EventArgs e)
        {
            string username = UsernameTextBox.Text.Trim();
            string password = PasswordTextBox.Text.Trim();
            string email = EmailTextBox.Text.Trim();
            string selectedRoleName = RoleDropDownList.SelectedValue;

            // Create a new user
            var user = new ApplicationUser
            {
                UserName = username,
                Email = email
            };

            // Create the user using UserManager
            var result = await _userManager.CreateAsync(user, password);

            if (result.Succeeded)
            {
                // Retrieve the RoleId by RoleName
                var role = _roleManager.FindByName(selectedRoleName);
                if (role != null)
                {
                    // Assign the role to the user
                    var roleResult = await _userManager.AddToRoleAsync(user.Id, selectedRoleName);

                    if (roleResult.Succeeded)
                    {
                        // Notify success
                        SuccessMessageLabel.Text = "User created and assigned role successfully.";
                        SuccessMessageLabel.Visible = true;
                    }
                    else
                    {
                        // Handle role assignment errors
                        SuccessMessageLabel.Text = "User created, but failed to assign role: " + string.Join(", ", roleResult.Errors);
                        SuccessMessageLabel.Visible = true;
                    }
                }
                else
                {
                    // Handle role not found
                    SuccessMessageLabel.Text = "Role not found.";
                    SuccessMessageLabel.Visible = true;
                }
            }
            else
            {
                // Handle user creation errors
                SuccessMessageLabel.Text = "Failed to create user: " + string.Join(", ", result.Errors);
                SuccessMessageLabel.Visible = true;
            }
        }
    }
}
