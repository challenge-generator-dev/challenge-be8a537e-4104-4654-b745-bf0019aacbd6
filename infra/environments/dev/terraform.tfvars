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