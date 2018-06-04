﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sevial.API2.Entity.Deuda
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class APPSEVIALDeuda : DbContext
    {
        public APPSEVIALDeuda()
            : base("name=APPSEVIALDeuda")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual ObjectResult<SP022_DarFechasControl_Result> SP022_DarFechasControl(string aliasUsuario, ObjectParameter codigoRpta, ObjectParameter mensajeRpta)
        {
            var aliasUsuarioParameter = aliasUsuario != null ?
                new ObjectParameter("aliasUsuario", aliasUsuario) :
                new ObjectParameter("aliasUsuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP022_DarFechasControl_Result>("SP022_DarFechasControl", aliasUsuarioParameter, codigoRpta, mensajeRpta);
        }
    
        public virtual int SP023_EnviarProcesoDeuda(string aliasUsuario, string fechaProceso, string condicionProceso, ObjectParameter codigoRpta, ObjectParameter mensajeRpta)
        {
            var aliasUsuarioParameter = aliasUsuario != null ?
                new ObjectParameter("aliasUsuario", aliasUsuario) :
                new ObjectParameter("aliasUsuario", typeof(string));
    
            var fechaProcesoParameter = fechaProceso != null ?
                new ObjectParameter("fechaProceso", fechaProceso) :
                new ObjectParameter("fechaProceso", typeof(string));
    
            var condicionProcesoParameter = condicionProceso != null ?
                new ObjectParameter("condicionProceso", condicionProceso) :
                new ObjectParameter("condicionProceso", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SP023_EnviarProcesoDeuda", aliasUsuarioParameter, fechaProcesoParameter, condicionProcesoParameter, codigoRpta, mensajeRpta);
        }
    
        public virtual ObjectResult<SP024_ConsultarEstadoProcDeuda_Result> SP024_ConsultarEstadoProcDeuda(string aliasUsuario, string fechaProceso, string condicionProceso, ObjectParameter codigoRpta, ObjectParameter mensajeRpta)
        {
            var aliasUsuarioParameter = aliasUsuario != null ?
                new ObjectParameter("aliasUsuario", aliasUsuario) :
                new ObjectParameter("aliasUsuario", typeof(string));
    
            var fechaProcesoParameter = fechaProceso != null ?
                new ObjectParameter("fechaProceso", fechaProceso) :
                new ObjectParameter("fechaProceso", typeof(string));
    
            var condicionProcesoParameter = condicionProceso != null ?
                new ObjectParameter("condicionProceso", condicionProceso) :
                new ObjectParameter("condicionProceso", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP024_ConsultarEstadoProcDeuda_Result>("SP024_ConsultarEstadoProcDeuda", aliasUsuarioParameter, fechaProcesoParameter, condicionProcesoParameter, codigoRpta, mensajeRpta);
        }
    
        public virtual ObjectResult<SP025_ListarEntregaCartera_Result> SP025_ListarEntregaCartera(string aliasUsuario, ObjectParameter codigoRpta, ObjectParameter mensajeRpta)
        {
            var aliasUsuarioParameter = aliasUsuario != null ?
                new ObjectParameter("aliasUsuario", aliasUsuario) :
                new ObjectParameter("aliasUsuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<SP025_ListarEntregaCartera_Result>("SP025_ListarEntregaCartera", aliasUsuarioParameter, codigoRpta, mensajeRpta);
        }
    
        public virtual int SP026_EditarEntregaCartera(string aliasUsuario, Nullable<int> idRegistro, string fechaInicial, string fechaFinal, ObjectParameter codigoRpta, ObjectParameter mensajeRpta)
        {
            var aliasUsuarioParameter = aliasUsuario != null ?
                new ObjectParameter("aliasUsuario", aliasUsuario) :
                new ObjectParameter("aliasUsuario", typeof(string));
    
            var idRegistroParameter = idRegistro.HasValue ?
                new ObjectParameter("idRegistro", idRegistro) :
                new ObjectParameter("idRegistro", typeof(int));
    
            var fechaInicialParameter = fechaInicial != null ?
                new ObjectParameter("fechaInicial", fechaInicial) :
                new ObjectParameter("fechaInicial", typeof(string));
    
            var fechaFinalParameter = fechaFinal != null ?
                new ObjectParameter("fechaFinal", fechaFinal) :
                new ObjectParameter("fechaFinal", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SP026_EditarEntregaCartera", aliasUsuarioParameter, idRegistroParameter, fechaInicialParameter, fechaFinalParameter, codigoRpta, mensajeRpta);
        }
    
        public virtual int SP027_BorrarEntregaCartera(string aliasUsuario, Nullable<int> idRegistro, ObjectParameter codigoRpta, ObjectParameter mensajeRpta)
        {
            var aliasUsuarioParameter = aliasUsuario != null ?
                new ObjectParameter("aliasUsuario", aliasUsuario) :
                new ObjectParameter("aliasUsuario", typeof(string));
    
            var idRegistroParameter = idRegistro.HasValue ?
                new ObjectParameter("idRegistro", idRegistro) :
                new ObjectParameter("idRegistro", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("SP027_BorrarEntregaCartera", aliasUsuarioParameter, idRegistroParameter, codigoRpta, mensajeRpta);
        }
    }
}
