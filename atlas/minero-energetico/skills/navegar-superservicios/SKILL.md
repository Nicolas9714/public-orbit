---
name: navegar-superservicios
description: "Guía de navegación para Superservicios: información reportada por los prestadores de servicios públicos, cobertura por municipio, observatorio de tarifas, mercados y calidad del servicio, y normativa del sector."
---

# Superintendencia de Servicios Públicos Domiciliarios (Superservicios)

La Superintendencia de Servicios Públicos Domiciliarios es una entidad de carácter técnico adscrita al Presidente de la República. Ejerce la inspección, vigilancia y control de las empresas que prestan servicios públicos domiciliarios en Colombia: energía eléctrica, gas natural, acueducto, alcantarillado y aseo.

## ¿Qué información publica?

- Información de los prestadores: datos financieros, tarifarios, comerciales, técnicos y de calidad del servicio, reportados por las empresas al SUI (Sistema Único de Información)
- Cobertura: servicios públicos e infraestructura de acueducto, energía y gas por municipio, y empresas prestadoras georreferenciadas
- Usuarios: peticiones, quejas y reclamos, y encuestas de satisfacción con la atención y la calidad del servicio
- Tarifas y sostenibilidad financiera: costos, tarifas y suficiencia financiera de las empresas prestadoras
- Estructura de los mercados: estudios de los mercados de energía, gas, acueducto, alcantarillado y aseo, como la formación de precios del gas natural, el gas propano y la transmisión eléctrica
- Transición energética, hídrica y resiliencia climática: efectos de la variabilidad climática en la infraestructura de los servicios públicos
- Prospectiva sectorial: modelos analíticos y alertas tempranas de riesgo en la prestación
- Control social: Escuela de Servicios Públicos, Biblioteca Virtual con estudios técnicos y guías para vocales de control
- Normativa: marco jurídico de la entidad y del sector, con las Leyes 142 y 143 de 1994, la Ley 689 de 2001 y los decretos reglamentarios

## Sitio oficial

`https://www.superservicios.gov.co/`

## Cómo usar esta skill

1. Consulta `mapa-web.md` para ubicar el SUI, los informes por sector o la normativa.
2. Consulta `fuentes.md` para acceder directamente al SUI, el geoportal, el observatorio o la normativa.

## Notas de navegación

- El SUI (`sui.superservicios.gov.co`) reúne todos los servicios públicos domiciliarios; al consultar, filtrar por sector para limitar los resultados a energía o gas.
- `superservicios.gov.co` está detrás de un WAF (firewall de aplicaciones web) Incapsula que responde HTTP 200 con una página de bloqueo («Request unsuccessful») a clientes automatizados; la verificación se hace en un navegador de usuario.
- El sitio se migró en octubre de 2026: las rutas antiguas `/Empresas-vigiladas/...` y las subpáginas de Normativa dan 404, también con el prefijo `/index.php/`. Las rutas vigentes llevan ese prefijo (`/index.php/Normativa`, `/index.php/participa/observatorio`).
- Superservicios regula servicios más allá del energético (agua, aseo); muchas secciones aplican a los seis servicios regulados.
- El geoportal (`geoportal.superservicios.gov.co`) está alojado en ArcGIS Online.
