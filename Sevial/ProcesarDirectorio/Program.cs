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
                Proceso p = new Proceso();

                RespuestaLista<SP011_DarTipoArchivo_Result> osDartipoArchivo = p.DarTipoArchivo();

                if (osDartipoArchivo.CodigoRpta != 0)
                {
                    Console.WriteLine("error obteniendo tipo archivos. Codigo:" + osDartipoArchivo.CodigoRpta + " Mensaje:" + osDartipoArchivo.MensajeRpta);
                    return;

                }

                Console.WriteLine("Se obtuvieron tipos de archivos size:" + osDartipoArchivo.Lista.Count());

                p.ProcesarTipoArchivo(osDartipoArchivo);

                
                Console.WriteLine("Procesamiento de directorios correctos");
            }
            catch (Exception e)
            {
                Console.WriteLine("Se genero error en procesar Directorio:" + e.Message);
                Console.WriteLine(e.StackTrace);

            }
        }
    }
}
