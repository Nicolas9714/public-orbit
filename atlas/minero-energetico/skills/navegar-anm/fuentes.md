# Fuentes — ANM

---

## Sistemas de información y plataformas

| Nombre | URL | Descripción | Verificado |
|---|---|---|---|
| AnnA Minería (SIGM) | `annamineria.anm.gov.co/sigm/externalLogin` | Sistema de Información de Gestión Minera; gestión de contratos de concesión, solicitudes, obligaciones de producción y regalías; requiere registro de usuario | 2026-05-30 |
| Génesis | `tramites.anm.gov.co/Portal/pages/inicio.jsf` | Plataforma anterior de trámites mineros; mantiene consulta pública de títulos y solicitudes históricas | 2026-05-30 |

---

## Geovisores y mapas

| Nombre | URL | Capas principales | Verificado |
|---|---|---|---|
| Visor geográfico público SIGMExt | `annamineria.anm.gov.co/Html5Viewer/index.html?viewer=SIGMExt&locale=es-CO&appAcronym=sigm` | Geocortex Viewer for HTML5; acceso público sin login; capas: títulos mineros, solicitudes, áreas excluibles | 2026-06-16 |
| Visor geográfico AnnA Minería (SIGM) | Integrado en `annamineria.anm.gov.co/sigm/` | Cuadrícula Minera, estado de celdas (libre / titulada / en proceso), áreas de reserva especial, zonas excluidas; requiere registro | 2026-05-30 |
| Cuadrícula Minera descargable | `anm.gov.co/anna-mineria` | Descarga de la Celda Minera en gpkg, GDB (Geodatabase) y JSON según la página (enlace directo a CELDA_GDB_Anna.zip); niveles: Zona UTM, Sector, Sección, Bloque, Conjunto, Grupo, Celda | 2026-05-30 |
| Gestor de metadatos ANM | `anm.gov.co/informacion-geografica` | Modelo de Datos Geográficos ANM v2; metadatos de capas geoespaciales institucionales | 2026-05-30 |

---

## Portales de datos

| Nombre | URL | Descripción | Verificado |
|---|---|---|---|
| Selección de datos abiertos ANM | `anm.gov.co/seleccion-de-datos-abiertos` | Datasets institucionales: producción trimestral de minerales y contraprestaciones, RUCOM plantas de beneficio certificadas, contratos suscritos, plan de adquisiciones | 2026-05-30 |
| Información del sector y estadísticas | `anm.gov.co/informacion-del-sector-y-estadisticas` | Catálogo paginado (36 páginas) de informes, boletines y estadísticas del sector minero | 2026-05-30 |
| Indicadores socioeconómicos (Power BI) | `anm.gov.co/indicadores-socioeconomicos` | Tablero Power BI con 12 páginas: IED, PIB minero, empleo, exportaciones mineras y precios internacionales de minerales; boletín mensual "Minería en cifras" (ANM + UPME) | 2026-06-16 |

---

## Publicaciones periódicas

| Nombre | Frecuencia | URL o ruta en el sitio | Verificado |
|---|---|---|---|
| Producción Nacional de Minerales y Contraprestaciones Económicas | Trimestral | `seleccion-de-datos-abiertos` (dataset) | 2026-05-30 |
| Informe de gestión ANM | Anual | `planeacion-presupuesto-e-informes` → informe-de-gestion | 2026-05-30 |
| Informe enviado al Congreso | Anual | `planeacion-presupuesto-e-informes` → informe-enviado-al-congreso | 2026-05-30 |

---

## Documentos de referencia

| Nombre | Tipo | URL o ruta | Verificado |
|---|---|---|---|
| Normograma de la ANM | Marco normativo consolidado | `normograma-de-la-agencia-nacional-de-mineria` | 2026-05-30 |
| Código de Minas (Ley 685 de 2001) | Ley | `leyes` | 2026-05-30 |
| Resolución 504 de 2018 | Reglamento de Cuadrícula Minera | `anm.gov.co/504-del-18-de-septiembre-2018` | 2026-05-30 |
| Modelo de Datos Geográficos ANM v2 | Estándar geoespacial | Descarga GDB desde `informacion-geografica` | 2026-05-30 |
| Inventario de trámites mineros | Catálogo de trámites | `inventario-de-tramites-mineros` | 2026-05-30 |
| Cierres administrativos de contratos de concesión | Listado mensual de actos de cierre (PDF por acto, con número de cierre y expediente; 2025 y 2026) | `anm.gov.co/atencion-y-servicio-la-ciudadania/cierres-administrativos-contratos-de-concesion` | 2026-10-31 |
| Vicepresidencia de Seguimiento, Control y Seguridad Minera | Ficha institucional: fiscalización de obligaciones de los títulos, seguridad y salvamento minero, regalías | `anm.gov.co/vicepresidencia-de-seguimiento-control-y-seguridad-minera` | 2026-10-31 |

---

## Servicios y trámites

| Nombre | URL | Descripción | Verificado |
|---|---|---|---|
| Presentación de solicitudes en AnnA Minería | `anm.gov.co/atencion-y-servicio-la-ciudadania/oferta-institucional/anna-mineria/presentacion-de-solicitudes` | Punto de partida para presentar solicitudes mineras: adquirir PIN, plano PCC e instructivos de selección de áreas de reserva especial | 2026-10-31 |
| Radicar solicitud de contrato de concesión | `anm.gov.co/radicar-solicitud-de-contrato-de-concesion` | Ruta para radicar la solicitud de contrato de concesión | 2026-10-31 |
| Radicar solicitud de autorización temporal | `anm.gov.co/radicar-solicitud-de-autorizacion-temporal` | Ruta para radicar la solicitud de autorización temporal | 2026-10-31 |
| Radicar solicitud de área de reserva especial | `anm.gov.co/radicar-solicitud-de-area-de-reserva-especial` | Ruta para radicar la solicitud de área de reserva especial | 2026-10-31 |
| Ingreso al programa de asistencia técnica VETA | `anm.gov.co/solicitud-de-ingreso-al-programa-asistencia-tecnica-veta` | Ruta para solicitar el ingreso al programa de asistencia técnica VETA (formalización minera) | 2026-10-31 |

---

## Notas por sección

| Sección | Nota |
|---|---|
| `mineria-en-colombia/` | Mapa de sitio propio en `anm.gov.co/mapa-sitio-mineria-en-colombia` |
| `colombia-ejemplo-de-transformacion-minera-mapa-geovisor/` | Embebe por iframe el visor SIGMExt de la tabla de geovisores; incluye instrucciones de uso y contacto de soporte (`contactenosANNA@anm.gov.co`) |
| `visor-geografico` en AnnA | La guía de uso es «Manejo de herramientas visor geográfico 3.0» |
| `seleccion-de-datos-abiertos` | Los datasets están enlazados a datos.gov.co |
| `normograma-de-la-agencia-nacional-de-mineria` | Organizado por etapa del ciclo del proyecto minero, no cronológicamente; buscar por fase |
