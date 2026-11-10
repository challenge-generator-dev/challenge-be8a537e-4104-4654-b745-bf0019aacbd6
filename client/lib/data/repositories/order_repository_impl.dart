import 'package:order_app/core/failures/failure.dart';
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';
import 'package:order_app/data/datasources/remote/order_remote_data_source.dart';

/// Implementación del repositorio de pedidos que utiliza una fuente de datos remota.
/// Este repositorio implementa el patrón de repositorio de Clean Architecture,
/// aislando la lógica de acceso a datos de la capa de dominio.
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;
  
  /// Constructor que inyecta la fuente de datos remota.
  ///
  /// [_remoteDataSource] - Fuente de datos para operaciones remotas de pedidos
  OrderRepositoryImpl(this._remoteDataSource);

  /// Obtiene todos los pedidos de un cliente.
  /// 
  /// Implementa el patrón Result para manejar el éxito o fracaso de la operación.
  /// En caso de éxito, retorna una lista de pedidos. En caso de error, retorna
  /// el Failure correspondiente con el mensaje de error.
  ///
  /// [customerId] - Identificador único del cliente
  /// Retorna [OrderListResult] con la lista de pedidos o el error
  @override
  Future<OrderListResult> getOrders(String customerId) async {
    try {
      final orders = await _remoteDataSource.getOrders(customerId);
      return OrderListResult.success(orders);
    } on Failure catch (e) {
      return OrderListResult.failure(e);
    } catch (e) {
      return OrderListResult.failure(NetworkFailure('Error inesperado: $e'));
    }
  }

  /// Obtiene un pedido específico por su identificador.
  /// 
  /// [orderId] - Identificador único del pedido
  /// Retorna [OrderResult] con el pedido encontrado o el error
  @override
  Future<OrderResult> getOrderById(String orderId) async {
    try {
      final order = await _remoteDataSource.getOrderById(orderId);
      return OrderResult.success(order);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado: $e'));
    }
  }

  /// Crea un nuevo pedido en el sistema.
  /// 
  /// Valida el pedido antes de enviarlo y retorna el pedido creado con su ID.
  ///
  /// [order] - Objeto Order con los datos del pedido
  /// Retorna [OrderResult] con el pedido creado o el error
  @override
  Future<OrderResult> createOrder(Order order) async {
    try {
      final validationError = _validateOrder(order);
      if (validationError != null) {
        return OrderResult.failure(ValidationFailure(validationError));
      }
      
      final createdOrder = await _remoteDataSource.createOrder(order);
      return OrderResult.success(createdOrder);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado al crear pedido: $e'));
    }
  }

  /// Actualiza un pedido existente.
  /// 
  /// Verifica que el pedido exista antes de actualizar y retorna el pedido actualizado.
  ///
  /// [order] - Objeto Order con los datos actualizados
  /// Retorna [OrderResult] con el pedido actualizado o el error
  @override
  Future<OrderResult> updateOrder(Order order) async {
    try {
      final validationError = _validateOrder(order);
      if (validationError != null) {
        return OrderResult.failure(ValidationFailure(validationError));
      }
      
      final updatedOrder = await _remoteDataSource.updateOrder(order);
      return OrderResult.success(updatedOrder);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado al actualizar pedido: $e'));
    }
  }

  /// Cancela un pedido existente.
  /// 
  /// Solo permite cancelar pedidos en estado pendiente o confirmado.
  ///
  /// [orderId] - Identificador del pedido a cancelar
  /// Retorna [OrderResult] con el pedido cancelado o el error
  Future<OrderResult> cancelOrder(String orderId) async {
    try {
      final orderResult = await _remoteDataSource.getOrderById(orderId);
      
      if (orderResult.status != 'pending' && orderResult.status != 'confirmed') {
        return OrderResult.failure(
          ValidationFailure('No se puede cancelar un pedido en estado: ${orderResult.status}'),
        );
      }
      
      final cancelledOrder = await _remoteDataSource.cancelOrder(orderId);
      return OrderResult.success(cancelledOrder);
    } on Failure catch (e) {
      return OrderResult.failure(e);
    } catch (e) {
      return OrderResult.failure(NetworkFailure('Error inesperado al cancelar pedido: $e'));
    }
  }

  /// Obtiene el historial de pedidos con filtros opcionales.
  /// 
  /// Permite filtrar por estado y rango de fechas.
  ///
  /// [customerId] - Identificador del cliente
  /// [status] - Filtrar por estado del pedido
  /// [startDate] - Fecha inicial del rango
  /// [endDate] - Fecha final del rango
  /// Retorna [OrderListResult] con los pedidos encontrados o el error
  Future<OrderListResult> getOrderHistory({
    required String customerId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final orders = await _remoteDataSource.getOrderHistory(
        customerId: customerId,
        status: status,
        startDate: startDate,
        endDate: endDate,
      );
      return OrderListResult.success(orders);
    } on Failure catch (e) {
      return OrderListResult.failure(e);
    } catch (e) {
      return OrderListResult.failure(NetworkFailure('Error inesperado: $e'));
    }
  }

  /// Valida los datos de un pedido antes de enviarlo al servidor.
  /// 
  /// [order] - Pedido a validar
  /// Retorna null si es válido, o un mensaje de error si no lo es
  String? _validateOrder(Order order) {
    if (order.customerId.isEmpty) {
      return 'El identificador del cliente es requerido';
    }
    
    if (order.items.isEmpty) {
      return 'El pedido debe contener al menos un artículo';
    }
    
    for (final item in order.items) {
      if (item.productId.isEmpty) {
        return 'Todos los artículos deben tener un identificador de producto';
      }
      if (item.quantity <= 0) {
        return 'La cantidad de cada artículo debe ser mayor a cero';
      }
      if (item.price < 0) {
        return 'El precio no puede ser negativo';
      }
    }
    
    return null;
  }
}

