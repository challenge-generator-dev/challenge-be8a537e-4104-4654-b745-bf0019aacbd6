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