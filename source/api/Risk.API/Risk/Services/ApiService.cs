/*
--------------------------------- MIT License ---------------------------------
Copyright (c) 2019 - 2026 jtsoya539, DamyGenius and RISK contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-------------------------------------------------------------------------------
*/

using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using Risk.API.Attributes;
using Risk.API.Entities;
using Risk.API.Helpers;
using Risk.API.Mappers;
using Risk.API.Models;
using Risk.API.Services;
using Risk.API.Services.Settings;

namespace Risk.API.Risk.Services
{
    public class ApiService : RiskServiceBase, IApiService
    {
        private const string DOMINIO_OPERACION = "API";

        public ApiService(ILogger<GenService> logger, ISettingsService settingsService, IHttpContextAccessor httpContextAccessor, IDbConnectionFactory dbConnectionFactory)
            : base(logger, settingsService, httpContextAccessor, dbConnectionFactory)
        {
        }

        public Respuesta<JObject> ProcesarServicio(string nombre, string dominio, JObject parametros = null)
        {
            prms = new JObject();
            if (parametros != null)
            {
                prms = parametros;
            }

            rsp = base.ProcesarOperacion(TipoOperacion.Servicio, nombre, dominio, prms);
            var entityRsp = rsp.ToObject<YRespuesta<JObject>>();

            return EntitiesMapper.GetRespuestaFromEntity(entityRsp, entityRsp.Datos);
        }

        public Respuesta<Pagina<JObject>> ProcesarServicioPagina(string nombre, string dominio, PaginaParametros paginaParametros = null, JObject parametros = null)
        {
            prms = new JObject();
            if (parametros != null)
            {
                prms = parametros;
            }

            if (paginaParametros != null)
            {
                prms["pagina_parametros"] = JToken.FromObject(ModelsMapper.GetEntityFromModel<PaginaParametros, YPaginaParametros>(paginaParametros));
            }

            rsp = base.ProcesarOperacion(TipoOperacion.Servicio, nombre, dominio, prms);
            var entityRsp = rsp.ToObject<YRespuesta<YPagina<JObject>>>();

            Pagina<JObject> datos = null;
            if (entityRsp.Datos != null)
            {
                datos = EntitiesMapper.GetPaginaFromEntity(entityRsp.Datos, entityRsp.Datos.Elementos);
            }

            return EntitiesMapper.GetRespuestaFromEntity(entityRsp, datos);
        }

        public Respuesta<Archivo> ProcesarReporte(string nombre, string dominio, FormatoReporte formato, JObject parametros = null)
        {
            prms = new JObject();
            if (parametros != null)
            {
                prms = parametros;
            }
            prms["formato"] = formato.GetStringValue();

            rsp = base.ProcesarOperacion(TipoOperacion.Reporte, nombre, dominio, prms);
            var entityRsp = rsp.ToObject<YRespuesta<YArchivo>>();

            return EntitiesMapper.GetRespuestaFromEntity<Archivo, YArchivo>(entityRsp, EntitiesMapper.GetModelFromEntity<Archivo, YArchivo>(entityRsp.Datos));
        }
    }
}
