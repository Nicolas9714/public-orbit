# Consultas de ejemplo

Consultas de demostración: cada una es un prompt que puedes hacerle al agente con las skills del Atlas instaladas, junto con la ruta que debería responderte. Sirven como vitrina de lo que resuelve el Atlas y como referencia para validar que las skills funcionan. Las URLs exactas de cada sistema viven en `fuentes.md` de la skill correspondiente. Las consultas que cruzan hacia otros atlas viven en las [consultas de Public Orbit](../../../examples/consultas-de-ejemplo.md).

---

**«¿Qué localidades del Chocó están en la ZNI, cuántas horas de servicio reciben hoy y qué proyectos de energización están en curso?»**

Ruta esperada: IPSE (Centro Nacional de Monitoreo: telemetría del servicio; SIGIPSE: proyectos) → UPME (cobertura eléctrica y plan PERS).

---

**«Preparo el informe anual del sector energético: necesito el balance energético, la generación y la demanda eléctrica por fuente y los precios del mercado.»**

Ruta esperada: UPME (BECO y tableros de indicadores) → XM (SIMEM: series de generación, demanda y precios).

---

**«Evalúo invertir en transmisión eléctrica: ¿qué convocatorias están abiertas, qué precios dejaron las subastas recientes y bajo qué reglas se remunera un proyecto?»**

Ruta esperada: UPME (convocatorias de transmisión y subastas) → CREG (resoluciones y contratos de conexión) → XM (resultados de subastas y operación).

---

**«¿Cuánto gas natural produjeron los campos de Cusiana-Cupiagua el último año, a qué precios se transa el gas mayorista y quién regula el transporte?»**

Ruta esperada: ANH (Sistemas Integrados de Operaciones: producción por campo) → BEC (SEGAS e iGas-D: precios y subastas del mercado) → CREG (metodologías tarifarias de transporte y distribución).

---

**«¿Por qué subió la tarifa de energía en la costa Caribe: qué fórmula aplica, qué cobra cada comercializadora y cuánto pesa el precio de bolsa?»**

Ruta esperada: CREG (Gestor Normativo: fórmula tarifaria y componentes) → Superservicios (SUI: tarifas aplicadas por empresa) → XM (SINERGOX o API: serie del precio de bolsa).
