import 'package:base_project/models/menu_item_model.dart';
import 'package:flutter/material.dart';

class CartItem {
  final MenuItem menuItem;
  int quantity;

  CartItem({required this.menuItem, this.quantity = 1});
}

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;
  double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.menuItem.price * item.quantity);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get tax => subtotal * 0.1;
  double get serviceCharge => subtotal * 0.05;
  double get total => subtotal + tax + serviceCharge;

  String selectedPaymentMethod = 'Card';

  void addItem(MenuItem item) {
    final index = _items.indexWhere((e) => e.menuItem.id == item.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(menuItem: item));
    }
    notifyListeners();
  }

  void incrementQuantity(String id) {
    final index = _items.indexWhere((e) => e.menuItem.id == id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String id) {
    final index = _items.indexWhere((e) => e.menuItem.id == id);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  void removeItem(String id) {
    _items.removeWhere((e) => e.menuItem.id == id);
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
