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