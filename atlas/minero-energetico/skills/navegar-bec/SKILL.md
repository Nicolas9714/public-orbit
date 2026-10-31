---
name: navegar-bec
description: "Guía de navegación para BEC: información transaccional y operativa del mercado de gas natural colombiano, informes y estadísticas de mercado."
---

# Bolsa Mercantil de Colombia — BEC (Gestor del Mercado de Gas Natural)

La Bolsa Mercantil de Colombia, mediante BEC, es el gestor del mercado de gas natural en Colombia, designado conforme a la regulación de la CREG. Centraliza la información transaccional y operativa del mercado en la plataforma SEGAS (Sistema Electrónico de Gas) y opera sus mecanismos de negociación.

## ¿Qué información publica?

- Mercado primario: suministro, transporte, procesos de comercialización y de concurrencia, oferta remanente, oferta comprometida en firme y energía garantizada
- Mercado secundario: suministro, transporte y procesos de concurrencia, y precios a usuarios no regulados
- Subastas: resultados, cantidades negociadas y ofertas de gas y de capacidad de transporte
- Comercialización de transporte: capacidad disponible, solicitudes de los remitentes, ampliaciones por congestión, asignación de capacidad firme a proyectos y cargos de transporte
- Información operativa: producción, transporte y distribución-comercialización de gas en el sistema nacional de transporte
- Precios: índice iGas-D, que mide el precio diario del mercado secundario
- Indicadores regulatorios del mercado primario y secundario, y auditoría externa e indicadores del gestor
- Informes del mercado: declaraciones de producción, resultados de la comercialización, radiografía y perspectivas del mercado, e informes ejecutivos
- Comité de Mercado de Gas Natural e interrupciones del servicio
- Normativa: resoluciones, contratos marco y boletines del gestor
- Registro ante el gestor: participantes inscritos por categoría, formulario y documentos de registro
- Herramientas de inteligencia de negocio sobre el mercado: tableros, cubos de datos y estado operativo del sistema de transporte

## Sitio oficial

`https://www.bmcbec.com.co/`

## Cómo usar esta skill

1. Consulta `mapa-web.md` para ubicar la sección relevante dentro del sitio.
2. Consulta `fuentes.md` para acceder directamente a sistemas, portales y documentos clave.

## Notas de navegación

- **SEGAS** (`segas.bmcbec.com.co`) es la plataforma transaccional principal; requiere credenciales de participante registrado. El contenido transaccional público está en la sección Información Transaccional del sitio principal.
- **BI Gas** (tableros Power BI y cubos) requiere login. La sección **Contenido Virtual** (`/contenido-virtual`) incluye RUT Gas y los tutoriales, sin necesidad de cuenta.
- Las secciones de **Información Transaccional** e **Información Operativa** muestran sus datos mediante reportes Power BI embebidos (`app.powerbi.com`) que cargan con JavaScript: sin renderizar, la página solo muestra el texto introductorio y «Cargando tablero...». Para acceder a datos crudos estructurados se requiere BI Gas (login) o las descargas de la sección Informes.
- El sitio usa Drupal CMS; muchas URLs aparecen con y sin tilde (`informacion-transaccional` / `informaci%C3%B3n-transaccional`) y son equivalentes; varias redirigen (301) a la forma sin tilde o cambian a `http://`. Algunas sub-páginas usan URLs `node/XXXX`: el árbol de `mapa-web.md` da los nombres semánticos y `fuentes.md` las URLs.
- Las rutas del árbol de `mapa-web.md` para subastas e información operativa son aproximadas: las reales llevan tildes y nombres distintos (por ejemplo `informacion-transaccional/subastas/subasta-de-contratos-firmes-bimestrales`); usa las URLs de `fuentes.md`.
