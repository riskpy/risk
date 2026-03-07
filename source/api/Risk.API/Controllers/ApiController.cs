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

using System.Net.Mime;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using Risk.API.Models;
using Risk.API.Services;
using Risk.API.Services.Settings;
using Risk.Common.Helpers;
using Swashbuckle.AspNetCore.Annotations;

namespace Risk.API.Controllers
{
    [SwaggerTag("Servicios del dominio OPERACIONES", "https://riskpy.github.io/risk/")]
    [Authorize(Roles = "ADMINISTRADOR,USUARIO,USUARIO_NUEVO")]
    [Route("Api/[controller]")]
    [ApiController]
    public class ApiController : RiskControllerBase
    {
        private readonly IApiService _apiService;

        public ApiController(ISettingsService settingsService, IApiService apiService) : base(settingsService)
        {
            _apiService = apiService;
        }

        [HttpPost("ProcesarReporte")]
        [SwaggerOperation(OperationId = "ProcesarReporte", Summary = "ProcesarReporte", Description = "Procesa un reporte")]
        [Produces(MediaTypeNames.Application.Json, new[] { "application/octet-stream" })]
        [SwaggerResponse(StatusCodes.Status200OK, RiskConstants.SWAGGER_RESPONSE_200, typeof(FileContentResult))]
        public IActionResult ProcesarReporte([FromQuery, SwaggerParameter(Description = "Formato del reporte", Required = true)] FormatoReporte formato,
            [FromQuery, SwaggerParameter(Description = "Nombre", Required = true)] string nombre,
            [FromQuery, SwaggerParameter(Description = "Dominio", Required = true)] string dominio,
            [FromBody] JObject parametros = null)
        {
            var respuesta = _apiService.ProcesarReporte(nombre, dominio, formato, parametros);

            if (!respuesta.Codigo.Equals(RiskConstants.CODIGO_OK))
            {
                return ProcesarRespuesta(respuesta);
            }

            return ProcesarArchivo(respuesta.Datos);
        }
    }
}
