# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/database/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/networking/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

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

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `client/lib/data/datasources/remote/order_remote_data_source.dart` — `DioClient.get`: Se invoca `get` sobre `DioClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/remote/order_remote_data_source.dart` — `DioClient.post`: Se invoca `post` sobre `DioClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/remote/order_remote_data_source.dart` — `DioClient.put`: Se invoca `put` sobre `DioClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261110115758191), Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el despliegue de la API. — entregable (NO resolver): Archivo de configuración de Terraform con proveedores y variables definidas.
- Fase 2: Aprovisionamiento de recursos — objetivo: Aprovisionar los recursos cloud necesarios para la API. — entregable (NO resolver): Archivo de Terraform con los recursos cloud aprovisionados y configurados.
- Fase 3: Despliegue y validación — objetivo: Desplegar la API y validar su funcionamiento. — entregable (NO resolver): API desplegada y validada, con recursos cloud funcionando correctamente.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "aws" {
  region = var.region
}

# Provider para generar nombres aleatorios
provider "random" {}

# Provider para manejar archivos locales
provider "local" {}

// === ARCHIVO: infra/variables.tf ===
# Variables globales para parametrizar el despliegue
# Estas variables permiten configurar el entorno de forma externa mediante terraform.tfvars

variable "region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "api_gateway_id" {
  description = "ID del API Gateway que expone los endpoints"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN de la función Lambda que procesa los pedidos para el endpoint GET /orders"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda para la integración con API Gateway"
  type        = string
}

variable "vpc_endpoint_ids" {
  description = "IDs de los endpoints de VPC para acceso privado a servicios AWS"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceder a la API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

// === ARCHIVO: infra/modules/api/variables.tf ===
# Variables específicas del módulo de API

variable "api_name" {
  description = "Nombre de la API Gateway"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN de la función Lambda que procesa los pedidos"
  type        = string
}

variable "lambda_invoke_arn" {
  description = "ARN de invocación de la función Lambda"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "vpc_endpoint_ids" {
  description = "IDs de los VPC endpoints para acceso privado a la API"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "Bloques CIDR permitidos para acceder a la API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# SUPERFICIE DE PRACTICA - A completar por el estudiante
# Agregar variables para configurar los endpoints GET /orders y POST /orders

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Valores de variables para el entorno de desarrollo
# Estas variables se utilizan para parametrizar los recursos de infraestructura

# Región de AWS donde se desplegarán los recursos
region = "us-east-1"

# Nombre del entorno para identificar recursos
environment = "dev"

# ID del API Gateway que expone la API de pedidos
# Este valor debe coincidir con el recurso creado en modules/api
api_gateway_id = "dev-api-gateway-12345"

# Configuración del módulo de API
api_name = "pedidos-api-dev"

# ARN de la función Lambda que procesa los pedidos
# Formato: arn:aws:lambda:REGION:ACCOUNT_ID:function:FUNCTION_NAME
lambda_function_arn = "arn:aws:lambda:us-east-1:123456789012:function:pedidos-processor-dev"

# ARN de invocación de la función Lambda
# Este ARN se utiliza para configurar el integración con API Gateway
lambda_invoke_arn = "arn:aws:lambda:us-east-1:123456789012:function:pedidos-processor-dev:${LATEST}"

# Configuración adicional de red para el entorno development
vpc_cidr = "10.0.0.0/16"

# Configuración de la base de datos
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "pedidos_dev_db"

# Configuración de seguridad
enable_deletion_protection = false

# Configuración de red para endpoints de VPC
vpc_endpoint_ids = []

# Configuración de acceso a la API
allowed_cidr_blocks = ["0.0.0.0/0"]

# Tags para identificar recursos en AWS
common_tags = {
  Environment = "dev"
  Project     = "pedidos-app"
  ManagedBy   = "terraform"
  CostCenter  = "mobile-backend"
}

// === ARCHIVO: infra/environments/dev.tfvars ===
# Archivo de variables para el entorno de desarrollo
# Este archivo complementa la configuración base de Terraform
# Proporciona los valores específicos necesarios para el despliegue en dev

# Configuración principal del entorno
region         = "us-east-1"
environment    = "dev"
api_gateway_id = "dev-api-gateway-12345"

# Parámetros del módulo de API
api_name            = "pedidos-api-dev"
lambda_function_arn = "arn:aws:lambda:us-east-1:123456789012:function:pedidos-processor-dev"
lambda_invoke_arn   = "arn:aws:lambda:us-east-1:123456789012:function:pedidos-processor-dev:${LATEST}"

# Configuración de red
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = ["10.0.10.0/24", "10.0.11.0/24"]

# Configuración de base de datos
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_name              = "pedidos_dev_db"
db_username          = "devadmin"

# Configuración de seguridad
enable_deletion_protection = false
enable_encryption          = true

# Configuración de la API de pedidos
orders_api_base_path = "/orders"
orders_api_stage     = "dev"
orders_api_timeout   = 30

# Configuración de Lambda
lambda_runtime     = "python3.11"
lambda_memory_size = 256
lambda_timeout     = 30
lambda_handler     = "app.handler"

# Configuración de caché
enable_api_cache  = true
cache_ttl_seconds = 300

# Configuración de logs
enable_access_logs = true
log_retention_days = 7

# Configuración de red para endpoints de VPC
vpc_endpoint_ids = []

# Configuración de acceso a la API
allowed_cidr_blocks = ["0.0.0.0/0"]

# Etiquetas uniformes para todos los recursos
tags = {
  Environment = "dev"
  Project     = "pedidos-app"
  ManagedBy   = "terraform"
  CostCenter  = "mobile-backend"
  Team        = "backend-team"
  Version     = "1.0.0"
}

// === ARCHIVO: infra/modules/api/main.tf ===
# Módulo de API Gateway y recursos relacionados
# Superficie de práctica - El estudiante implementará la lógica completa

# API Gateway REST API
resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = "API para la aplicación de pedidos móviles"
}

# Recurso raíz de la API
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "orders"
}

# Método GET para obtener pedidos
resource "aws_api_gateway_method" "get_orders" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "GET"
  authorization = "NONE"
}

# Método POST para crear pedidos
resource "aws_api_gateway_method" "create_order" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integración con Lambda
resource "aws_api_gateway_integration" "lambda_get" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_method.get_orders.resource_id
  http_method = aws_api_gateway_method.get_orders.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_integration" "lambda_post" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_method.create_order.resource_id
  http_method = aws_api_gateway_method.create_order.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# Deployment de la API
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  depends_on = [
    aws_api_gateway_integration.lambda_get,
    aws_api_gateway_integration.lambda_post
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Stage de producción
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "prod"
}

// === ARCHIVO: infra/modules/database/main.tf ===
# Módulo de base de datos - DynamoDB para el servicio de pedidos
# Superficie de práctica - El estudiante implementará la lógica completa

# Tabla de pedidos en DynamoDB
resource "aws_dynamodb_table" "orders" {
  name         = "orders-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "order_id"
  range_key    = "customer_id"

  attribute {
    name = "order_id"
    type = "S"
  }

  attribute {
    name = "customer_id"
    type = "S"
  }

  attribute {
    name = "status"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  global_secondary_index {
    name            = "status_index"
    hash_key        = "status"
    range_key       = "created_at"
    projection_type = "ALL"
  }

  ttl {
    attribute_name = "expires_at"
    enabled        = true
  }

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

// === ARCHIVO: infra/modules/networking/main.tf ===
# Módulo de networking - VPC, subredes y security groups
# Superficie de práctica - El estudiante implementará la lógica completa

# VPC principal
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "pedidos-vpc-${var.environment}"
    Environment = var.environment
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "pedidos-igw-${var.environment}"
    Environment = var.environment
  }
}

# Subredes públicas
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "pedidos-public-subnet-1-${var.environment}"
    Environment = var.environment
    Type        = "public"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "pedidos-public-subnet-2-${var.environment}"
    Environment = var.environment
    Type        = "public"
  }
}

# Subredes privadas
resource "aws_subnet" "private_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_1
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "pedidos-private-subnet-1-${var.environment}"
    Environment = var.environment
    Type        = "private"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_2
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "pedidos-private-subnet-2-${var.environment}"
    Environment = var.environment
    Type        = "private"
  }
}

# Tabla de rutas pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "pedidos-public-rt-${var.environment}"
    Environment = var.environment
  }
}

# Asociación de subredes públicas a tabla de rutas
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# Security Group para API
resource "aws_security_group" "api" {
  name        = "pedidos-api-sg-${var.environment}"
  description = "Security group para la API de pedidos"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS desde anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP desde anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "pedidos-api-sg-${var.environment}"
    Environment = var.environment
  }
}

# Security Group para base de datos
resource "aws_security_group" "database" {
  name        = "pedidos-db-sg-${var.environment}"
  description = "Security group para la base de datos de pedidos"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL desde API"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.api.id]
  }

  egress {
    description = "Salida a internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "pedidos-db-sg-${var.environment}"
    Environment = var.environment
  }
}

// === ARCHIVO: infra/README.md ===
# Infraestructura API de Pedidos - Terraform

Este proyecto contiene la configuración de infraestructura como código (IaC) para desplegar la API de la aplicación móvil de pedidos en AWS. La API permite a los clientes realizar y gestionar sus pedidos a través de endpoints RESTful.

## Descripción del Dominio

La aplicación de pedidos móviles permite a los clientes crear y consultar pedidos. El backend se despliega en AWS utilizando API Gateway para exponer los endpoints HTTP y Lambda para procesar las solicitudes. La infraestructura se gestiona completamente con Terraform, siguiendo las mejores prácticas de IaC con módulos reutilizables.

## Requisitos Previos

Para trabajar con este proyecto necesitas:

- **Terraform 1.9.0** o superior instalado en tu máquina local
- **AWS CLI** configurado con credenciales válidas y permisos para crear recursos
- **Acceso a una cuenta de AWS** con los permisos necesarios para los servicios utilizados
- **git** para clonar el repositorio (opcional)

### Instalación de Terraform

En macOS con Homebrew:
```bash
brew install terraform
```

En Ubuntu/Debian:
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

En Windows:
Descargar el binario desde https://www.terraform.io/downloads

### Configuración de AWS CLI

Ejecuta `aws configure` y proporciona tus credenciales de AWS:
```bash
aws configure
AWS Access Key ID [None]: YOUR_ACCESS_KEY
AWS Secret Access Key [None]: YOUR_SECRET_KEY
Default region name [None]: us-east-1
Default output format [None]: json
```

Alternativamente, puedes configurar variables de entorno:
```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_REGION="us-east-1"
```

## Estructura del Proyecto

```
.
├── main.tf                 # Orquestación principal que invoca los módulos
├── versions.tf             # Versiones de Terraform y proveedores
├── providers.tf            # Configuración de proveedores AWS, random, local
├── variables.tf            # Variables globales del proyecto
├── outputs.tf              # Outputs globales del proyecto
├── README.md               # Este archivo
├── modules/
│   ├── api/                # Módulo de API Gateway y Lambda
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── database/           # Módulo de base de datos
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── networking/         # Módulo de configuración de red
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    └── dev/
        ├── dev.tfvars      # Variables para entorno de desarrollo
        └── terraform.tfvars
