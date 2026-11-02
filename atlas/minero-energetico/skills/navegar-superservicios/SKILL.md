---
name: navegar-superservicios
description: "Guía de navegación para Superservicios: información reportada por los prestadores de servicios públicos, empresas vigiladas e intervenidas, cobertura por municipio, observatorio de tarifas y mercados, contribuciones, normativa y datos abiertos."
---

# Superintendencia de Servicios Públicos Domiciliarios (Superservicios)

La Superintendencia de Servicios Públicos Domiciliarios es una entidad descentralizada de carácter técnico, adscrita al Departamento Nacional de Planeación. Ejerce la inspección, vigilancia y control de las empresas que prestan servicios públicos domiciliarios en Colombia: energía eléctrica, gas natural, acueducto, alcantarillado y aseo.

## ¿Qué información publica?

- Información de los prestadores: datos financieros, tarifarios, comerciales, técnicos y de calidad del servicio, reportados por las empresas al SUI (Sistema Único de Información)
- Cobertura: servicios públicos e infraestructura de acueducto, energía y gas por municipio, y empresas prestadoras georreferenciadas
- Empresas vigiladas por servicio: energía eléctrica, gas natural, GLP (Gas Licuado de Petróleo), acueducto y alcantarillado, aseo (incluida la actividad de aprovechamiento) y pequeños prestadores
- Supervisión de los prestadores: empresas intervenidas, gestión de riesgos en la prestación, información financiera bajo las NIF (Normas de Información Financiera) y auditoría externa de gestión y resultados
- Trámites para prestadores, y contribuciones y pagos de vigilancia y control
- Usuarios: peticiones, quejas y reclamos, y encuestas de satisfacción con la atención y la calidad del servicio
- Tarifas de energía eléctrica por comercializador
- Monitoreo de mercados: conductas y formación de precios en los mercados de energía eléctrica y gas natural, a cargo de la UMMEG (Unidad de Monitoreo de Mercados de Energía y Gas)
- Tarifas y sostenibilidad financiera: costos, tarifas y suficiencia financiera de las empresas prestadoras
- Estructura de los mercados: estudios de los mercados de energía, gas, acueducto, alcantarillado y aseo, como la formación de precios del gas natural, el gas propano y la transmisión eléctrica
- Transición energética, hídrica y resiliencia climática: efectos de la variabilidad climática en la infraestructura de los servicios públicos
- Prospectiva sectorial: modelos analíticos y alertas tempranas de riesgo en la prestación
- Control social: Escuela de Servicios Públicos, Biblioteca Virtual con estudios técnicos y guías para vocales de control
- Normativa: resoluciones y circulares de la Superintendencia, y compilación jurídica del sector, con las Leyes 142 y 143 de 1994, la Ley 689 de 2001 y los decretos reglamentarios
- Datos abiertos de la Superintendencia

## Sitio oficial

`https://www.superservicios.gov.co/`

## Cómo usar esta skill

1. Consulta `mapa-web.md` para ubicar el SUI, los informes por sector o la normativa.
2. Consulta `fuentes.md` para acceder directamente al SUI, el geoportal, el observatorio o la normativa.

## Notas de navegación

- El SUI (`sui.superservicios.gov.co`) reúne todos los servicios públicos domiciliarios; al consultar, filtrar por sector para limitar los resultados a energía o gas.
- `superservicios.gov.co` está detrás de un WAF (firewall de aplicaciones web) Incapsula que responde HTTP 200 con una página de bloqueo («Request unsuccessful») a clientes sin navegador (curl, lectores de páginas); en un navegador con ventana carga con normalidad (verificado el 2026-10-31).
- El sitio se reorganizó en octubre de 2026 y algunas rutas responden 404 de forma intermitente; reintentar antes de darlas por caídas. Algunas rutas vigentes llevan el prefijo `/index.php/` (`/index.php/Normativa`, `/index.php/participa/observatorio`). El mapa del sitio está en `superservicios.gov.co/sitemap`.
- La Superintendencia vigila servicios más allá del energético (acueducto, alcantarillado, aseo); muchas secciones del sitio los cubren todos.
- El geoportal (`geoportal.superservicios.gov.co`) está alojado en ArcGIS Online.
