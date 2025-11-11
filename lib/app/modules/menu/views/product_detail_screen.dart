import 'package:base_project/app/constants/app_assets.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/modules/cart/controller/cart_controller.dart';
import 'package:base_project/models/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final double price;

  const ProductDetailScreen({
    Key? key,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  String? selectedVariation;
  String comment = '';

  final List<Map<String, dynamic>> variations = [
    {'name': 'Pepsi', 'price': 2.00},
    {'name': 'Pepsi Max', 'price': 2.00},
    {'name': 'Diet Pepsi', 'price': 2.00},
    {'name': 'Tango Orange', 'price': 2.00},
    {'name': 'Tango Apple', 'price': 2.00},
  ];

  double get totalPrice => widget.price * quantity;

  double get finalPrice {
    if (selectedVariation != null) {
      final variationPrice = variations.firstWhere(
        (v) => v['name'] == selectedVariation,
      )['price'];
      return totalPrice + variationPrice;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Container(
  margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
  decoration: BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: IconButton(
    icon: const Icon(
      Icons.chevron_left,
      color: AppColors.textPrimary,
      size: 26,
    ),
    onPressed: () => Navigator.pop(context),
  ),
)
,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          Image(
              image: const AssetImage(AppImages.redDot),
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Text(
              widget.productName,
              style: AppTextStyles.heading2,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Quantity Section
                Container(
          color: Colors.white,
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Left Price
      Text(
        '£ ${widget.price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),

      // Quantity Section
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Minus Button
            GestureDetector(
              onTap: () {
                if (quantity > 1) {
                  setState(() => quantity--);
                }
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF5F5F5),
                ),
                child: const Icon(Icons.remove, color: Colors.red, size: 20),
              ),
            ),

            // Quantity Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Plus Button
            GestureDetector(
              onTap: () => setState(() => quantity++),
              child: Container(
                width: 36,
                height: 36,
                 decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF5F5F5),
                ),
                child: const Icon(Icons.add, color: AppColors.lightGreen, size: 22),
              ),
            ),
          ],
        ),
      ),

      // Right Price
      Text(
        '£ ${finalPrice.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
      ),
    ],
  ),
),


                  const SizedBox(height: 16),
Divider(color: Colors.grey.shade100, height: 1),
                  const SizedBox(height: 16),

                  // Variations Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Variations',
                          style: AppTextStyles.heading3,
                        ),
                        const Spacer(),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                         
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 16,
                                color: Colors.green.shade600,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Required',
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                                    const SizedBox(height: 16),

Divider(color: Colors.grey.shade100, height: 1),

                  const SizedBox(height: 16),

                  // Variation Options
                  Container(
                    color: Colors.white,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: variations.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade100,
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      itemBuilder: (context, index) {
                        final variation = variations[index];
                        final isSelected = selectedVariation == variation['name'];

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedVariation = variation['name'];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  variation['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '£ ${variation['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.grey.shade300,
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.circle,
                                          size: 12,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Comment Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Comment',
                      style: AppTextStyles.heading3,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border
                      )),
                      child: TextField(
                        maxLines: 4,
                        onChanged: (value) => comment = value,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add a cooking instructions for the chef',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade400,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: selectedVariation != null
    ? () {
        final cart = Provider.of<CartViewModel>(context, listen: false);

        // Create a menu item manually (or use your actual model)
        final newItem = MenuItem(
          id: widget.productName, // Or use real ID if available
          name: widget.productName,
          price: widget.price, category: '',
        );

        // Add to cart
        cart.addItem(newItem);

        Navigator.pop(context);
      }
    : null,

            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Add',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}