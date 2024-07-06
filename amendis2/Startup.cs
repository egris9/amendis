using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(amendis2.Startup))]
namespace amendis2
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
