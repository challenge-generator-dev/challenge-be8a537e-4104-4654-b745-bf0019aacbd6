import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/presentation/viewmodels/order_viewmodel.dart';
import 'package:order_app/core/failures/failure.dart';

/// Pantalla principal de pedidos que muestra la lista de pedidos del cliente.
/// Implementa el patrón MVVM utilizando Riverpod para el manejo de estado.
class OrderScreen extends ConsumerStatefulWidget {
  final String customerId;
  const OrderScreen({super.key, required this.customerId});

  @override
  ConsumerState<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends ConsumerState<OrderScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los pedidos al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderViewModelProvider(widget.customerId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
            },
            tooltip: 'Actualizar pedidos',
          ),
        ],
      ),
      body: _buildBody(orderState),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateOrderDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Pedido'),
      ),
    );
  }

  /// Construye el cuerpo de la pantalla según el estado actual.
  Widget _buildBody(OrderViewState state) {
    return switch (state) {
      OrderIdle() => const Center(child: Text('Cargando pedidos...')),
      OrderLoading() => const Center(child: CircularProgressIndicator()),
      OrderLoaded(:final orders) => _buildOrderList(orders),
      OrderOperationSuccess(:final order, :final message) => _buildSuccessView(order, message),
      OrderError(:final failure) => _buildErrorView(failure),
    };
  }

  /// Muestra la lista de pedidos en un ListView.
  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('No tienes pedidos aún', style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 8),
            Text('Toca el botón + para crear tu primer pedido', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderCard(
          order: order,
          onTap: () => _showOrderDetails(order),
          onStatusChange: (newStatus) => _updateOrderStatus(order.id, newStatus),
        );
      },
    );
  }

  /// Muestra una vista de éxito con el pedido modificado.
  Widget _buildSuccessView(Order order, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
    });
    return const Center(child: CircularProgressIndicator());
  }

  /// Muestra la vista de error con el mensaje de Failure.
  Widget _buildErrorView(Failure failure) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error al cargar pedidos',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              failure.message,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(orderViewModelProvider(widget.customerId).notifier).loadOrders();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  /// Muestra los detalles de un pedido específico.
  void _showOrderDetails(Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => _OrderDetailsSheet(
          order: order,
          scrollController: scrollController,
        ),
      ),
    );
  }

  /// Actualiza el estado de un pedido.
  void _updateOrderStatus(String orderId, String newStatus) {
    ref.read(orderViewModelProvider(widget.customerId).notifier).updateOrderStatus(orderId, newStatus);
  }

  /// Muestra el diálogo para crear un nuevo pedido.
  void _showCreateOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _CreateOrderDialog(),
    );
  }
}

/// Tarjeta individual que muestra la información de un pedido.
class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;
  final Function(String) onStatusChange;

  const _OrderCard({
    required this.order,
    required this.onTap,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${order.id.substring(0, 8)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _StatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${order.items.length} producto${order.items.length != 1 ? 's' : ''}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(order.createdAt),
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// Badge que muestra el estado del pedido con color apropiado.
class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      'pending' => (Colors.orange, 'Pendiente'),
      'processing' => (Colors.blue, 'Procesando'),
      'completed' => (Colors.green, 'Completado'),
      'cancelled' => (Colors.red, 'Cancelado'),
      _ => (Colors.grey, status),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Hoja de detalles que muestra información completa de un pedido.
class _OrderDetailsSheet extends StatelessWidget {
  final Order order;
  final ScrollController scrollController;

  const _OrderDetailsSheet({
    required this.order,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Detalles del Pedido',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _DetailRow(label: 'ID', value: order.id),
          _DetailRow(label: 'Cliente', value: order.customerId),
          _DetailRow(label: 'Estado', value: order.status),
          _DetailRow(label: 'Total', value: '\$${order.totalAmount.toStringAsFixed(2)}'),
          _DetailRow(label: 'Creado', value: order.createdAt.toString()),
          if (order.updatedAt != null)
            _DetailRow(label: 'Actualizado', value: order.updatedAt.toString()),
          const SizedBox(height: 24),
          Text(
            'Productos',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...order.items.map((item) => _ItemRow(item: item)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  final OrderItem item;
  const _ItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productId, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text('Cantidad: ${item.quantity}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

/// Diálogo simple para crear un nuevo pedido.
class _CreateOrderDialog extends ConsumerStatefulWidget {
  const _CreateOrderDialog();

  @override
  ConsumerState<_CreateOrderDialog> createState() => _CreateOrderDialogState();
}

class _CreateOrderDialogState extends ConsumerState<_CreateOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _productIdController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final List<OrderItem> _items = [];

  @override
  void dispose() {
    _productIdController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _items.add(OrderItem(
          productId: _productIdController.text,
          quantity: int.parse(_quantityController.text),
          price: double.parse(_priceController.text),
        ));
      });
      _productIdController.clear();
      _quantityController.clear();
      _priceController.clear();
    }
  }

  double get _total => _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear Nuevo Pedido'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _productIdController,
                decoration: const InputDecoration(labelText: 'ID del Producto', border: OutlineInputBorder()),
                validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(labelText: 'Precio', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isEmpty ?? true ? 'Requerido' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Agregar Producto'),
              ),
              if (_items.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text('Productos agregados:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ..._items.asMap().entries.map((e) => ListTile(
                  dense: true,
                  title: Text(e.value.productId),
                  subtitle: Text('Qty: ${e.value.quantity} x \$${e.value.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => setState(() => _items.removeAt(e.key)),
                  ),
                )),
                const Divider(),
                Text('Total: \$${_total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          onPressed: _items.isEmpty
              ? null
              : () {
                  ref.read(orderViewModelProvider('default-customer').notifier).createOrder(_items, _total);
                  Navigator.pop(context);
                },
          child: const Text('Crear Pedido'),
        ),
      ],
    );
  }
}