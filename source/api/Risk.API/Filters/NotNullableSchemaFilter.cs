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

using System.Linq;
using Microsoft.OpenApi;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Risk.API.Filters
{
    public class NotNullableSchemaFilter : ISchemaFilter
    {
        public void Apply(IOpenApiSchema schema, SchemaFilterContext context)
        {
            if (schema is OpenApiSchema openApiSchema)
            {
                if (openApiSchema.Properties == null)
                {
                    return;
                }

                var nullableProperties = openApiSchema
                   .Properties
                   .Where(x => x.Value is OpenApiSchema propSchema &&
                               propSchema.AnyOf != null &&
                               propSchema.AnyOf.Any(s => s.Type == JsonSchemaType.Null))
                   .ToList();

                foreach (var property in nullableProperties)
                {
                    if (property.Value is OpenApiSchema propSchema)
                    {
                        // Remove the null type from AnyOf
                        var nonNullSchemas = propSchema.AnyOf.Where(s => s.Type != JsonSchemaType.Null).ToList();

                        propSchema.AnyOf.Clear();

                        if (nonNullSchemas.Count == 1 && nonNullSchemas[0] is OpenApiSchema remainingSchema)
                        {
                            // If only one schema remains, copy its properties
                            foreach (var anyOfSchema in new[] { remainingSchema })
                            {
                                propSchema.AnyOf.Add(anyOfSchema);
                            }
                        }
                        else
                        {
                            // Keep multiple schemas in AnyOf
                            foreach (var nonNullSchema in nonNullSchemas)
                            {
                                propSchema.AnyOf.Add(nonNullSchema);
                            }
                        }
                    }
                }
            }
        }
    }
}