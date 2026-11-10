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