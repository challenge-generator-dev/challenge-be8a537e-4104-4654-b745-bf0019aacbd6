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