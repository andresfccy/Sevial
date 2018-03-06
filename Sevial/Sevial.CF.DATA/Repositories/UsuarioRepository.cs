using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Sevial.DATA.Entities;

namespace Sevial.DATA.Repositories
{
    class UsuarioRepository : IUsuarioRepository
    {
        public void Add(UsuarioEntity user)
        {
            throw new NotImplementedException();
        }

        IEnumerable<UsuarioEntity> IUsuarioRepository.GetAll()
        {
            return new List<UsuarioEntity>();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }
    }
}
