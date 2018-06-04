using ProcesarDirectorio.Entity.CargueInformacion;
using ProcesarDirectorio.Models.ObjetoSalida;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
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

            var result = db.SP012_RegistrarArchivo(tipoArchivo, nombreArchivo, codigoRpta, mensajeRpta);

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

        public RespuestaLista<SP015_DarArchivosProcesar_Result> DarArchivosProcesar()
        {
            ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
            ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));

            var result = db.SP015_DarArchivosProcesar(codigoRpta, mensajeRpta);
            var dataSet = result.ToList();


            RespuestaLista<SP015_DarArchivosProcesar_Result> os = new RespuestaLista<SP015_DarArchivosProcesar_Result>();

            os.CodigoRpta = Convert.ToInt32(codigoRpta.Value);
            os.MensajeRpta = mensajeRpta.Value.ToString();
            os.Lista = dataSet;

            return os;

        }

        public void ProcesarArchivos(RespuestaLista<SP015_DarArchivosProcesar_Result> oe)
        {
            // Obtener parametros de los tipos de archivos parametrizados
            RespuestaLista<SP011_DarTipoArchivo_Result> osDartipoArchivo = DarTipoArchivo();

            foreach (SP015_DarArchivosProcesar_Result archivo in oe.Lista)
            {
                Console.WriteLine("Se procesa archivo:" + archivo.A020_nombre);

                ObjectParameter codigoRpta = new ObjectParameter("CodigoRpta", typeof(Int32));
                ObjectParameter mensajeRpta = new ObjectParameter("MensajeRpta", typeof(String));
                db.Database.CommandTimeout = 0;

                try
                {
                    var result = db.SP016_CargaArchivo(archivo.A020_tipoCargue, archivo.A020_codigo, archivo.A020_nombre, codigoRpta, mensajeRpta);
                    Console.WriteLine("Se proceso archivo . Codigo: {0} Mensaje {1}", Convert.ToInt32(codigoRpta.Value), mensajeRpta.Value.ToString());

                    if (Convert.ToInt32(codigoRpta.Value) == 0)
                    {
                        // Se busca parametrizacion del tipo de archivo
                        foreach (SP011_DarTipoArchivo_Result tipoArchivo in osDartipoArchivo.Lista)
                        {
                            if (!System.IO.Directory.Exists(tipoArchivo.A015_carpetaHistorico))
                                System.IO.Directory.CreateDirectory(tipoArchivo.A015_carpetaHistorico);

                            if (tipoArchivo.A015_tipoArchivo == archivo.A020_tipoCargue)
                            {
                                // Mover archivo procesado a carpeta historica
                                string nomOrigen = tipoArchivo.A015_carpeta + "/" + archivo.A020_nombre;
                                string nomDestino = tipoArchivo.A015_carpetaHistorico + "/" + archivo.A020_nombre;

                                if (System.IO.File.Exists(nomDestino))
                                    System.IO.File.Delete(nomDestino);

                                System.IO.File.Move(nomOrigen, nomDestino);
                            }
                        }

                        EnviarCorreo(archivo.A020_codigo, "Cargue exitoso archivo " + archivo.A020_nombre, "El archivo con nombre " + archivo.A020_nombre + " se cargo exitosamente");
                    }
                    else
                    {
                        EnviarCorreo(archivo.A020_codigo, "ERROR BD:Se finalizo proceso de cargue de archivo " + archivo.A020_nombre, "El archivo con nombre " + archivo.A020_nombre + " se termino de procesar, pero presento problemas. Por favor consultar aplicativo");
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine("Se finalizo proceso de cargue de archivo " + archivo.A020_nombre, "El archivo con nombre " + archivo.A020_nombre + " se termino de procesar, pero presento problemas. Por favor consultar aplicativo");
                    Console.WriteLine(e.InnerException);
                    Console.WriteLine(e.StackTrace);
                    Console.WriteLine(e.Message);

                    EnviarCorreo(archivo.A020_codigo, "ERROR APP: Se finalizo proceso de cargue de archivo " + archivo.A020_nombre, "El archivo con nombre " + archivo.A020_nombre + " se termino de procesar, pero presento problemas. Por favor consultar aplicativo");

                }
            }
        }

        public void EnviarCorreo(int idArchivo, string asunto, string cuerpo)
        {
            // Enviar correo de cargue exitoso
            MailMessage mail = new MailMessage();
            SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

            mail.From = new MailAddress("hugocendales@gmail.com");
            mail.To.Add("hugo.cendales@fasoftcol.com");
            mail.Subject = asunto;
            mail.Body = cuerpo;

            SmtpServer.Port = 587;
            SmtpServer.Credentials = new System.Net.NetworkCredential("hugocendales@gmail.com", "22OCt71hu");
            SmtpServer.EnableSsl = true;

            SmtpServer.Send(mail);

        }
    }
}