```

### Módulos Disponibles

- **modules/api**: Aprovisiona API Gateway y Lambda para ejecutar la lógica de negocio de pedidos
- **modules/database**: Gestiona la capa de persistencia de datos
- **modules/networking**: Configura la infraestructura de red necesaria

## Comandos para Desplegar y Validar

### Inicialización del Proyecto

El comando `terraform init` descarga los proveedores y módulos necesarios:

```bash
terraform init
```

Este comando:
- Inicializa el backend de estado
- Descarga el proveedor de AWS
- Descarga los módulos referenciados
- Crea el directorio `.terraform` con la configuración cacheada

### Validación de la Configuración

El comando `terraform validate` verifica que la configuración sea sintácticamente correcta:

```bash
terraform validate
```

Este comando:
- Verifica la sintaxis de todos los archivos .tf
- Confirma que los proveedores están inicializados
- Valida referencias entre recursos
- Retorna 0 si todo está correcto, o muestra errores si hay problemas

### Planificación de Cambios

El comando `terraform plan` muestra los cambios que se aplicarán sin ejecutarlos:

```bash
terraform plan -var-file=environments/dev/dev.tfvars
```

Este comando:
- Compara el estado actual con la configuración deseada
- Muestra los recursos que se crearán, modificarán o eliminarán
- Estima los costos de AWS (si el proveedor lo soporta)
- Es útil para revisar cambios antes de aplicarlos

Para guardar el plan en un archivo:

```bash
terraform plan -var-file=environments/dev/dev.tfvars -out=plan.tfplan
```

### Aplicación de Cambios

El comando `terraform apply` despliega la infraestructura:

```bash
terraform apply -var-file=environments/dev/dev.tfvars
```

Para aplicar un plan guardado previamente:

```bash
terraform apply plan.tfplan
```

Durante la ejecución:
- Terraform muestra el plan de ejecución
- Pide confirmación con "yes" para proceder
- Crea los recursos en orden dependencias
- Muestra los outputs definidos al final

Para aplicar sin pedir confirmación (usar con precaución):

```bash
terraform apply -var-file=environments/dev/dev.tfvars -auto-approve
```

### Destrucción de Recursos

El comando `terraform destroy` elimina todos los recursos aprovisionados:

```bash
terraform destroy -var-file=environments/dev/dev.tfvars
```

Para destruir sin pedir confirmación:

```bash
terraform destroy -var-file=environments/dev/dev.tfvars -auto-approve
```

**Advertencia**: Este comando eliminará todos los recursos de AWS creados por este proyecto. Asegúrate de que no necesitas los datos o recursos antes de ejecutar.

### Estado y Gestión

Ver el estado actual de los recursos:

```bash
terraform show
```

Listar recursos gestionados:

```bash
terraform state list
```

Refrescar el estado desde AWS:

```bash
terraform refresh -var-file=environments/dev/dev.tfvars
```

## Variables de Configuración

### Variables Globales (variables.tf)

| Variable | Tipo | Default | Descripción |
|----------|------|---------|-------------|
| region | string | - | Región de AWS donde se desplegará la infraestructura |
| environment | string | "dev" | Entorno de despliegue (dev, staging, prod) |
| api_gateway_id | string | - | ID del API Gateway existente (para integración) |

### Variables del Módulo API (modules/api/variables.tf)

| Variable | Tipo | Descripción |
|----------|------|-------------|
| api_name | string | Nombre del API Gateway |
| lambda_function_arn | string | ARN de la función Lambda a integrar |
| lambda_invoke_arn | string | ARN de invocación de la Lambda |

### Archivo de Variables de Entorno

El archivo `environments/dev/dev.tfvars` contiene la configuración específica para el entorno de desarrollo:

```hcl
region      = "us-east-1"
environment = "dev"
```

## Outputs Disponibles

Después de aplicar la configuración, Terraform muestra los siguientes outputs:

- **api_endpoint**: URL base del API Gateway desplegado
- **lambda_function_name**: Nombre de la función Lambda
- **api_id**: ID del API Gateway
- **api_execution_arn**: ARN de ejecución del API Gateway

Puedes ver los outputs en cualquier momento con:

```bash
terraform output
```

## Endpoints de la API

Una vez desplegada la infraestructura, la API expone los siguientes endpoints:

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | /orders | Lista todos los pedidos existentes |
| POST | /orders | Crea un nuevo pedido con los datos proporcionados |

La URL base de la API sigue el formato:
```
https://${api_gateway_id}.execute-api.${region}.amazonaws.com
```

### Ejemplo de Uso

Listar pedidos:
```bash
curl https://YOUR_API_ID.execute-api.us-east-1.amazonaws.com/orders
```

Crear un pedido:
```bash
curl -X POST https://YOUR_API_ID.execute-api.us-east-1.amazonaws.com/orders \
  -H "Content-Type: application/json" \
  -d '{"customer_id": "123", "items": [{"product_id": "456", "quantity": 2}]}'
