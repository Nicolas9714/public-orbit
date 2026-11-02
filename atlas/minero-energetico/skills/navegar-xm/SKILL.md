---
name: navegar-xm
description: "Guía de navegación para XM: datos operativos y de mercado eléctrico colombiano, hidrología, generación, demanda y cargo por confiabilidad."
---

# XM S.A. E.S.P. — Operador del Sistema y Administrador del Mercado

XM, filial del Grupo ISA, es una empresa de servicios públicos mixta que opera el Sistema Interconectado Nacional (SIN) y administra el Mercado de Energía Mayorista. Presta los servicios de Centro Nacional de Despacho (CND), Administrador del Sistema de Intercambios Comerciales (ASIC) y Liquidador y Administrador de Cuentas (LAC), por lo que es la fuente primaria de los datos operativos y comerciales del mercado.

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
- Planeación operativa: análisis energéticos de largo, mediano y corto plazo, estudios de flexibilidad y de restricciones, e IPOEMP (Informe de Planeamiento Operativo Eléctrico de Mediano Plazo)
- Informes de la operación y el mercado: boletín energético, análisis mensual del mercado, situación energética actual, informe anual de operación del SIN y administración del mercado, y mapa de ruta de la transición energética
- Normativa de mercado y operación: resoluciones aplicables al mercado, la medida y las condiciones del sistema

## Sitio oficial

`https://www.xm.com.co/`

## Cómo usar esta skill

1. Consulta `mapa-web.md` para ubicar la variable operativa, informe o sección del mercado que necesitas.
2. Consulta `fuentes.md` para acceder directamente a la API SiNERGOX, SIMEM, informes o bases de datos de planeación.

## Notas de navegación

- Si una ruta con tilde (`planeación`, `operación`) responde 404 al pedirla con caracteres crudos desde `curl`, usar la ruta codificada (`planeaci%C3%B3n`) o navegar desde los menús.
