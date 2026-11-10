import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';
import 'package:order_app/core/failures/failure.dart';

/// Estado que representa el resultado de una operación sobre pedidos.
/// Puede ser idle, loading, success (con datos) o error (con Failure).
sealed class OrderViewState {
  const OrderViewState();
}

class OrderIdle extends OrderViewState {
  const OrderIdle();
}

class OrderLoading extends OrderViewState {
  const OrderLoading();
}

class OrderLoaded extends OrderViewState {
  final List<Order> orders;
  const OrderLoaded(this.orders);
}

class OrderOperationSuccess extends OrderViewState {
  final Order order;
  final String message;
  const OrderOperationSuccess(this.order, this.message);
}

class OrderError extends OrderViewState {
  final Failure failure;
  const OrderError(this.failure);
}

/// ViewModel que gestiona el estado de la pantalla de pedidos.
/// Utiliza Riverpod para la inyección de dependencias y manejo de estado reactivo.
class OrderViewModel extends StateNotifier<OrderViewState> {
  final OrderRepository _orderRepository;
  final String customerId;

  OrderViewModel(this._orderRepository, this.customerId) : super(const OrderIdle());

  /// Carga todos los pedidos del cliente actual.
  /// Este método consulta el repositorio y actualiza el estado según el resultado.
  Future<void> loadOrders() async {
    state = const OrderLoading();
    final result = await _orderRepository.getOrders(customerId);
    result.fold(
      (failure) => state = OrderError(failure),
      (orders) => state = OrderLoaded(orders),
    );
  }

  /// Carga un pedido específico por su ID.
  /// Útil para ver los detalles de un pedido individual.
  Future<void> loadOrderById(String orderId) async {
    state = const OrderLoading();
    final result = await _orderRepository.getOrderById(orderId);
    result.fold(
      (failure) => state = OrderError(failure),
      (order) => state = OrderOperationSuccess(order, 'Pedido cargado correctamente'),
    );
  }

  /// Crea un nuevo pedido en el sistema.
  /// El pedido se construye con los items proporcionados y se envía al repositorio.
  Future<void> createOrder(List<OrderItem> items, double totalAmount) async {
    state = const OrderLoading();
    final order = Order(
      id: '',
      customerId: customerId,
      items: items,
      totalAmount: totalAmount,
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: null,
    );
    final result = await _orderRepository.createOrder(order);
    result.fold(
      (failure) => state = OrderError(failure),
      (createdOrder) => state = OrderOperationSuccess(createdOrder, 'Pedido creado correctamente'),
    );
  }

  /// Actualiza el estado de un pedido existente.
  /// Comúnmente usado para cambiar el estado (cancelado, completado, etc.).
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    state = const OrderLoading();
    final getResult = await _orderRepository.getOrderById(orderId);
    await getResult.fold(
      (failure) async => state = OrderError(failure),
      (existingOrder) async {
        final updatedOrder = Order(
          id: existingOrder.id,
          customerId: existingOrder.customerId,
          items: existingOrder.items,
          totalAmount: existingOrder.totalAmount,
          status: newStatus,
          createdAt: existingOrder.createdAt,
          updatedAt: DateTime.now(),
        );
        final updateResult = await _orderRepository.updateOrder(updatedOrder);
        updateResult.fold(
          (failure) => state = OrderError(failure),
          (order) => state = OrderOperationSuccess(order, 'Pedido actualizado correctamente'),
        );
      },
    );
  }

  /// Reinicia el estado a idle.
  /// Útil cuando se quiere limpiar el estado después de mostrar un mensaje al usuario.
  void resetState() {
    state = const OrderIdle();
  }
}

/// Proveedor de familia que crea una instancia de OrderViewModel por cada customerId.
/// Permite que múltiples clientes tengan su propio estado aislado.
final orderViewModelProvider = StateNotifierProvider.family<OrderViewModel, OrderViewState, String>(
  (ref, customerId) {
    final orderRepository = ref.watch(orderRepositoryProvider);
    return OrderViewModel(orderRepository, customerId);
  },
);

/// Proveedor del repositorio de pedidos.
/// En una implementación real, este provider se configuraría con la dependencia real.
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  throw UnimplementedError('El provider de OrderRepository debe ser sobreescrito en main.dart');
});