/// Tipo resultado para operaciones que retornan una lista de pedidos.
/// Implementa el patrón Either de forma simplificada para manejar errores.
class OrderListResult {
  final List<Order>? _orders;
  final Failure? _failure;
  final bool _isSuccess;
  
  OrderListResult._({List<Order>? orders, Failure? failure, required bool isSuccess})
      : _orders = orders, _failure = failure, _isSuccess = isSuccess;
  
  factory OrderListResult.success(List<Order> orders) {
    return OrderListResult._(orders: orders, isSuccess: true);
  }
  
  factory OrderListResult.failure(Failure failure) {
    return OrderListResult._(failure: failure, isSuccess: false);
  }
  
  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;
  
  List<Order> get orders {
    if (_isSuccess) return _orders!;
    throw StateError('No se puede acceder a los pedidos en un resultado fallido');
  }
  
  Failure get failure {
    if (!_isSuccess) return _failure!;
    throw StateError('No hay failure en un resultado exitoso');
  }
  
  R fold<R>(R Function(Failure failure) onFailure, R Function(List<Order> orders) onSuccess) {
    if (_isSuccess) {
      return onSuccess(_orders!);
    } else {
      return onFailure(_failure!);
    }
  }
}

/// Tipo resultado para operaciones que retornan un solo pedido.
/// Implementa el patrón Either de forma simplificada para manejar errores.
class OrderResult {
  final Order? _order;
  final Failure? _failure;
  final bool _isSuccess;
  
  OrderResult._({Order? order, Failure? failure, required bool isSuccess})
      : _order = order, _failure = failure, _isSuccess = isSuccess;
  
  factory OrderResult.success(Order order) {
    return OrderResult._(order: order, isSuccess: true);
  }
  
  factory OrderResult.failure(Failure failure) {
    return OrderResult._(failure: failure, isSuccess: false);
  }
  
  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;
  
  Order get order {
    if (_isSuccess) return _order!;
    throw StateError('No se puede acceder al pedido en un resultado fallido');
  }
  
  Failure get failure {
    if (!_isSuccess) return _failure!;
    throw StateError('No hay failure en un resultado exitoso');
  }
  
  R fold<R>(R Function(Failure failure) onFailure, R Function(Order order) onSuccess) {
    if (_isSuccess) {
      return onSuccess(_order!);
    } else {
      return onFailure(_failure!);
    }
  }
}