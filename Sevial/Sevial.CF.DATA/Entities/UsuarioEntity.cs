using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sevial.DATA.Entities
{
    public class UsuarioEntity
    {
        public UsuarioEntity() { }

        public Guid Id { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool EmailConfirmado { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FehcaModificacion { get; set; }
    }
}
