using Microsoft.Owin.Security;
using Microsoft.Owin.Security.OAuth;
using Sevial.DATA.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;

namespace Sevial.API.Providers
{
    public class SimpleAuthorizationProvider : OAuthAuthorizationServerProvider
    {
        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { "*" });

            if (context.UserName == "" || context.Password == "")
            {
                context.SetError("invalid_grant", "Los campos de Usuario y Contraseña son obligatorios.");
                return;
            }

            // TODO: Buscar el usuario y dejarlo en la variable user
            UsuarioEntity user = new UsuarioEntity(){
                Id = new Guid(),
                UserName = "username_dummy",
                EmailConfirmado = true
            };

            if (user == null)
            {
                context.SetError("invalid_grant", "El nombre de usuario o contraseña son incorrectos.");
                return;
            }

            if (!user.EmailConfirmado)
            {
                context.SetError("invalid_grant", "Tu cuenta no ha sido confirmada, revisa la bandeja de entrada de tu correo electrónico para completar el registro.");
                return;
            }
            // hacer más verificaciones si es necesario
            //roles = _repo.DarRolesUsuario(user.Id);

            var identity = new ClaimsIdentity(context.Options.AuthenticationType);
            identity.AddClaim(new Claim("sub", context.UserName));
            //String rolesString = "";
            //foreach (var r in roles)
            //{
            //    rolesString = "," + r.Id;
            //    identity.AddClaim(new Claim("role", r.Name));
            //}
            //rolesString = rolesString.Substring(1);

            var props = new AuthenticationProperties(new Dictionary<string, string>
                {
                    {
                        "userId", user.Id.ToString()
                    },
                    {
                        "userName", user.UserName
                    },
                    //{
                    //    "userRoles", rolesString
                    //}
                });

            // Creación del Token
            var ticket = new AuthenticationTicket(identity, props);
            context.Validated(ticket);
        }

        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string, string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }

            return Task.FromResult<object>(null);
        }
    }
}