```

## Mejores Prácticas

### Control de Versiones

- El archivo `.gitignore` debe incluir:
  - `.terraform/`
  - `*.tfstate`
  - `*.tfstate.backup`
  - `plan.tfplan`

- El estado de Terraform debe almacenarse en un backend remoto (S3 con DynamoDB para locking)

### Seguridad

- No commits de archivos con credenciales
- Usar variables de entorno o AWS Secrets Manager para datos sensibles
- Configurar políticas de IAM con mínimo privilegio necesario
- Habilitar cifrado en reposo para todos los recursos que lo soporten
- Usar HTTPS para todas las comunicaciones

### Flujo de Trabajo en Equipo

1. Cada desarrollador trabaja en su rama
2. Se ejecuta `terraform plan` para revisar cambios
3. Se hace pull request con el plan como comentario
4. Después de merger, se ejecuta `terraform apply` en CI/CD

## Solución de Problemas

### Error: Provider not initialized

Ejecutar `terraform init` primero para descargar los proveedores.

### Error: Invalid credentials

Verificar que las credenciales de AWS estén correctamente configuradas con `aws configure` o variables de entorno.

### Error: Resource already exists

Puede ser que los recursos ya fueron creados. Ejecutar `terraform import` para importar recursos existentes o `terraform destroy` para limpiar y recrear.

### Error: Circular dependency

Revisar las dependencias entre recursos en los archivos .tf y asegurar que no hay referencias circulares.

## Licencia

Este proyecto es parte del dominio de la aplicación de pedidos móviles y está destinado para uso interno de la empresa.

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0"
  # TODO(reto): Definir restricciones de versión de providers
  #hint: Los providers de AWS y otros servicios deben tener versiones compatibles con Terraform 1.9+
}

// === ARCHIVO: infra/main.tf ===
# Módulo de Networking: VPC, subnets, gateways, security groups
module "networking" {
  source = "./modules/networking"

  environment      = var.environment
  vpc_cidr         = "10.0.0.0/16"
  region           = var.region
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
}

# Módulo de Base de Datos: DynamoDB para pedidos
module "database" {
  source = "./modules/database"

  environment = var.environment
}

# Módulo de API: API Gateway con integración a Lambda
module "api" {
  source = "./modules/api"

  api_name            = "pedidos-api"
  environment         = var.environment
  lambda_function_arn = var.lambda_function_arn
  lambda_invoke_arn   = var.lambda_invoke_arn

  vpc_endpoint_ids = module.networking.vpc_endpoint_ids

  allowed_cidr_blocks = ["0.0.0.0/0"]
}

// === ARCHIVO: infra/outputs.tf ===
// URL base de la API Gateway para consumo desde la app móvil
output "api_gateway_url" {
  description = "URL base del API Gateway para acceder a los endpoints de pedidos"
  value       = "https://${var.api_gateway_id}.execute-api.${var.region}.amazonaws.com"
}

// URL completa del stage de producción
output "api_gateway_prod_url" {
  description = "URL completa del stage de producción del API Gateway"
  value       = "https://${var.api_gateway_id}.execute-api.${var.region}.amazonaws.com/prod"
}

// Endpoint específico para obtener pedidos
output "get_orders_endpoint" {
  description = "Endpoint GET para obtener la lista de pedidos"
  value       = "https://${var.api_gateway_id}.execute-api.${var.region}.amazonaws.com/prod/orders"
}

// Endpoint específico para crear pedidos
output "create_order_endpoint" {
  description = "Endpoint POST para crear un nuevo pedido"
  value       = "https://${var.api_gateway_id}.execute-api.${var.region}.amazonaws.com/prod/orders"
}

// ARN del API Gateway para permisos de Lambda
output "api_gateway_arn" {
  description = "ARN del API Gateway para configurar permisos de invoke"
  value       = "arn:aws:apigateway:${var.region}::restapis/${var.api_gateway_id}"
}

// ARN del stage de producción
output "api_gateway_stage_arn" {
  description = "ARN del stage de producción del API Gateway"
  value       = "arn:aws:apigateway:${var.region}::restapis/${var.api_gateway_id}/stages/prod"
}

// Nombre de la tabla de DynamoDB
output "dynamodb_table_name" {
  description = "Nombre de la tabla de DynamoDB para pedidos"
  value       = module.database.dynamodb_table_name
}

// ARN de la tabla de DynamoDB
output "dynamodb_table_arn" {
  description = "ARN de la tabla de DynamoDB para pedidos"
  value       = module.database.dynamodb_table_arn
}

// ID de la VPC creada
output "vpc_id" {
  description = "ID de la VPC creada para la infraestructura"
  value       = module.networking.vpc_id
}

// IDs de las subnets públicas
output "public_subnet_ids" {
  description = "IDs de las subnets públicas para recursos expuestos"
  value       = module.networking.public_subnet_ids
}

// IDs de las subnets privadas
output "private_subnet_ids" {
  description = "IDs de las subnets privadas para recursos internos"
  value       = module.networking.private_subnet_ids
}

// ID del security group de la API
output "api_security_group_id" {
  description = "ID del security group para el API Gateway"
  value       = module.networking.api_security_group_id
}

// ID del security group de la base de datos
output "database_security_group_id" {
  description = "ID del security group para la base de datos"
  value       = module.networking.database_security_group_id
}

// === ARCHIVO: infra/modules/networking/variables.tf ===
# Variables del módulo de networking
# Estas variables parametrizan la configuración de la VPC y subnets

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC principal"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "public_subnet_1" {
  description = "Primera subnet pública para recursos expuestos a internet"
  type        = string
}

variable "region" {
  description = "Región de AWS donde se desplegarán los recursos de red"
  type        = string
}

variable "public_subnet_2" {
  description = "Segunda subnet pública para redundancy y alta disponibilidad"
  type        = string
}

variable "private_subnet_1" {
  description = "Primera subnet privada para recursos internos"
  type        = string
}

variable "private_subnet_2" {
  description = "Segunda subnet privada para redundancy y alta disponibilidad"
  type        = string
}

// === ARCHIVO: client/pubspec.yaml ===
name: order_app
description: Aplicación móvil de pedidos con arquitectura limpia.
version: 1.0.0
environment:
  sdk: ">=3.6.0 <4.0.0"
  flutter: ">=3.27.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  dio: ^5.7.0
  flutter_riverpod: ^2.5.1
  json_annotation: ^4.9.0
  dartz: ^0.10.1
  equatable: ^2.0.5

dev_dependencies:
  build_runner: ^2.4.11
  json_serializable: ^6.8.0
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true

// === ARCHIVO: client/lib/domain/entities/order.dart ===
class Order {
  final String id;
  final String customerId;
  final List<OrderItem> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Order({
    required this.id,
    required this.customerId,
    required this.items,
    required this.totalAmount,
    this.status = 'pending',
    required this.createdAt,
    this.updatedAt,
  }) {
    if (totalAmount <= 0) {
      throw ArgumentError('El monto total debe ser mayor a cero.');
    }
    if (items.isEmpty) {
      throw ArgumentError('La orden debe contener al menos un ítem.');
    }
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      status: json['status'] as String? ?? 'pending',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'items': items.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Order copyWith({
    String? id,
    String? customerId,
    List<OrderItem>? items,
    double? totalAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Order) return false;
    return id == other.id &&
        customerId == other.customerId &&
        _listEquals(items, other.items) &&
        totalAmount == other.totalAmount &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      customerId,
      Object.hashAll(items),
      totalAmount,
      status,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'Order(id: $id, customerId: $customerId, items: ${items.length}, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  }) {
    if (quantity <= 0) {
      throw ArgumentError('La cantidad debe ser mayor a cero.');
    }
    if (price <= 0) {
      throw ArgumentError('El precio debe ser mayor a cero.');
    }
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  OrderItem copyWith({
    String? productId,
    int? quantity,
    double? price,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderItem) return false;
    return productId == other.productId &&
        quantity == other.quantity &&
        price == other.price;
  }

  @override
  int get hashCode => Object.hash(productId, quantity, price);

  @override
  String toString() {
    return 'OrderItem(productId: $productId, quantity: $quantity, price: $price)';
  }
}

// === ARCHIVO: client/lib/domain/repositories/order_repository.dart ===
import '../entities/order.dart';
import '../../data/repositories/order_repository_impl.dart';

abstract class OrderRepository {
  Future<OrderListResult> getOrders(String customerId);
  Future<OrderResult> getOrderById(String orderId);
  Future<OrderResult> createOrder(Order order);
  Future<OrderResult> updateOrder(Order order);
}

// === ARCHIVO: client/lib/core/network/dio_client.dart ===
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../failures/failure.dart';

class DioClient {
  final Dio _dio;
  final String baseUrl;

  DioClient({required this.baseUrl}) : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
    _dio.options.headers = {'Content-Type': 'application/json'};
  }

  Future<Either<Failure, Response<T>>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, Response<T>>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, Response<T>>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, Response<T>>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure('Error inesperado: $e'));
    }
  }

  Future<Either<Failure, Response<T>>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure('Error inesperado: $e'));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure('Tiempo de espera agotado');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 404) {
          return Failure('Recurso no encontrado');
        } else if (statusCode == 400) {
          return Failure('Solicitud incorrecta: ${error.response?.data}');
        } else if (statusCode == 401) {
          return Failure('No autorizado');
        } else if (statusCode == 500) {
          return Failure('Error interno del servidor');
        } else {
          return Failure('Error en la respuesta del servidor: $statusCode');
        }
      case DioExceptionType.cancel:
        return Failure('Solicitud cancelada');
      default:
        return Failure('Error de conexión: ${error.message}');
    }
  }
}

// === ARCHIVO: client/lib/core/failures/failure.dart ===
class Failure {
  final String message;
  final Map<String, dynamic>? details;

  Failure(this.message, {this.details});

  @override
  String toString() => 'Failure: $message${details != null ? ' - $details' : ''}';
}

class NetworkFailure extends Failure {
  NetworkFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

class ServerFailure extends Failure {
  ServerFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

class CacheFailure extends Failure {
  CacheFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

class ValidationFailure extends Failure {
  ValidationFailure(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <application
        android:label="Order App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:enableOnBackInvokedCallback="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: client/lib/data/datasources/remote/order_remote_data_source.dart ===
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:order_app/core/network/dio_client.dart';
import 'package:order_app/core/failures/failure.dart';
import 'package:order_app/domain/entities/order.dart';

class OrderRemoteDataSource {
  final DioClient _dioClient;
  
  OrderRemoteDataSource(this._dioClient);

  Future<List<Order>> getOrders(String customerId) async {
    final response = await _dioClient.get(
      '/orders',
      queryParameters: {'customerId': customerId},
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al obtener pedidos: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          final List<dynamic> data = resp.data['orders'] ?? [];
          return data.map((json) => Order.fromJson(json as Map<String, dynamic>)).toList();
        } else {
          throw ServerFailure('Error al obtener pedidos: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> getOrderById(String orderId) async {
    final response = await _dioClient.get('/orders/$orderId');
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al obtener pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else if (resp.statusCode == 404) {
          throw ServerFailure('Pedido no encontrado: $orderId');
        } else {
          throw ServerFailure('Error al obtener pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> createOrder(Order order) async {
    final response = await _dioClient.post(
      '/orders',
      data: order.toJson(),
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al crear pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 201 || resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else {
          throw ServerFailure('Error al crear pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> updateOrder(Order order) async {
    final response = await _dioClient.put(
      '/orders/${order.id}',
      data: order.toJson(),
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al actualizar pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else if (resp.statusCode == 404) {
          throw ServerFailure('Pedido no encontrado para actualizar: ${order.id}');
        } else {
          throw ServerFailure('Error al actualizar pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> cancelOrder(String orderId) async {
    final response = await _dioClient.put(
      '/orders/$orderId/cancel',
      data: {'status': 'cancelled'},
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al cancelar pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else if (resp.statusCode == 404) {
          throw ServerFailure('Pedido no encontrado para cancelar: $orderId');
        } else {
          throw ServerFailure('Error al cancelar pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<List<Order>> getOrderHistory({
    required String customerId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final queryParams = <String, dynamic>{
      'customerId': customerId,
    };
    
    if (status != null) queryParams['status'] = status;
    if (startDate != null) queryParams['startDate'] = startDate.toIso8601String();
    if (endDate != null) queryParams['endDate'] = endDate.toIso8601String();
    
    final response = await _dioClient.get(
      '/orders/history',
      queryParameters: queryParams,
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al obtener historial: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          final List<dynamic> data = resp.data['orders'] ?? [];
          return data.map((json) => Order.fromJson(json as Map<String, dynamic>)).toList();
        } else {
          throw ServerFailure('Error al obtener historial: ${resp.statusCode}');
        }
      },
    );
  }

  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Tiempo de conexión agotado. Verifica tu conexión a internet.');
      case DioExceptionType.connectionError:
        return NetworkFailure('No se pudo conectar al servidor. Verifica tu conexión.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final message = e.response?.data?['message'] ?? 'Error del servidor';
        if (statusCode >= 500) {
          return ServerFailure('Error del servidor: $message');
        } else if (statusCode == 401) {
          return ValidationFailure('No autorizado: $message');
        } else if (statusCode == 404) {
          return ServerFailure('Recurso no encontrado: $message');
        } else {
          return ServerFailure('Error en la solicitud: $message');
        }
      case DioExceptionType.cancel:
        return NetworkFailure('Solicitud cancelada');
      default:
        return NetworkFailure('Error de red: ${e.message}');
    }
  }
}

// === ARCHIVO: client/lib/data/repositories/order_repository_impl.dart ===
import 'package:order_app/core/failures/failure.dart';
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';
import 'package:order_app/data/datasources/remote/order_remote_data_source.dart';

/// Implementación del repositorio de pedidos que utiliza una fuente de datos remota.
/// Este repositorio implementa el patrón de repositorio de Clean Architecture,
/// aislando la lógica de acceso a datos de la capa de dominio.
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;
  
  /// Constructor que inyecta la fuente de datos remota.
  ///
  /// [_remoteDataSource] - Fuente de datos para operaciones remotas de pedidos
  OrderRepositoryImpl(this._remoteDataSource);

  /// Obtiene todos los pedidos de un cliente.
  /// 
  /// Implementa el patrón Result para manejar el éxito o fracaso de la operación.
  /// En caso de éxito, retorna una lista de pedidos. En caso de error, retorna
  /// el Failure correspondiente con el mensaje de error.
  ///
  /// [customerId] - Identificador único del cliente
  /// Retorna [OrderListResult] con la lista de pedidos o el error
  @override
  Future<OrderListResult> getOrders(String customerId) async {
    try {
      final orders = await _remoteDataSource.getOrders(customerId);
      return OrderListResult.success(orders);
    } on Failure catch (e) {
      return OrderListResult.failure(e);
    } catch (e) {
      return OrderListResult.failure(NetworkFailure('Error inesperado: $e'));
    }
  }

  /// Obtiene un pedido específico por su identificador.
  /// 
  /// [orderId] - Identificador único del pedido
  /// Retorna [OrderResult] con el pedido encontrado o el error
  @override
  Future<OrderResult> getOrderById(String orderId) async {
    try {
      final order = await _remoteDataSource.getOrderById(orderId);
      return OrderResult.success(order);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado: $e'));
    }
  }

  /// Crea un nuevo pedido en el sistema.
  /// 
  /// Valida el pedido antes de enviarlo y retorna el pedido creado con su ID.
  ///
  /// [order] - Objeto Order con los datos del pedido
  /// Retorna [OrderResult] con el pedido creado o el error
  @override
  Future<OrderResult> createOrder(Order order) async {
    try {
      final validationError = _validateOrder(order);
      if (validationError != null) {
        return OrderResult.failure(ValidationFailure(validationError));
      }
      
      final createdOrder = await _remoteDataSource.createOrder(order);
      return OrderResult.success(createdOrder);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado al crear pedido: $e'));
    }
  }

  /// Actualiza un pedido existente.
  /// 
  /// Verifica que el pedido exista antes de actualizar y retorna el pedido actualizado.
  ///
  /// [order] - Objeto Order con los datos actualizados
  /// Retorna [OrderResult] con el pedido actualizado o el error
  @override
  Future<OrderResult> updateOrder(Order order) async {
    try {
      final validationError = _validateOrder(order);
      if (validationError != null) {
        return OrderResult.failure(ValidationFailure(validationError));
      }
      
      final updatedOrder = await _remoteDataSource.updateOrder(order);
      return OrderResult.success(updatedOrder);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado al actualizar pedido: $e'));
    }
  }

  /// Cancela un pedido existente.
  /// 
  /// Solo permite cancelar pedidos en estado pendiente o confirmado.
  ///
  /// [orderId] - Identificador del pedido a cancelar
  /// Retorna [OrderResult] con el pedido cancelado o el error
  Future<OrderResult> cancelOrder(String orderId) async {
    try {
      final orderResult = await _remoteDataSource.getOrderById(orderId);
      
      if (orderResult.status != 'pending' && orderResult.status != 'confirmed') {
        return OrderResult.failure(
          ValidationFailure('No se puede cancelar un pedido en estado: ${orderResult.status}'),
        );
      }
      
      final cancelledOrder = await _remoteDataSource.cancelOrder(orderId);
      return OrderResult.success(cancelledOrder);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado al cancelar pedido: $e'));
    }
  }

  /// Obtiene el historial de pedidos con filtros opcionales.
  /// 
  /// Permite filtrar por estado y rango de fechas.
  ///
  /// [customerId] - Identificador del cliente
  /// [status] - Filtrar por estado del pedido
  /// [startDate] - Fecha inicial del rango
  /// [endDate] - Fecha final del rango
  /// Retorna [OrderListResult] con los pedidos encontrados o el error
  Future<OrderListResult> getOrderHistory({
    required String customerId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final orders = await _remoteDataSource.getOrderHistory(
        customerId: customerId,
        status: status,
        startDate: startDate,
        endDate: endDate,
      );
      return OrderListResult.success(orders);
    } on Failure catch (e) {
      return OrderListResult.failure(e);
    } catch (e) {
      return OrderListResult.failure(NetworkFailure('Error inesperado: $e'));
    }
  }

  /// Valida los datos de un pedido antes de enviarlo al servidor.
  /// 
  /// [order] - Pedido a validar
  /// Retorna null si es válido, o un mensaje de error si no lo es
  String? _validateOrder(Order order) {
    if (order.customerId.isEmpty) {
      return 'El identificador del cliente es requerido';
    }
    
    if (order.items.isEmpty) {
      return 'El pedido debe contener al menos un artículo';
    }
    
    for (final item in order.items) {
      if (item.productId.isEmpty) {
        return 'Todos los artículos deben tener un identificador de producto';
      }
      if (item.quantity <= 0) {
        return 'La cantidad de cada artículo debe ser mayor a cero';
      }
      if (item.price < 0) {
        return 'El precio no puede ser negativo';
      }
    }
    
    return null;
  }
}

/// Tipo resultado para operaciones que retornan una lista de pedidos.
/// Implementa el patrón Either de forma simplificada para manejar errores.
class OrderListResult {
  final List<Order>? _orders;
  final Failure? _failure;
  final bool _isSuccess;
  
  OrderListResult._({List<Order>? orders, Failure? failure, required bool isSuccess})
      : _orders = orders, _failure = failure, _isSuccess = isSuccess;
  
  factory OrderListResult.success(List<Order> orders) {
    return OrderListResult._(orders: orders, isSuccess: true);
  }
  
  factory OrderListResult.failure(Failure failure) {
    return OrderListResult._(failure: failure, isSuccess: false);
  }
  
  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;
  
  List<Order> get orders {
    if (_isSuccess) return _orders!;
    throw StateError('No se puede acceder a los pedidos en un resultado fallido');
  }
  
  Failure get failure {
    if (!_isSuccess) return _failure!;
    throw StateError('No hay failure en un resultado exitoso');
  }
  
  R fold<R>(R Function(Failure failure) onFailure, R Function(List<Order> orders) onSuccess) {
    if (_isSuccess) {
      return onSuccess(_orders!);
    } else {
      return onFailure(_failure!);
    }
  }
}

/// Tipo resultado para operaciones que retornan un solo pedido.
/// Implementa el patrón Either de forma simplificada para manejar errores.
class OrderResult {
  final Order? _order;
  final Failure? _failure;
  final bool _isSuccess;
  
  OrderResult._({Order? order, Failure? failure, required bool isSuccess})
      : _order = order, _failure = failure, _isSuccess = isSuccess;
  
  factory OrderResult.success(Order order) {
    return OrderResult._(order: order, isSuccess: true);
  }
  
  factory OrderResult.failure(Failure failure) {
    return OrderResult._(failure: failure, isSuccess: false);
  }
  
  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;
  
  Order get order {
    if (_isSuccess) return _order!;
    throw StateError('No se puede acceder al pedido en un resultado fallido');
  }
  
  Failure get failure {
    if (!_isSuccess) return _failure!;
    throw StateError('No hay failure en un resultado exitoso');
  }
  
  R fold<R>(R Function(Failure failure) onFailure, R Function(Order order) onSuccess) {
    if (_isSuccess) {
      return onSuccess(_order!);
    } else {
      return onFailure(_failure!);
    }
  }
}

// === ARCHIVO: client/lib/presentation/viewmodels/order_viewmodel.dart ===
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';
import 'package:order_app/core/failures/failure.dart';

/// Estado que representa el resultado de una operación sobre pedidos.
/// Puede ser idle, loading, success (con datos) o error (con Failure).
sealed class OrderViewState {
  const OrderViewState();
}

class OrderIdle extends OrderViewState {
  const OrderIdle();
}

class OrderLoading extends OrderViewState {
  const OrderLoading();
}

class OrderLoaded extends OrderViewState {
  final List<Order> orders;
  const OrderLoaded(this.orders);
}

class OrderOperationSuccess extends OrderViewState {
  final Order order;
  final String message;
  const OrderOperationSuccess(this.order, this.message);
}

class OrderError extends OrderViewState {
  final Failure failure;
  const OrderError(this.failure);
}

/// ViewModel que gestiona el estado de la pantalla de pedidos.
/// Utiliza Riverpod para la inyección de dependencias y manejo de estado reactivo.
class OrderViewModel extends StateNotifier<OrderViewState> {
  final OrderRepository _orderRepository;
  final String customerId;

  OrderViewModel(this._orderRepository, this.customerId) : super(const OrderIdle());

  /// Carga todos los pedidos del cliente actual.
  /// Este método consulta el repositorio y actualiza el estado según el resultado.
  Future<void> loadOrders() async {
    state = const OrderLoading();
    final result = await _orderRepository.getOrders(customerId);
    result.fold(
      (failure) => state = OrderError(failure),
      (orders) => state = OrderLoaded(orders),
    );
  }

  /// Carga un pedido específico por su ID.
  /// Útil para ver los detalles de un pedido individual.
  Future<void> loadOrderById(String orderId) async {
    state = const OrderLoading();
    final result = await _orderRepository.getOrderById(orderId);
    result.fold(
      (failure) => state = OrderError(failure),
      (order) => state = OrderOperationSuccess(order, 'Pedido cargado correctamente'),
    );
  }

  /// Crea un nuevo pedido en el sistema.
  /// El pedido se construye con los items proporcionados y se envía al repositorio.
  Future<void> createOrder(List<OrderItem> items, double totalAmount) async {
    state = const OrderLoading();
    final order = Order(
      id: '',
      customerId: customerId,
      items: items,
      totalAmount: totalAmount,
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: null,
    );
    final result = await _orderRepository.createOrder(order);
    result.fold(
      (failure) => state = OrderError(failure),
      (createdOrder) => state = OrderOperationSuccess(createdOrder, 'Pedido creado correctamente'),
    );
  }

  /// Actualiza el estado de un pedido existente.
  /// Comúnmente usado para cambiar el estado (cancelado, completado, etc.).
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    state = const OrderLoading();
    final getResult = await _orderRepository.getOrderById(orderId);
    await getResult.fold(
      (failure) async => state = OrderError(failure),
      (existingOrder) async {
        final updatedOrder = Order(
          id: existingOrder.id,
          customerId: existingOrder.customerId,
          items: existingOrder.items,
          totalAmount: existingOrder.totalAmount,
          status: newStatus,
          createdAt: existingOrder.createdAt,
          updatedAt: DateTime.now(),
        );
        final updateResult = await _orderRepository.updateOrder(updatedOrder);
        updateResult.fold(
          (failure) => state = OrderError(failure),
          (order) => state = OrderOperationSuccess(order, 'Pedido actualizado correctamente'),
        );
      },
    );
  }

  /// Reinicia el estado a idle.
  /// Útil cuando se quiere limpiar el estado después de mostrar un mensaje al usuario.
  void resetState() {
    state = const OrderIdle();
  }
}

/// Proveedor de familia que crea una instancia de OrderViewModel por cada customerId.
/// Permite que múltiples clientes tengan su propio estado aislado.
final orderViewModelProvider = StateNotifierProvider.family<OrderViewModel, OrderViewState, String>(
  (ref, customerId) {
    final orderRepository = ref.watch(orderRepositoryProvider);
    return OrderViewModel(orderRepository, customerId);
  },
);

/// Proveedor del repositorio de pedidos.
/// En una implementación real, este provider se configuraría con la dependencia real.
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  throw UnimplementedError('El provider de OrderRepository debe ser sobreescrito en main.dart');
});

// === ARCHIVO: client/lib/presentation/screens/order_screen.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/presentation/viewmodels/order_viewmodel.dart';
import 'package:order_app/core/failures/failure.dart';

/// Pantalla principal de pedidos que muestra la lista de pedidos del cliente.
/// Implementa el patrón MVVM utilizando Riverpod para el manejo de estado.
class OrderScreen extends ConsumerStatefulWidget {
  final String customerId;
  const OrderScreen({super.key, required this.customerId});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los pedidos al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderViewModelProvider(widget.customerId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
            },
            tooltip: 'Actualizar pedidos',
          ),
        ],
      ),
      body: _buildBody(orderState),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateOrderDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Pedido'),
      ),
    );
  }

  /// Construye el cuerpo de la pantalla según el estado actual.
  Widget _buildBody(OrderViewState state) {
    return switch (state) {
      OrderIdle() => const Center(child: Text('Cargando pedidos...')),
      OrderLoading() => const Center(child: CircularProgressIndicator()),
      OrderLoaded(:final orders) => _buildOrderList(orders),
      OrderOperationSuccess(:final order, :final message) => _buildSuccessView(order, message),
      OrderError(:final failure) => _buildErrorView(failure),
    };
  }

  /// Muestra la lista de pedidos en un ListView.
  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('No tienes pedidos aún', style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 8),
            Text('Toca el botón + para crear tu primer pedido', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderCard(
          order: order,
          onTap: () => _showOrderDetails(order),
          onStatusChange: (newStatus) => _updateOrderStatus(order.id, newStatus),
        );
      },
    );
  }

  /// Muestra una vista de éxito con el pedido modificado.
  Widget _buildSuccessView(Order order, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
    });
    return const Center(child: CircularProgressIndicator());
  }

  /// Muestra la vista de error con el mensaje de Failure.
  Widget _buildErrorView(Failure failure) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error al cargar pedidos',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              failure.message,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra los detalles de un pedido específico.
  void _showOrderDetails(Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _OrderDetailsSheet(
          order: order,
          scrollController: scrollController,
        ),
      ),
    );
  }

  /// Actualiza el estado de un pedido.
  void _updateOrderStatus(String orderId, String newStatus) {
    ref.read(orderViewModelProvider(widget.customerId).notifier).updateOrderStatus(orderId, newStatus);
  }

  /// Muestra el diálogo para crear un nuevo pedido.
  void _showCreateOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _CreateOrderDialog(),
    );
  }
}

/// Tarjeta individual que muestra la información de un pedido.
class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;
  final Function(String) onStatusChange;

  const _OrderCard({
    required this.order,
    required this.onTap,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${order.id.substring(0, 8)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _StatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${order.items.length} producto${order.items.length != 1 ? 's' : ''}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(order.createdAt),
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// Badge que muestra el estado del pedido con color apropiado.
class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'pending' => (Colors.orange, 'Pendiente'),
      'processing' => (Colors.blue, 'Procesando'),
      'completed' => (Colors.green, 'Completado'),
      'cancelled' => (Colors.red, 'Cancelado'),
      _ => (Colors.grey, status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Hoja de detalles que muestra información completa de un pedido.
class _OrderDetailsSheet extends StatelessWidget {
  final Order order;
  final ScrollController scrollController;

  const _OrderDetailsSheet({
    required this.order,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Detalles del Pedido',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _DetailRow(label: 'ID', value: order.id),
          _DetailRow(label: 'Cliente', value: order.customerId),
          _DetailRow(label: 'Estado', value: order.status),
          _DetailRow(label: 'Total', value: '\$${order.totalAmount.toStringAsFixed(2)}'),
          _DetailRow(label: 'Creado', value: order.createdAt.toString()),
          if (order.updatedAt != null)
            _DetailRow(label: 'Actualizado', value: order.updatedAt.toString()),
          const SizedBox(height: 24),
          Text(
            'Productos',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...order.items.map((item) => _ItemRow(item: item)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  final OrderItem item;
  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productId, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text('Cantidad: ${item.quantity}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

/// Diálogo simple para crear un nuevo pedido.
class _CreateOrderDialog extends ConsumerStatefulWidget {
  const _CreateOrderDialog();

  @override
  ConsumerState<_CreateOrderDialog> createState() => _CreateOrderDialogState();
}

class _CreateOrderDialogState extends ConsumerState<_CreateOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final List<OrderItem> _items = [];

  @override
  void dispose() {
    _productIdController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _items.add(OrderItem(
          productId: _productIdController.text,
          quantity: int.parse(_quantityController.text),
          price: double.parse(_priceController.text),
        ));
      });
      _productIdController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  double get _total => _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear Nuevo Pedido'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _productIdController,
                decoration: const InputDecoration(labelText: 'ID del Producto', border: OutlineInputBorder()),
                validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Precio', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Agregar Producto'),
              ),
              if (_items.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Productos agregados:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._items.asMap().entries.map((e) => ListTile(
                  dense: true,
                  title: Text(e.value.productId),
                  subtitle: Text('Qty: ${e.value.quantity} x \$${e.value.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => setState(() => _items.removeAt(e.key)),
                  ),
                )),
                const Divider(),
                Text('Total: \$${_total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: _items.isEmpty
              ? null
              : () {
                  ref.read(orderViewModelProvider('default-customer').notifier).createOrder(_items, _total);
                  Navigator.pop(context);
                },
          child: const Text('Crear Pedido'),
        ),
      ],
    );
  }
}

// === ARCHIVO: client/README.md ===
# Order App - Aplicación de Pedidos Móvil

Aplicación móvil de pedidos desarrollada en Flutter con arquitectura limpia (Clean Architecture) y patrón MVVM.

## Requisitos Previos

- Flutter SDK 3.27 o superior
- Dart SDK 3.6 o superior
- Android SDK configurado (para Android)
- Xcode configurado (para iOS)

## Instalación

1. Clona el repositorio:
```bash
git clone <repositorio>
cd order_app
```

2. Instala las dependencias:
```bash
flutter pub get
```

3. Ejecuta la aplicación:
```bash
flutter run
```

## Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada de la aplicación
├── core/
│   ├── failures/                  # Clases de errores personalizados
│   │   └── failure.dart
│   └── network/
│       └── dio_client.dart        # Cliente HTTP configurado con Dio
├── data/
│   ├── datasources/               # Fuentes de datos
│   │   └── remote/
│   │       └── order_remote_data_source.dart
│   └── repositories/
│       └── order_repository_impl.dart
├── domain/
│   ├── entities/                  # Entidades del dominio
│   │   └── order.dart
│   └── repositories/
│       └── order_repository.dart  # Contrato del repositorio
└── presentation/
    ├── screens/                   # Pantallas de la UI
    │   └── order_screen.dart
    └── viewmodels/                # ViewModels para MVVM
        └── order_viewmodel.dart
```

