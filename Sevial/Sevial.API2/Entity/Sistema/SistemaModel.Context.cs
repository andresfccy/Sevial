﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sevial.API2.Entity.Sistema
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class APPSEVIALEntities1 : DbContext
    {
        public APPSEVIALEntities1()
            : base("name=APPSEVIALEntities1")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual int SP998_ProbarConexion(ObjectParameter codigoRpta, ObjectParameter mensajeRpta)
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SP998_ProbarConexion", codigoRpta, mensajeRpta);
        }
    }
}
