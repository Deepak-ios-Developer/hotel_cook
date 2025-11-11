import 'package:base_project/models/user_model.dart';
import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier {
  String _selectedCategory = 'Starters';
  
  String get selectedCategory => _selectedCategory;
  
  final List<String> categories = [
    'Starters',
    'Main Course',
    'Pizza',
    'Burger',
    'Desert',
    'Bread',
    'Beverages',
    'Kids Menu',
  ];
  
  final List<MenuItemModel> menuItems = [
    MenuItemModel(
      id: '1',
      name: 'Chicken Burger Meal',
      price: 8.00,
      originalPrice: '£10.00',
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Starters',
      hasIndicator: true,
    ),
    MenuItemModel(
      id: '2',
      name: 'Chicken Burger Meal combo',
      price: 8.00,
      originalPrice: '£10.00',
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Starters',
      hasIndicator: true,
    ),
    MenuItemModel(
      id: '3',
      name: 'Chicken Burger Meal',
      price: 8.00,
      originalPrice: '£10.00',
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Starters',
      hasIndicator: true,
    ),
    MenuItemModel(
      id: '4',
      name: 'Chicken Burger Meal',
      price: 8.00,
      originalPrice: '£10.00',
      imageUrl: 'https://via.placeholder.com/150',
      category: 'Starters',
      hasIndicator: true,
    ),
  ];
  
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
  
  List<MenuItemModel> get filteredItems {
    return menuItems.where((item) => item.category == _selectedCategory).toList();
  }
}
