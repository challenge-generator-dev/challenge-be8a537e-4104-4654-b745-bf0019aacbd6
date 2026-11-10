# Despliegue de la API de la app de pedidos con Terraform

El equipo de desarrollo móvil necesita desplegar la API de la aplicación de pedidos usando Terraform. La API debe ser desplegada en la infraestructura cloud de la empresa, asegurando que los recursos necesarios estén correctamente aprovisionados y configurados. La aplicación móvil consumirá estos recursos para procesar pedidos de los clientes. El dominio es el de una aplicación de pedidos móviles donde los clientes pueden realizar compras. Los actores involucrados son los Clientes, el Servicio de Pedidos y el Almacén de Datos.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el despliegue de la API.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Identificar los recursos necesarios para el despliegue de la API.
- Configurar el archivo principal de Terraform para definir los proveedores y las variables necesarias.

**Entregable:** Archivo de configuración de Terraform con proveedores y variables definidas.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de variables en Terraform para parametrizar el despliegue.
- Configuración de proveedores en Terraform.

</details>

### Fase 2: Aprovisionamiento de recursos

**Objetivo:** Aprovisionar los recursos cloud necesarios para la API.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Definir los recursos cloud (como instancias de compute, bases de datos, redes, etc.) necesarios para la API.
- Configurar las dependencias y relaciones entre los recursos.

**Entregable:** Archivo de Terraform con los recursos cloud aprovisionados y configurados.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de módulos en Terraform para reutilizar configuraciones.
- Manejo de dependencias entre recursos en Terraform.

</details>

### Fase 3: Despliegue y validación

**Objetivo:** Desplegar la API y validar su funcionamiento.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Ejecutar el plan de Terraform para desplegar la API.
- Validar que la API está correctamente desplegada y que los recursos están funcionando como se espera.

**Entregable:** API desplegada y validada, con recursos cloud funcionando correctamente.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de comandos de Terraform para aplicar y validar el despliegue.
- Herramientas de monitoreo y logging para validar el funcionamiento de la API.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y para qué se utiliza en el despliegue de infraestructura?
- **paraQueSirve**: ¿Para qué sirve aprovisionar recursos cloud con Terraform en el contexto de una aplicación de pedidos móvil?
- **comoSeUsa**: ¿Cómo se usa Terraform para definir y desplegar recursos cloud?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar recursos con Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el despliegue de una API con Terraform en términos de recursos y configuración?

## Criterios de Evaluacion

- Configuración correcta del entorno de Terraform con proveedores y variables definidas.
- Aprovisionamiento de recursos cloud necesarios para la API con Terraform.
- Despliegue exitoso y validación del funcionamiento de la API con Terraform.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://${var.api_gateway_id}.execute-api.${var.region}.amazonaws.com):
  - `GET /orders`
  - `POST /orders`
- `client` expone http:

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
