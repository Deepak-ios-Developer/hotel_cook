import 'package:flutter/material.dart';
import 'package:base_project/models/menu_item_model.dart';

class MenuViewModel extends ChangeNotifier {
  String _selectedCategory = 'Starters';
  String _searchQuery = '';
  
  final List<String> _categories = [
    'Starters',
    'Main Course',
    'Pizza',
    'Burger',
    'Dessert',
    'Bread',
    'Beverages',
    'Kids Menu',
  ];

  final List<MenuItem> _allItems = [
    MenuItem(
      id: '1',
      name: 'Chicken Burger Meal',
      category: 'Starters',
      price: 8.00,
      isFavorite: true,
      imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
    ),
    MenuItem(
      id: '2',
      name: 'Chicken Burger Meal Combo',
      category: 'Starters',
      price: 8.00,
      isFavorite: true,
      imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
    ),
    MenuItem(
      id: '3',
      name: 'Chicken Burger Meal',
      category: 'Starters',
      price: 8.00,
      isFavorite: true,
      imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
    ),
    MenuItem(
      id: '4',
      name: 'Chicken Burger Meal',
      category: 'Starters',
      price: 8.00,
      isFavorite: true,
      imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
    ),
    // Add more items for different categories
    MenuItem(
      id: '5',
      name: 'Margherita Pizza',
      category: 'Pizza',
      price: 12.00,
        
    ),
    MenuItem(
      id: '6',
      name: 'Pepperoni Pizza',
      category: 'Pizza',
      price: 14.00,
    ),
    MenuItem(
      id: '7',
      name: 'Classic Burger',
      category: 'Burger',
      price: 9.00,
    ),
    MenuItem(
      id: '8',
      name: 'Cheese Burger',
      category: 'Burger',
      price: 10.00,
    ),
    MenuItem(
      id: '9',
      name: 'Grilled Chicken',
      category: 'Main Course',
      price: 15.00,
    ),
    MenuItem(
      id: '10',
      name: 'Pasta Carbonara',
      category: 'Main Course',
      price: 13.00,
    ),
    MenuItem(
      id: '11',
      name: 'Chocolate Cake',
      category: 'Dessert',
      price: 6.00,
    ),
    MenuItem(
      id: '12',
      name: 'Ice Cream',
      category: 'Dessert',
      price: 5.00,
    ),
    MenuItem(
      id: '13',
      name: 'Garlic Bread',
      category: 'Bread',
      price: 4.00,
    ),
    MenuItem(
      id: '14',
      name: 'Coca Cola',
      category: 'Beverages',
      price: 2.50,
    ),
    MenuItem(
      id: '15',
      name: 'Chicken Nuggets',
      category: 'Kids Menu',
      price: 7.00,
    ),
  ];

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  List<MenuItem> get filteredItems {
    List<MenuItem> items = _allItems.where((item) {
      return item.category == _selectedCategory;
    }).toList();

    if (_searchQuery.isNotEmpty) {
      items = items.where((item) {
        return item.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return items;
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavorite(String itemId) {
    final item = _allItems.firstWhere((item) => item.id == itemId);
    item.isFavorite = !item.isFavorite;
    notifyListeners();
  }

  void addMenuItem(MenuItem item) {
    _allItems.add(item);
    notifyListeners();
  }

  void removeMenuItem(String itemId) {
    _allItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
}