## Arquitectura

La aplicación sigue los principios de **Clean Architecture** con las siguientes capas:

- **Domain**: Contiene las entidades del negocio y los contratos (interfaces) de los repositorios.
- **Data**: Implementa los repositorios y las fuentes de datos (remotas y locales).
- **Presentation**: Maneja la UI y el estado de la aplicación usando el patrón MVVM con Riverpod.
- **Core**: Utilidades comunes como manejo de errores y cliente HTTP.

## Dependencias Principales

| Paquete | Versión | Propósito |
|---------|---------|------------|
| flutter | 3.27.0 | Framework principal |
| dio | 5.7.0 | Cliente HTTP |
| flutter_riverpod | 2.5.1 | Manejo de estado e inyección de dependencias |
| json_annotation | 4.9.0 | Serialización JSON |

## Uso de la API

La aplicación consume una API REST que debe estar desplegada y accesible. Configura la URL base en la configuración del cliente Dio.

### Endpoints Esperados

- `GET /orders/{customerId}` - Obtener pedidos de un cliente
- `GET /orders/{orderId}` - Obtener un pedido específico
- `POST /orders` - Crear un nuevo pedido
- `PUT /orders/{orderId}` - Actualizar un pedido

## Comandos de Desarrollo

```bash
# Análisis de código
flutter analyze

# Build de debug
flutter build apk --debug

# Build de release
flutter build apk --release

# Ejecutar tests
flutter test
```

