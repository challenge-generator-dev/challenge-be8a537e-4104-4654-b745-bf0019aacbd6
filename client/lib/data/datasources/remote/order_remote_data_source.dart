import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:order_app/core/network/dio_client.dart';
import 'package:order_app/core/failures/failure.dart';
import 'package:order_app/domain/entities/order.dart';

class OrderRemoteDataSource {
  final DioClient _dioClient;
  
  OrderRemoteDataSource(this._dioClient);

  Future<List<Order>> getOrders(String customerId) async {
    final response = await _dioClient.get(
      '/orders',
      queryParameters: {'customerId': customerId},
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al obtener pedidos: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          final List<dynamic> data = resp.data['orders'] ?? [];
          return data.map((json) => Order.fromJson(json as Map<String, dynamic>)).toList();
        } else {
          throw ServerFailure('Error al obtener pedidos: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> getOrderById(String orderId) async {
    final response = await _dioClient.get('/orders/$orderId');
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al obtener pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else if (resp.statusCode == 404) {
          throw ServerFailure('Pedido no encontrado: $orderId');
        } else {
          throw ServerFailure('Error al obtener pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> createOrder(Order order) async {
    final response = await _dioClient.post(
      '/orders',
      data: order.toJson(),
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al crear pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 201 || resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else {
          throw ServerFailure('Error al crear pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> updateOrder(Order order) async {
    final response = await _dioClient.put(
      '/orders/${order.id}',
      data: order.toJson(),
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al actualizar pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else if (resp.statusCode == 404) {
          throw ServerFailure('Pedido no encontrado para actualizar: ${order.id}');
        } else {
          throw ServerFailure('Error al actualizar pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<Order> cancelOrder(String orderId) async {
    final response = await _dioClient.put(
      '/orders/$orderId/cancel',
      data: {'status': 'cancelled'},
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al cancelar pedido: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          return Order.fromJson(resp.data as Map<String, dynamic>);
        } else if (resp.statusCode == 404) {
          throw ServerFailure('Pedido no encontrado para cancelar: $orderId');
        } else {
          throw ServerFailure('Error al cancelar pedido: ${resp.statusCode}');
        }
      },
    );
  }

  Future<List<Order>> getOrderHistory({
    required String customerId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final queryParams = <String, dynamic>{
      'customerId': customerId,
    };
    
    if (status != null) queryParams['status'] = status;
    if (startDate != null) queryParams['startDate'] = startDate.toIso8601String();
    if (endDate != null) queryParams['endDate'] = endDate.toIso8601String();
    
    final response = await _dioClient.get(
      '/orders/history',
      queryParameters: queryParams,
    );
    
    return response.fold(
      (failure) {
        if (failure is NetworkFailure) {
          throw NetworkFailure('Error de conexión: ${failure.message}');
        } else if (failure is ServerFailure) {
          throw ServerFailure('Error al obtener historial: ${failure.message}');
        }
        throw failure;
      },
      (resp) {
        if (resp.statusCode == 200) {
          final List<dynamic> data = resp.data['orders'] ?? [];
          return data.map((json) => Order.fromJson(json as Map<String, dynamic>)).toList();
        } else {
          throw ServerFailure('Error al obtener historial: ${resp.statusCode}');
        }
      },
    );
  }

  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Tiempo de conexión agotado. Verifica tu conexión a internet.');
      case DioExceptionType.connectionError:
        return NetworkFailure('No se pudo conectar al servidor. Verifica tu conexión.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode ?? 0;
        final message = e.response?.data?['message'] ?? 'Error del servidor';
        if (statusCode >= 500) {
          return ServerFailure('Error del servidor: $message');
        } else if (statusCode == 401) {
          return ValidationFailure('No autorizado: $message');
        } else if (statusCode == 404) {
          return ServerFailure('Recurso no encontrado: $message');
        } else {
          return ServerFailure('Error en la solicitud: $message');
        }
      case DioExceptionType.cancel:
        return NetworkFailure('Solicitud cancelada');
      default:
        return NetworkFailure('Error de red: ${e.message}');
    }
  }
}