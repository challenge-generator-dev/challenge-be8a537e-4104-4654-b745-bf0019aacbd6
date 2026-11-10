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