class OrderModel {
  final String orderNumber;
  final String date;
  final String time;
  final double amount;
  final String status;
  final String paymentMethod;
  
  OrderModel({
    required this.orderNumber,
    required this.date,
    required this.time,
    required this.amount,
    required this.status,
    required this.paymentMethod,
  });
}
