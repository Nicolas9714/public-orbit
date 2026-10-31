---
name: navegar-xm
description: "Guía de navegación para XM: datos operativos y de mercado eléctrico colombiano, hidrología, generación, demanda y cargo por confiabilidad."
---

# XM S.A. E.S.P. — Operador del Sistema y Administrador del Mercado

XM, filial del Grupo ISA, es una empresa de servicios públicos que opera el Sistema Interconectado Nacional (SIN) y actúa como Operador del Sistema de Transmisión Nacional (STN) y Administrador del Sistema de Intercambios Comerciales (ASIC) del mercado eléctrico colombiano. Coordina el despacho de la generación y liquida y administra las transacciones del mercado, por lo que es la fuente primaria de sus datos operativos y comerciales.

## ¿Qué información publica?

- Generación y despacho: generación por planta, agente y recurso, disponibilidad, capacidad efectiva, consumo de combustible, despacho y redespacho, y frecuencia eléctrica del sistema
- Hidrología: embalses, reservas, aportes y vertimientos hídricos
- Demanda: demanda comercial y del SIN, por región y por actividad económica, pronóstico oficial de demanda y usuarios no regulados
- Transmisión: redes del SIN, STN y sistemas de transmisión regional
- Eventos operativos y parámetros técnicos: registro de eventos del sistema y parámetros técnicos del SIN
- Precios y liquidación: precios de bolsa, de oferta y de escasez, montos liquidados, liquidación y facturación del mercado, consultables en SINERGOX y en SIMEM (Sistema de Información del Mercado Eléctrico Mayorista)
- Intercambios internacionales: importaciones, exportaciones, transacciones y rentas de congestión, y estudios de interconexión con Ecuador
- Restricciones: generación de seguridad, reconciliaciones y costo de las restricciones
- Cargo por confiabilidad: energía firme, obligaciones de energía, subastas de energía firme y de reconfiguración, y mercado secundario
- Contratación del mercado: contratos bilaterales y de largo plazo del mercado regulado y no regulado, precios y cobertura de la demanda
- Registros y administración financiera: agentes, fronteras comerciales y medidas, garantías, gestión de riesgo y limitación de suministro
- Planeación operativa: análisis energéticos de largo, mediano y corto plazo, estudios de flexibilidad, restricciones y mantenimientos, e IPOEMP (Informe de Planeamiento Operativo Eléctrico de Mediano Plazo)
- Informes de la operación y el mercado: boletín energético, análisis mensual del mercado, situación energética actual, informe anual de operación del SIN y administración del mercado, y mapa de ruta de la transición energética
- Normativa de mercado y operación: resoluciones aplicables al mercado, la medida y las condiciones del sistema

## Sitio oficial

`https://www.xm.com.co/`

## Cómo usar esta skill

1. Consulta `mapa-web.md` para ubicar la variable operativa, informe o sección del mercado que necesitas.
2. Consulta `fuentes.md` para acceder directamente a la API SiNERGOX, SIMEM, informes o bases de datos de planeación.

## Notas de navegación

- La API pública (`servapibi.xm.com.co`) no requiere autenticación y es el acceso recomendado para extraer series históricas de manera programática. La librería `pydataxm` facilita su uso desde Python.
- El portal SINERGOX es para agentes registrados del mercado y requiere autenticación; no confundir con la API pública.
- El SIMEM (`simem.co`) es el portal de datos abiertos del mercado; tiene su propia API documentada en la sección de catálogo de datos.
- Las bases de datos descargables de planeación (MPODE, IPOEL, AEMP) están en `planeación/`, separadas de los resultados de estudios que están en `operación/planeación/`.
