//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sevial.API.Entity
{
    using System;
    
    public partial class SP001_AutenticarUsuario_Result
    {
        public int A001_codigo { get; set; }
        public string A001_aliasUsuario { get; set; }
        public string A001_clave { get; set; }
        public string A001_nombreCompleto { get; set; }
        public string A001_correoElectronico { get; set; }
        public Nullable<bool> A001_inactivo { get; set; }
        public Nullable<bool> A001_bloqueo { get; set; }
        public Nullable<bool> A001_cambioClave { get; set; }
        public Nullable<System.DateTime> A001_fechaUltimoIngreso { get; set; }
        public Nullable<System.DateTime> A001_fechaInactivo { get; set; }
        public Nullable<System.DateTime> A001_fechaBloqueo { get; set; }
        public Nullable<System.DateTime> A001_fechaCambioClave { get; set; }
        public Nullable<System.DateTime> A001_fechaCreacion { get; set; }
        public Nullable<System.DateTime> A001_fechaModificacion { get; set; }
        public Nullable<int> A001_usuarioCreacion { get; set; }
        public Nullable<int> A001_usuarioModificacion { get; set; }
        public string A001_estadoRegistro { get; set; }
    }
}
