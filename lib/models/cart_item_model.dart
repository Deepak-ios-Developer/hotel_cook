import 'package:base_project/models/user_model.dart';

class CartItemModel {
  final MenuItemModel menuItem;
  int quantity;
  String? selectedVariation;
  List<String> selectedAddons;
  
  CartItemModel({
    required this.menuItem,
    this.quantity = 1,
    this.selectedVariation,
    this.selectedAddons = const [],
  });
  
  double get totalPrice => menuItem.price * quantity;
}
