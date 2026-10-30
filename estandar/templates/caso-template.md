# Plantilla — caso de análisis

Un caso de análisis es un flujo reproducible sobre datos de un sector: una consulta real que se resolvió navegando las fuentes oficiales y procesando sus datos. Vive en `examples/<slug>/` dentro del atlas, con un `README.md` que sigue esta plantilla y los archivos que produce.

La ruta de navegación es parte del caso, no un artefacto aparte: el README documenta cómo se llegó a los datos.

## Caso o consulta

- Consulta resuelta con datos descargados y procesados de fuentes oficiales, o herramienta construida sobre esos datos: caso nuevo.
- Ruta de navegación útil sin procesamiento de datos: consulta en `examples/consultas-de-ejemplo.md` del atlas.

## Nombre de la carpeta

`tema-subtema/` en minúsculas con guiones. Por ejemplo, `balance-energetico-consumo-final/` o `deforestacion-series-smbyc/`.

## README del caso

```markdown
---
tipo: analisis
entidades: [navegar-<entidad>, ...]
tema: <tema> / <subtema>
fecha: AAAA-MM-DD
---

# [Título descriptivo]

## Consulta
"¿Pregunta o tarea concreta que motivó el análisis?"

## Cómo se llegó a los datos
Ruta de navegación que condujo a la fuente: entidad → sistema → sección.

## Datos
Fuente oficial exacta, formato y cómo obtenerlos (URL, API o paso de descarga).
Los datos crudos no se incluyen en el repositorio; se documenta su origen para que el caso sea reproducible.

## Metodología
Pasos reproducibles y decisiones de procesamiento.

## Herramientas
Stack usado (Python, pandas, Power BI, etc.) y los archivos construidos, con su ubicación dentro de la carpeta.

## Resultado
Qué se obtuvo (incluidas figuras o reportes) y con qué limitaciones.
```

## Campos de frontmatter

| Campo | Uso |
|-------|-----|
| `tipo` | `analisis` |
| `entidades` | Skills involucradas |
| `tema` | Tema principal del caso |
| `fecha` | Cuándo se corrió o verificó el caso |

Al agregar un caso, súmalo a la tabla de casos de `examples/README.md` del atlas.
