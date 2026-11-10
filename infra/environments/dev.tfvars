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