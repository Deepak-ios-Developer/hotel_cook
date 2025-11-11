import 'package:base_project/models/order_model.dart';
import 'package:flutter/material.dart';

class SalesViewModel extends ChangeNotifier {
  String _selectedFilter = 'Today';
  String _selectedTab = 'All';
  DateTime? _startDate;
  DateTime? _endDate;
  
  String get selectedFilter => _selectedFilter;
  String get selectedTab => _selectedTab;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  
  final List<OrderModel> orders = [
    OrderModel(orderNumber: '#123', date: '06-12-2025', time: '10:09 PM', amount: 250.00, status: 'Completed', paymentMethod: 'Card'),
    OrderModel(orderNumber: '#123', date: '06-12-2025', time: '10:09 PM', amount: 250.00, status: 'Pending', paymentMethod: 'Card'),
    OrderModel(orderNumber: '#123', date: '06-12-2025', time: '10:09 PM', amount: 250.00, status: 'Completed', paymentMethod: 'Cash'),
    OrderModel(orderNumber: '#123', date: '06-12-2025', time: '10:09 PM', amount: 250.00, status: 'Completed', paymentMethod: 'UPI'),
  ];
  
  int get totalOrders => filteredOrders.length;
  double get totalSales => filteredOrders.fold(0, (sum, order) => sum + order.amount);
  
  List<OrderModel> get filteredOrders {
    if (_selectedTab == 'All') return orders;
    return orders.where((order) => order.paymentMethod == _selectedTab).toList();
  }
  
  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
  
  void setTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }
  
  void setDateRange(DateTime start, DateTime end) {
    _startDate = start;
    _endDate = end;
    _selectedFilter = 'Custom Range Filter';
    notifyListeners();
  }
}
