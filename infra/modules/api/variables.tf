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