import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_custom_field.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/constants/app_menu_card.dart';
import 'package:base_project/app/modules/cart/controller/cart_controller.dart';
import 'package:base_project/app/modules/cart/view/cart_screen.dart';
import 'package:base_project/app/modules/menu/controller/menu_controller.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textPrimary),
          onPressed: () {
            // Open drawer or menu
          },
        ),
        title: Column(
          children: [
            Text('Select Menu', style: AppTextStyles.heading3),
            Text(
              'May 14, 2025  12:30pm',
              style: AppTextStyles.caption.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // Open calendar
            },
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
              // Search bar at the top
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomInputField(
                  hintText: 'Search..',
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: AppColors.iconColor,
                  ),
                  onChanged: (value) => menu.setSearchQuery(value),
                ),
              ),

              // Category Header with dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    // Show category selection dialog
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

              // Menu Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: menu.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = menu.filteredItems[index];
                    return MenuItemCard(
                      item: item,
                      onAddPressed: () {},
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
        return SizedBox(
          height: 90,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // Bottom Container
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Left Section - View Cart
                      Expanded(
                        child: InkWell(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CartScreen(),
                                ),
                              ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'View Cart',
                                    style: AppTextStyles.body2.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.credit_card,
                                    size: 16,
                                    color: AppColors.iconColor,
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.qr_code,
                                    size: 16,
                                    color: AppColors.iconColor,
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.payments_outlined,
                                    size: 16,
                                    color: AppColors.iconColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '£ ${cart.items.isEmpty ? "0.00" : cart.total.toStringAsFixed(2)}',
                                    style: AppTextStyles.heading3.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 80),

                      // Right Section - Print Bill
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle print action
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.print_outlined,
                                  color: AppColors.textPrimary,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Print Bill',
                                style: AppTextStyles.body2.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Center Circle Button - Changes icon based on dialog state
              Positioned(
                top: 0,
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
                    width: 64,
                    height: 64,
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
                      size: 28,
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

  void _showCategoryDialog(BuildContext context, MenuViewModel menuViewModel) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Dialog with curved bottom cutout
            Positioned(
              left: 16,
              right: 16,
              top: 60,
              bottom: 100, // Space for the bottom button
              child: Material(
                color: Colors.transparent,
                child: ClipPath(
                  clipper: BottomCircleClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),

                        // Title
                        Text(
                          'Select Category',
                          style: AppTextStyles.heading2.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Categories Grid
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 1,
                                ),
                            itemCount: menuViewModel.categories.length,
                            itemBuilder: (context, index) {
                              final category = menuViewModel.categories[index];
                              return InkWell(
                                onTap: () {
                                  // menuViewModel.setSelectedCategory(category);
                                  Navigator.pop(context);
                                  setState(() => isDialogOpen = false);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.restaurant_menu,
                                        color: AppColors.primary,
                                        size: 32,
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: Text(
                                          category,
                                          style: AppTextStyles.body2.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 80), // Space for bottom curve
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) {
      setState(() => isDialogOpen = false);
    });
  }
}

// Custom clipper for bottom circle cutout
class BottomCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top-left with rounded corner
    path.moveTo(0, 28);
    path.quadraticBezierTo(0, 0, 28, 0);

    // Top edge
    path.lineTo(size.width - 28, 0);

    // Top-right rounded corner
    path.quadraticBezierTo(size.width, 0, size.width, 28);

    // Right edge down to bottom curve
    path.lineTo(size.width, size.height - 10);

    // Right side before curve
    path.lineTo(size.width / 2 + 70, size.height - 10);

    // Smooth curve into the circle cutout
    path.quadraticBezierTo(
      size.width / 2 + 58,
      size.height - 10,
      size.width / 2 + 48,
      size.height + 5,
    );

    // Large semi-circle cutout for button (increased radius)
    path.arcToPoint(
      Offset(size.width / 2 - 48, size.height + 5),
      radius: const Radius.circular(60),
      clockwise: false,
    );

    // Smooth curve out from the circle
    path.quadraticBezierTo(
      size.width / 2 - 58,
      size.height - 10,
      size.width / 2 - 70,
      size.height - 10,
    );

    // Left side of bottom
    path.lineTo(0, size.height - 10);

    // Close path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
