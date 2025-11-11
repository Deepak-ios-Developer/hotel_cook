import 'package:base_project/app/constants/app_assets.dart';
import 'package:base_project/models/menu_item_model.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  final VoidCallback onAddPressed;
  final VoidCallback? onFavoritePressed;

  const MenuItemCard({
    Key? key,
    required this.item,
    required this.onAddPressed,
    this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 🔹 Red Dot (Top Right Corner)
          Positioned(
            top: 8,
            right: 8,
            child: Image.asset(
              AppImages.redDot,
              width: 10,
              height: 10,
            ),
          ),

          // 🔹 Main Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼 Item Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 65,
                  height: 65,
                  color: AppColors.background,
                  child: item.imageUrl != null
                      ? Image.network(
                          item.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                ),
              ),
              const SizedBox(width: 12),

              // 🔹 Item Info + Price + Add Button
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item Name
                    Text(
                      item.name,
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Price + Add Button in Same Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '£ ${item.price.toStringAsFixed(2)}',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: onAddPressed,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 6), // 🔹 Reduced height
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Add',
                              style: AppTextStyles.button.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.background,
      child: const Icon(
        Icons.fastfood,
        color: AppColors.iconColor,
        size: 28,
      ),
    );
  }
}
