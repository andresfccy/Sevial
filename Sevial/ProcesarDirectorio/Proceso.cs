using ProcesarDirectorio.Entity.CargueInformacion;
using ProcesarDirectorio.Models.ObjetoSalida;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProcesarDirectorio
{
    class Proceso
    {

        private APPSEVIALCargueInformacionEntities db = new APPSEVIALCargueInformacionEntities();

        public RespuestaLista<SP011_DarTipoArchivo_Result> DarTipoArchivo()
        {
            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP011_DarTipoArchivo(codigoRpta, mensajeRpta);
            var dataSet = result.ToList();


            RespuestaLista<SP011_DarTipoArchivo_Result> os = new RespuestaLista<SP011_DarTipoArchivo_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return os;

        }

        public void ProcesarTipoArchivo(RespuestaLista<SP011_DarTipoArchivo_Result> oe)
        {
            foreach (SP011_DarTipoArchivo_Result tipoArchivo in oe.Lista)
            {
                Console.WriteLine("Se procesa tipo de archivo:" + tipoArchivo.nomTipoArchivo);
                string comodin = ObtenerComodin(tipoArchivo.A015_comodin);

                List<string> archivosDir = DarArchivosDirectorio(tipoArchivo.A015_carpeta, comodin);

                foreach (string nomArchivo in archivosDir)
                {
                    Console.WriteLine("Se procesa archivo: {0}", nomArchivo);
                    RegistrarArchivo(tipoArchivo.A015_tipoArchivo, nomArchivo);
                }

            }

        }

        private void RegistrarArchivo(int? tipoArchivo, string nombreArchivo)
        {
            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP012_RegistrarArchivo(tipoArchivo, nombreArchivo,codigoRpta, mensajeRpta);

            Console.WriteLine("Se registro archivo. Codigo: {0} Mensaje {1}", Convert.ToInt32(codigoRpta.Value), mensajeRpta.Value.ToString());

        }

        private List<string> DarArchivosDirectorio(string carpeta, string comodin)
        {
            if (!System.IO.Directory.Exists(carpeta))
                System.IO.Directory.CreateDirectory(carpeta);

            List<string> lista = new List<string>();
            DirectoryInfo di = new DirectoryInfo(carpeta);

            foreach (var fi in di.GetFiles(comodin))
            {
                lista.Add(fi.Name);
            }

            return lista;
        }
        private string ObtenerComodin(string comodin)
        {
            string resul = comodin;
            resul = resul.Replace("aaaammdd", "*");
            resul = resul.Replace("aaaamm", "*");

            return resul;
        }
    }
}
