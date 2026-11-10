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