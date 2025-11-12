import 'package:base_project/app/constants/app_assets.dart';
import 'package:base_project/app/constants/app_button.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/constants/custom_app_bar.dart';
import 'package:base_project/app/modules/cart/controller/cart_controller.dart';
import 'package:base_project/app/modules/sales/view/sales_report_screen.dart';
import 'package:base_project/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        
        title: 'View Cart',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cart, _) => Column(
          children: [
            /// 🔹 Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Item : ${cart.totalItems}',
                    style: AppTextStyles.body2,
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
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
                          Text(
                            'Add Items',
                            style: AppTextStyles.caption.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 Cart Items List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return Dismissible(
                    key: Key(item.menuItem.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.delete_outline, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Delete', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    onDismissed: (_) => cart.removeItem(item.menuItem.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Item header
                          Row(
                            children: [
                              Image.asset(AppImages.redDot, width: 20, height: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.menuItem.name,
                                  style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                '£ ${item.menuItem.price.toStringAsFixed(2)}',
                                style: AppTextStyles.body1.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Addons : Ritha ,water , pepesi , R..',
                            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Modify',
                                  style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                              const SizedBox(width: 4),
                              const Icon(Icons.edit_square, color: AppColors.primary, size: 14),
                            ],
                          ),
                          const SizedBox(height: 8),

                          /// Quantity Counter
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildQtyButton(
                                icon: Icons.remove,
                                onTap: () => cart.decrementQuantity(item.menuItem.id),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  '${item.quantity}',
                                  style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              _buildQtyButton(
                                icon: Icons.add,
                                onTap: () => cart.incrementQuantity(item.menuItem.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// 🔹 Bottom Summary
            Container(
              padding: const EdgeInsets.all(16),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Subtotal, Tax, Service
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
                  const Divider(height: 24,color: AppColors.border),

                  /// Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppTextStyles.heading3.copyWith(color: AppColors.lightGreen),
                      ),
                      Text(
                        '£ ${cart.total.toStringAsFixed(2)}',
                        style: AppTextStyles.heading2.copyWith(color: AppColors.lightGreen),
                      ),
                    ],
                  ),
                                    const Divider(height: 24,color: AppColors.border),

                  const SizedBox(height: 16),

                  /// 🔹 Payment Methods Row (modern chip style)
                  Row(
                    children: [
                      _buildPaymentCard('Card', Icons.credit_card, cart),
                      const SizedBox(width: 8),
                      _buildPaymentCard('Cash', Icons.payments_outlined, cart),
                      const SizedBox(width: 8),
                      _buildPaymentCard('UPI', Icons.qr_code, cart),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// Print Bill Button
                  PrimaryButton(
                    text: 'Print Bill',
                    icon: Icons.print,
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.salesReport)

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔸 Reusable quantity button
  Widget _buildQtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  /// 🔸 Modern payment card selector
Widget _buildPaymentCard(String method, IconData icon, CartViewModel cart) {
  final isSelected = cart.selectedPaymentMethod == method;

  return Expanded(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => cart.setPaymentMethod(method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔘 Radio Circle
            Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),

            // 💳 Icon
            // Icon(
            //   icon,
            //   color: isSelected ? AppColors.primary : AppColors.textSecondary,
            //   size: 18,
            // ),

            const SizedBox(width: 6),

            // 💬 Label
            Text(
              method,
              style: AppTextStyles.body2.copyWith(
                color:
                    isSelected ? AppColors.primary : AppColors.textPrimary,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
