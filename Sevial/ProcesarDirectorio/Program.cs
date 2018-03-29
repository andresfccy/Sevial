using ProcesarDirectorio.Entity.CargueInformacion;
using ProcesarDirectorio.Models.ObjetoSalida;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProcesarDirectorio
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
               Console.WriteLine("Se inicia proceso con fecha:{0}", DateTime.Now.ToString());

               Proceso p = new Proceso();

                // Se procesan archivos de directorios de los diferentes tipos de archivos
                RespuestaLista<SP011_DarTipoArchivo_Result> osDartipoArchivo = p.DarTipoArchivo();

                if (osDartipoArchivo.CodigoRpta != 0)
                {
                    Console.WriteLine("error obteniendo tipo archivos. Codigo:" + osDartipoArchivo.CodigoRpta + " Mensaje:" + osDartipoArchivo.MensajeRpta);

                }
                else
                {
                    Console.WriteLine("Se obtuvieron tipos de archivos size:" + osDartipoArchivo.Lista.Count());

                    p.ProcesarTipoArchivo(osDartipoArchivo);


                    Console.WriteLine("Procesamiento de directorios correctos");

                }

                // Se procesan archivos pendientes de cargue
                RespuestaLista<SP015_DarArchivosProcesar_Result> osDarArchivosProcesar = p.DarArchivosProcesar();

                if (osDarArchivosProcesar.CodigoRpta != 0)
                {
                    Console.WriteLine("error obteniendo archivos a procesar. Codigo:" + osDarArchivosProcesar.CodigoRpta + " Mensaje:" + osDarArchivosProcesar.MensajeRpta);

                }
                else
                {
                    Console.WriteLine("Se obtuvieron archivos por procesar:" + osDarArchivosProcesar.Lista.Count());

                    p.ProcesarArchivos(osDarArchivosProcesar);


                    Console.WriteLine("Procesamiento de archivos correcto");

                }

                Console.WriteLine("Se finaliza proceso con fecha:{0}", DateTime.Now.ToString());

            }
            catch (Exception e)
            {
                Console.WriteLine("Se genero error en procesar Directorio:" + e.Message);
                Console.WriteLine(e.InnerException);
                Console.WriteLine(e.StackTrace);

            }
        }
    }
}
