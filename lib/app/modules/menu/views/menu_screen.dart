import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_custom_field.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/constants/app_menu_card.dart';
import 'package:base_project/app/modules/cart/controller/cart_controller.dart';
import 'package:base_project/app/modules/cart/view/cart_screen.dart';
import 'package:base_project/app/modules/menu/controller/menu_controller.dart';
import 'package:base_project/app/modules/menu/views/product_detail_screen.dart';
import 'package:base_project/app/modules/menu/views/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 70,
        leading: Container(
          margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle, // ✅ Makes it perfectly circular
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.black54,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomSideMenu(),
                  );
                },
              );
            },
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Menu', style: AppTextStyles.heading3),
            const SizedBox(height: 2),
            Text(
              'May 14, 2025  12:30pm',
              style: AppTextStyles.caption.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle, // ✅ Makes it circular
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.save, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: _buildMenuItems(context),
      floatingActionButton: _buildCartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Consumer2<MenuViewModel, CartViewModel>(
      builder:
          (context, menu, cart, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomInputField(
                  hintText: 'Search...',
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: AppColors.iconColor,
                  ),
                  onChanged: (value) => menu.setSearchQuery(value),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    setState(() => isDialogOpen = true);
                    _showCategoryDialog(context, menu);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        menu.selectedCategory,
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.textPrimary,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: menu.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = menu.filteredItems[index];
                    return MenuItemCard(
                      item: item,
                      onAddPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ProductDetailScreen(
                                  productName: item.name,
                                  price: item.price,
                                ),
                          ),
                        );
                      },
                      onFavoritePressed: () => menu.toggleFavorite(item.id),
                    );
                  },
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildCartButton(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cart, _) {
        return Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Main content container
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 20,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: Column(
                    children: [
                      // Top section with View Cart and Payment Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CartScreen(),
                                  ),
                                ),
                            child: const Text(
                              'View Cart',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Card',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Cash',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'UPI',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      // Bottom section with Total and Print Bill
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '£ ${cart.items.isEmpty ? "0.00" : cart.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.print_outlined,
                                    color: AppColors.textSecondary,
                                    size: 22,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Print Bill',
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Floating button
              Positioned(
                top: -35,
                child: InkWell(
                  onTap: () {
                    if (isDialogOpen) {
                      Navigator.pop(context);
                      setState(() => isDialogOpen = false);
                    } else {
                      setState(() => isDialogOpen = true);
                      _showCategoryDialog(
                        context,
                        Provider.of<MenuViewModel>(context, listen: false),
                      );
                    }
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      isDialogOpen ? Icons.close : Icons.apps,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ✅ Updated Dialog with proper bottom curve cutout
  void _showCategoryDialog(BuildContext context, MenuViewModel menuViewModel) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: 16,
              right: 16,
              top: 150,
              bottom: 180, // Adjusted to account for button container
              child: Material(
                color: Colors.transparent,
                child: ClipPath(
                  clipper: BottomCircleClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                        top: 16,
                        bottom: 40, // Extra padding for curve
                        left: 16,
                        right: 16,
                      ),
                      shrinkWrap: true,
                      itemCount: menuViewModel.categories.length,
                      separatorBuilder:
                          (context, index) =>
                              Divider(color: Colors.grey.shade300, height: 1),
                      itemBuilder: (context, index) {
                        final category = menuViewModel.categories[index];
                        return InkWell(
                          onTap: () {
                            // menuViewModel.setSelectedCategory(category);
                            Navigator.pop(context);
                            setState(() => isDialogOpen = false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) => setState(() => isDialogOpen = false));
  }
}

/// 🔹 Custom clipper for curved bottom (for floating button cutout)
class BottomCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Rounded top-left corner
    path.moveTo(0, 20);
    path.quadraticBezierTo(0, 0, 20, 0);

    // Top edge
    path.lineTo(size.width - 20, 0);

    // Rounded top-right corner
    path.quadraticBezierTo(size.width, 0, size.width, 20);

    // Right edge down
    path.lineTo(size.width, size.height - 20);

    // Move towards center before the curve (from right)
    path.lineTo(size.width / 2 + 120, size.height - 20);

    // Smooth transition into the curve (right side)
    path.quadraticBezierTo(
      size.width / 2 + 80,
      size.height - 20,
      size.width / 2 + 60,
      size.height,
    );

    // Semi-circle cutout for the button
    path.arcToPoint(
      Offset(size.width / 2 - 60, size.height),
      radius: const Radius.circular(60),
      clockwise: false,
    );

    // Smooth transition out of the curve (left side)
    path.quadraticBezierTo(
      size.width / 2 - 80,
      size.height - 20,
      size.width / 2 - 120,
      size.height - 20,
    );

    // Left edge back up
    path.lineTo(0, size.height - 20);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
