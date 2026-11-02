# Fuentes — Parques Nacionales Naturales de Colombia (PNN)

---

## Sistemas de información y plataformas

| Nombre | URL | Descripción | Verificado |
|---|---|---|---|
| RUNAP — Registro Único Nacional de Áreas Protegidas | https://runap.parquesnacionales.gov.co/ | Registro oficial de todas las áreas protegidas de Colombia: nacionales, regionales y locales. Incluye cifras consolidadas, visor geográfico con shapefile descargable, y reportes. | 2026-06-15 |
| SINAP — Sistema Nacional de Áreas Protegidas | https://www.parquesnacionales.gov.co/sistema-nacional-de-areas-protegidas/ | Página institucional vigente con definición, categorías, representatividad, plan de acción y subsistemas regionales del SINAP. | 2026-07-23 |
| Certificador SINAP | https://cert.parquesnacionales.gov.co/auth | Herramienta de certificación de áreas protegidas para el SINAP. Requiere autenticación; manuales disponibles públicamente. | 2026-06-15 |

---

## Geovisores y mapas

| Nombre | URL | Capas principales | Verificado |
|---|---|---|---|
| Geovisor Áreas Protegidas (ArcGIS) | https://mapas.parquesnacionales.gov.co/ | Mapa interactivo de las 61 áreas del SPNN. Redirige a ArcGIS Online; requiere JavaScript. | 2026-06-15 |
| GeoNetwork — Catálogo de Metadatos Espaciales | https://geonetwork.parquesnacionales.gov.co/geonetwork/srv/spa/catalog.search#/home | Catálogo de datos espaciales y metadatos de áreas protegidas: conjuntos de datos y servicios web geográficos (OGC:WFS y enlaces HTML) sobre límites, coberturas y zonificación de planes de manejo. Si responde 403 a un cliente automático, abrirlo con navegador. | 2026-11-02 |

---

## Portales de datos

| Nombre | URL | Descripción | Verificado |
|---|---|---|---|
| Herencia Colombia | https://www.parquesnacionales.gov.co/herencia-colombia/ | Programa de financiamiento para la permanencia del SINAP: 42 millones de hectáreas, 5 mosaicos regionales, alianzas con Moore Foundation, WWF, CI, WCS y Bezos Earth Fund. | 2026-06-15 |
| SIRAP Orinoquía | https://www.parquesnacionales.gov.co/home/sirap-orinoquia/ | Subsistema Regional de Áreas Protegidas de la Orinoquía, con documentos y mapas del subsistema. | 2026-06-15 |
| Programa DLS — Unión Europea | https://ue.parquesnacionales.gov.co/ | Portal del programa de Desarrollo Local Sostenible con la Unión Europea. | 2026-11-02 |
| Cooperación internacional | https://www.parquesnacionales.gov.co/cooperacion/ | Oferta y demanda de cooperación, ejes de trabajo, asuntos internacionales y convenios. | 2026-11-02 |

---

## Documentos de referencia

| Nombre | Tipo | URL | Verificado |
|---|---|---|---|
| Planes de manejo por área protegida | PDFs por área, organizados en 6 territoriales. 57 áreas documentadas, publicaciones 2004–2022. | https://www.parquesnacionales.gov.co/entidad/planes-de-manejo-areas-del-spnn/ | 2026-06-15 |
| Publicaciones de ecoturismo | Materiales educativos y de divulgación del programa de ecoturismo. | https://www.parquesnacionales.gov.co/ecoturismo/#publicaciones | 2026-06-15 |

---

## Normativa

| Nombre | Tipo | URL | Verificado |
|---|---|---|---|
| Normograma PNN | Normograma consolidado | https://www.parquesnacionales.gov.co/normativas/ | 2026-06-15 |
| Resoluciones (2021–2025) | Resoluciones | https://www.parquesnacionales.gov.co/normativas/ | 2026-06-15 |
| Decretos (1974–2024) | Decretos | https://www.parquesnacionales.gov.co/normativas/ | 2026-06-15 |

---

## Estadísticas

| Nombre | URL | Frecuencia | Verificado |
|---|---|---|---|
| Estadísticas de visitantes (2010–2025) | https://www.parquesnacionales.gov.co/ecoturismo/#estadisticas_visitantes | Series anuales descargables en Excel/PDF. Ancla en la página de Ecoturismo. | 2026-06-15 |
| Encuestas de satisfacción de visitantes | https://www.parquesnacionales.gov.co/ecoturismo/#encuestas | Reportes anuales y semestrales 2022–2025. | 2026-06-15 |
| Estadísticas RUNAP — áreas protegidas | https://runap.parquesnacionales.gov.co/ | Cifras oficiales de extensión, número de áreas y cobertura nacional. | 2026-06-15 |

---

## Notas por sección

| Sección | Nota |
|---|---|
| `https://runap.parquesnacionales.gov.co` | SPA JavaScript. Estructura verificada con browser: raíz (inicio + estadísticas), `/cifras` (tabla por ámbito/categoría; gráfico por departamento; shapefile descargable), menú `Reportes` abre submenú con `Reportes actuales` → `https://runapadmin.parquesnacionales.gov.co/reportes` y `Reportes históricos` → Google Sites externo. |
| SINAP | Si un enlace apunta a `https://sinap.parquesnacionales.gov.co`, ese dominio no resuelve por DNS; usar la fuente institucional del SINAP (ver su fila) y, para el registro y las cifras oficiales, RUNAP. |
| `herencia-colombia/` | Las rutas anidadas `/herencia-colombia/proyectos/` y `/herencia-colombia/documentos-de-interes/` redirigen a `/proyectos/` (KfW HeCo, Paisajes Sostenibles, GCF HeCo) y `/documentos-de-interes/` (documentos estratégicos, informes anuales, boletines mensuales, infografías) en la raíz del sitio. |
| `ecoturismo/#estadisticas_visitantes` | Las estadísticas de visitantes son anclas en la página de Ecoturismo, no URLs independientes. El archivo histórico antes de 2022 puede estar en `https://old.parquesnacionales.gov.co/portal/es/ecoturismo/`. |
