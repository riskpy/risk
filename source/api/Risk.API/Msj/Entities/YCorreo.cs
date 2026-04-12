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

using System.Collections.Generic;
using Newtonsoft.Json;
using Risk.API.Common.Entities;
using Risk.API.Common.Mappers;
using Risk.API.Common.Models;
using Risk.API.Risk.Entities;
using Risk.API.Risk.Models;
using Risk.API.Msj.Models;

namespace Risk.API.Msj.Entities
{
    public class YCorreo : IEntity
    {
        [JsonProperty("id_correo")]
        public long IdCorreo { get; set; }
        [JsonProperty("destinatario")]
        public string Destinatario { get; set; }
        [JsonProperty("asunto")]
        public string Asunto { get; set; }
        [JsonProperty("contenido")]
        public string Contenido { get; set; }
        [JsonProperty("remitente")]
        public string Remitente { get; set; }
        [JsonProperty("destino_respuesta")]
        public string DestinoRespuesta { get; set; }
        [JsonProperty("destinatario_cc")]
        public string DestinatarioCc { get; set; }
        [JsonProperty("destinatario_bcc")]
        public string DestinatarioBcc { get; set; }
        [JsonProperty("adjuntos")]
        public List<YArchivo> Adjuntos { get; set; }

        public IModel ConvertToModel()
        {
            return new Correo
            {
                IdCorreo = this.IdCorreo,
                Destinatario = this.Destinatario,
                Asunto = this.Asunto,
                Contenido = this.Contenido,
                Remitente = this.Remitente,
                DestinoRespuesta = this.DestinoRespuesta,
                DestinatarioCc = this.DestinatarioCc,
                DestinatarioBcc = this.DestinatarioBcc,
                Adjuntos = EntitiesMapper.GetModelListFromEntity<Archivo, YArchivo>(this.Adjuntos)
            };
        }
    }
}