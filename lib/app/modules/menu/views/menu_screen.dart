import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_custom_field.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/constants/app_menu_card.dart';
import 'package:base_project/app/modules/cart/controller/cart_controller.dart';
import 'package:base_project/app/modules/cart/view/cart_screen.dart';
import 'package:base_project/app/modules/menu/controller/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.menu, color: AppColors.textPrimary), onPressed: () {}),
        title: Column(
          children: [
            Text('Select Menu', style: AppTextStyles.heading3),
            Text('May 14, 2025  12:30pm', style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today_outlined, color: AppColors.textPrimary), onPressed: () {}),
        ],
      ),
      body: Row(
        children: [
          _buildCategoryMenu(context),
          Expanded(child: _buildMenuItems(context)),
        ],
      ),
      floatingActionButton: _buildCartButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildCategoryMenu(BuildContext context) {
    return Container(
      width: 140,
      color: AppColors.surface,
      child: Consumer<MenuViewModel>(
        builder: (context, menu, _) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomInputField(hintText: 'Search..', prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.iconColor)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menu.categories.length,
                itemBuilder: (context, index) {
                  final category = menu.categories[index];
                  final isSelected = menu.selectedCategory == category;
                  return InkWell(
                    onTap: () => menu.setCategory(category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              category,
                              style: AppTextStyles.body2.copyWith(
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ),
                          if (index == 0 || index == 2 || index == 5 || index == 7)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.white : AppColors.redIndicator,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Consumer2<MenuViewModel, CartViewModel>(
      builder: (context, menu, cart, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(menu.selectedCategory, style: AppTextStyles.heading3),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     itemCount: menu.filteredItems.length,
          //     itemBuilder: (context, index) {
          //       final item = menu.filteredItems[index] ?? 0;
          //       return MenuItemCard(
          //         item: item,
          //         onAddPressed: () => cart.addItem(item),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildCartButton(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cart, _) => cart.items.isEmpty
          ? const SizedBox.shrink()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Text('View Cart', style: AppTextStyles.button),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.credit_card, size: 16, color: AppColors.primary),
                            const SizedBox(width: 4),
                            Text('Card', style: AppTextStyles.caption),
                            const SizedBox(width: 12),
                            const Icon(Icons.payments_outlined, size: 16, color: AppColors.iconColor),
                            const SizedBox(width: 4),
                            Text('Cash', style: AppTextStyles.caption),
                            const SizedBox(width: 12),
                            const Icon(Icons.qr_code, size: 16, color: AppColors.iconColor),
                            const SizedBox(width: 4),
                            Text('UPI', style: AppTextStyles.caption),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('Total', style: AppTextStyles.caption),
                        Text('£ ${cart.total.toStringAsFixed(2)}', style: AppTextStyles.heading2),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                    ),
                    child: const Icon(Icons.print_outlined, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
    );
  }
}