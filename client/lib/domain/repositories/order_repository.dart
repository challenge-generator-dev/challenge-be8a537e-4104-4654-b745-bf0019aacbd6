import '../entities/order.dart';
import '../../data/repositories/order_repository_impl.dart';

abstract class OrderRepository {
  Future<OrderListResult> getOrders(String customerId);
  Future<OrderResult> getOrderById(String orderId);
  Future<OrderResult> createOrder(Order order);
  Future<OrderResult> updateOrder(Order order);
}