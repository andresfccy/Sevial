using Microsoft.Owin.Security.OAuth;
using System;
using System.Collections.Generic;
using System.Linq;
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

            // Buscar el usuario y dejarlo en la variable user


            if (user == null)
            {
                context.SetError("invalid_grant", "El nombre de usuario o contraseña son incorrectos.");
                return;
            }
            if (user.Empresa == null && user.Rango == 0)
            {
                estado = "CrearEmpresa";
            }
            else if (user.Empresa == null && user.Rango > 0)
            {
                estado = "EmpresaNoCreada";
            }

            if (!user.EmailConfirmed)
            {
                context.SetError("invalid_grant", "Tu cuenta no ha sido confirmada, revisa la bandeja de entrada de tu correo electrónico para completar su registro.");
                return;
            }
            // hacer más verificaciones si es necesario
            roles = _repo.DarRolesUsuario(user.Id);

            var identity = new ClaimsIdentity(context.Options.AuthenticationType);
            identity.AddClaim(new Claim("sub", context.UserName));
            String rolesString = "";
            foreach (var r in roles)
            {
                rolesString = "," + r.Id;
                identity.AddClaim(new Claim("role", r.Name));
            }
            rolesString = rolesString.Substring(1);

            var props = new AuthenticationProperties(new Dictionary<string, string>
                {
                    {
                        "userId", user.Id.ToString()
                    },
                    {
                        "userName", context.UserName
                    },
                    {
                        "userRoles", rolesString
                    },
                    {
                        "estado", estado
                    }
                });

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