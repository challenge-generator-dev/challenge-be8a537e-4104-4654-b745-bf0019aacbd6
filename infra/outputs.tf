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