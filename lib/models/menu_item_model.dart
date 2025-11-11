class MenuItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final String? imageUrl;
   bool isFavorite;

  MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.imageUrl,
    this.isFavorite = false,
  });
}
