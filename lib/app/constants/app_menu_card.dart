import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/models/user_model.dart' show MenuItemModel;
import 'package:flutter/material.dart';

import 'app_fonts.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItemModel item;
  final VoidCallback onAddPressed;

  const MenuItemCard({Key? key, required this.item, required this.onAddPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 60, color: AppColors.background, child: const Icon(Icons.restaurant, color: AppColors.iconColor))),
              ),
              if (item.hasIndicator)
                Positioned(top: 4, right: 4, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.redIndicator, shape: BoxShape.circle))),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('£ ${item.price.toStringAsFixed(2)}', style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600)),
                    if (item.originalPrice != null) ...[
                      const SizedBox(width: 8),
                      Text(item.originalPrice!, style: AppTextStyles.caption.copyWith(decoration: TextDecoration.lineThrough)),
                    ],
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            height: 36,
            child: ElevatedButton(
              onPressed: onAddPressed,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              child: const Text('Add', style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
