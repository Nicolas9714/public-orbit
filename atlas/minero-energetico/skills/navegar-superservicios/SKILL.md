---
name: navegar-superservicios
description: "Guía de navegación para Superservicios: información de los prestadores de servicios públicos, tarifas de energía, monitoreo de los mercados de energía y gas, empresas vigiladas por servicio, información financiera, auditoría externa, contribuciones, trámites y normativa."
---

# Superintendencia de Servicios Públicos Domiciliarios (Superservicios)

La Superintendencia de Servicios Públicos Domiciliarios es una entidad de carácter técnico adscrita al Presidente de la República. Ejerce la inspección, vigilancia y control de las empresas que prestan servicios públicos domiciliarios en Colombia: energía eléctrica, gas natural, acueducto, alcantarillado y aseo.

## ¿Qué información publica?

- Información de los prestadores: datos financieros, tarifarios, comerciales, técnicos y de calidad del servicio, reportados por las empresas al SUI (Sistema Único de Información)
- Tarifas de energía eléctrica: información tarifaria por comercializador
- Monitoreo de mercados: conductas y precios en los mercados de energía eléctrica y gas natural, a cargo de la UMMEG (Unidad de Monitoreo de Mercados de Energía y Gas)
- Cobertura: servicios públicos por municipio y empresa prestadora, en el geoportal
- Empresas vigiladas por servicio: energía eléctrica, gas natural, GLP (Gas Licuado de Petróleo), acueducto, alcantarillado y aseo, con reportes del sector por servicio
- Información financiera: marco contable de los prestadores bajo las NIF (Normas de Información Financiera)
- Auditoría externa: proceso de AEGR (Auditoría Externa de Gestión y Resultados) de las empresas vigiladas
- Contribuciones y pagos: liquidación y pago de las contribuciones de vigilancia y control
- Trámites para prestadores: habilitación, certificados y conceptos ante la entidad
- Empresas intervenidas: listado y actos administrativos de intervención
- Normativa: resoluciones y circulares propias y compilación jurídica del sector (Leyes 142 y 143 de 1994)

## Sitio oficial

`https://www.superservicios.gov.co/`

## Cómo usar esta skill

1. Consulta `mapa-web.md` para ubicar el SUI, los informes por sector o la normativa.
2. Consulta `fuentes.md` para acceder directamente al SUI, UMMEG, tarifas o geoportal.

## Notas de navegación

- El SUI (`sui.superservicios.gov.co`) reúne todos los servicios públicos domiciliarios; al consultar, filtrar por sector para limitar los resultados a energía o gas.
- `superservicios.gov.co` está detrás de un WAF (firewall de aplicaciones web) Incapsula que puede responder HTTP 200 con una página de bloqueo («Request unsuccessful»); si ocurre, abrir con navegador con ventana (`--headed`).
- Superservicios regula servicios más allá del energético (agua, aseo); muchas secciones aplican a los seis servicios regulados.
- El geoportal (`geoportal.superservicios.gov.co`) está alojado en ArcGIS Online.
