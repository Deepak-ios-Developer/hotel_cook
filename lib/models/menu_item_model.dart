class MenuItemModel {
  final String id;
  final String name;
  final double price;
  final String? originalPrice;
  final String imageUrl;
  final String category;
  final bool hasIndicator;
  
  MenuItemModel({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.category,
    this.hasIndicator = false,
  });
}
