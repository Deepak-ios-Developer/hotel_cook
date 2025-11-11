import 'package:base_project/models/cart_item_model.dart';
import 'package:base_project/models/user_model.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  List<CartItemModel> _items = [];
  String _selectedPaymentMethod = 'Card';
  
  List<CartItemModel> get items => _items;
  String get selectedPaymentMethod => _selectedPaymentMethod;
  
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  
  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.1;
  double get serviceCharge => 50.0;
  double get total => subtotal + tax + serviceCharge;
  
  void addItem(MenuItemModel menuItem) {
    final existingIndex = _items.indexWhere((item) => item.menuItem.id == menuItem.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItemModel(menuItem: menuItem));
    }
    notifyListeners();
  }
  
  void removeItem(String id) {
    _items.removeWhere((item) => item.menuItem.id == id);
    notifyListeners();
  }
  
  void incrementQuantity(String id) {
    final item = _items.firstWhere((item) => item.menuItem.id == id);
    item.quantity++;
    notifyListeners();
  }
  
  void decrementQuantity(String id) {
    final item = _items.firstWhere((item) => item.menuItem.id == id);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeItem(id);
    }
    notifyListeners();
  }
  
  void setPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