## Contribuir

1. Haz un fork del proyecto
2. Crea una rama feature (`git checkout -b feature/nueva-caracteristica`)
3. Commit tus cambios (`git commit -m 'Añadir nueva característica'`)
4. Push a la rama (`git push origin feature/nueva-caracteristica`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la licencia MIT.

// === ARCHIVO: client/lib/main.dart ===
library order_app;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/core/network/dio_client.dart';
import 'package:order_app/presentation/screens/order_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: OrderApp(),
    ),
  );
}

class OrderApp extends StatelessWidget {
  const OrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const String _baseUrl = 'https://api.pedidos.example.com/v1';
  static const String _defaultCustomerId = 'CUST-001';

  late final DioClient _dioClient;

  @override
  void initState() {
    super.initState();
    _dioClient = DioClient(baseUrl: _baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicación de Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Actualizando pedidos...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            tooltip: 'Actualizar',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showSettingsDialog(context);
            },
            tooltip: 'Configuración',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.inversePrimary.withValues(alpha: 0.3),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildWelcomeCard(context),
              Expanded(
                child: _buildMainContent(context),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderScreen(
                customerId: _defaultCustomerId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Ver Pedidos'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navegando a Inicio'),
                ),
              );
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    customerId: _defaultCustomerId,
                  ),
                ),
              );
              break;
            case 2:
              _showProfileDialog(context);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.storefront,
                    size: 32,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenido a OrderApp',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Gestiona tus pedidos de forma eficiente',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  context,
                  Icons.shopping_bag,
                  '12',
                  'Pedidos',
                ),
                _buildStatItem(
                  context,
                  Icons.local_shipping,
                  '3',
                  'En tránsito',
                ),
                _buildStatItem(
                  context,
                  Icons.check_circle,
                  '9',
                  'Entregados',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Acciones Rápidas',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _showApiInfo(context);
                  },
                  child: const Text('Ver API'),
                ),
              ],
            ),
          ),
          _buildQuickActionCard(
            context,
            Icons.add_shopping_cart,
            'Nuevo Pedido',
            'Crea un nuevo pedido rápidamente',
            () => _showCreateOrderDialog(context),
          ),
          const SizedBox(height: 12),
          _buildQuickActionCard(
            context,
            Icons.history,
            'Historial',
            'Ver todos tus pedidos anteriores',
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    customerId: _defaultCustomerId,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildQuickActionCard(
            context,
            Icons.notifications,
            'Notificaciones',
            'Configura tus preferencias',
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Próximamente'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showCreateOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo Pedido'),
        content: const Text(
          '¿Deseas crear un nuevo pedido? Serás redirigido a la pantalla de pedidos.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    customerId: _defaultCustomerId,
                  ),
                ),
              );
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  void _showProfileDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Usuario Demo',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _defaultCustomerId,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('demo@orderapp.com'),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('+34 600 000 000'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Detalles de la API',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('URL Base', _baseUrl),
            _buildDetailRow('Customer ID', _defaultCustomerId),
            _buildDetailRow('Timeout', '30 segundos'),
            _buildDetailRow('Retry Attempts', '3'),
            _buildDetailRow('Cache', 'Habilitado'),
            const SizedBox(height: 24),
            Text(
              'Endpoints Disponibles',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildEndpointRow('GET', '/orders'),
            _buildEndpointRow('GET', '/orders/{id}'),
            _buildEndpointRow('POST', '/orders'),
            _buildEndpointRow('PUT', '/orders/{id}'),
            _buildEndpointRow('DELETE', '/orders/{id}'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.check),
                label: const Text('Entendido'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndpointRow(String method, String path) {
    Color methodColor;
    switch (method) {
      case 'GET':
        methodColor = Colors.blue;
        break;
      case 'POST':
        methodColor = Colors.green;
        break;
      case 'PUT':
        methodColor = Colors.orange;
        break;
      case 'DELETE':
        methodColor = Colors.red;
        break;
      default:
        methodColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: methodColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: methodColor.withValues(alpha: 0.5)),
            ),
            child: Text(
              method,
              style: TextStyle(
                color: methodColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              path,
              style: const TextStyle(
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showApiInfo(BuildContext context) {
    _showSettingsDialog(context);
  }
}
```
