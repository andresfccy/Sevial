using Sevial.DATA.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sevial.DATA.Repositories
{
    interface IUsuarioRepository : IDisposable
    {
        IQueryable<UsuarioEntity> GetAll();
        void Add(UsuarioEntity user);
    }
}
