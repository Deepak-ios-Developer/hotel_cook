import 'package:base_project/app/constants/app_button.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/constants/custom_app_bar.dart';
import 'package:base_project/app/modules/cart/controller/cart_controller.dart';
import 'package:base_project/app/modules/sales/view/sales_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'View Cart', onBackPressed: () => Navigator.pop(context)),
      body: Consumer<CartViewModel>(
        builder: (context, cart, _) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Item : ${cart.totalItems}', style: AppTextStyles.body2),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          Text('Add Items', style: AppTextStyles.caption.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (item.menuItem.hasIndicator)
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: const BoxDecoration(
                                  color: AppColors.redIndicator,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Expanded(
                              child: Text(item.menuItem.name, style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                            ),
                            Text('£ ${item.menuItem.price.toStringAsFixed(2)}', style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () => cart.removeItem(item.menuItem.id),
                              child: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Addons : Rthro ,water , pepesi , R..', style: AppTextStyles.caption),
                        Text('Modify ✓', style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => cart.decrementQuantity(item.menuItem.id),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.remove, color: Colors.white, size: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text('${item.quantity}', style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                            ),
                            InkWell(
                              onTap: () => cart.incrementQuantity(item.menuItem.id),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(Icons.add, color: Colors.white, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total', style: AppTextStyles.body2),
                      Text('£ ${cart.subtotal.toStringAsFixed(2)}', style: AppTextStyles.body2),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('TAX', style: AppTextStyles.body2),
                      Text('£ ${cart.tax.toStringAsFixed(2)}', style: AppTextStyles.body2),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service charges', style: AppTextStyles.body2),
                      Text('£ ${cart.serviceCharge.toStringAsFixed(2)}', style: AppTextStyles.body2),
                    ],
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.heading3.copyWith(color: AppColors.primary)),
                      Text('£ ${cart.total.toStringAsFixed(2)}', style: AppTextStyles.heading2.copyWith(color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildPaymentMethodButton(context, 'Card', Icons.credit_card, cart),
                      const SizedBox(width: 8),
                      _buildPaymentMethodButton(context, 'Cash', Icons.payments_outlined, cart),
                      const SizedBox(width: 8),
                      _buildPaymentMethodButton(context, 'UPI', Icons.qr_code, cart),
                    ],
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: 'Print Bill',
                    icon: Icons.print,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SalesReportScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton(BuildContext context, String method, IconData icon, CartViewModel cart) {
    final isSelected = cart.selectedPaymentMethod == method;
    return Expanded(
      child: InkWell(
        onTap: () => cart.setPaymentMethod(method),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.white : AppColors.iconColor, size: 18),
              const SizedBox(width: 6),
              Text(method, style: AppTextStyles.body2.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}
