import 'package:base_project/app/constants/app_button.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/constants/custom_app_bar.dart';
import 'package:base_project/app/modules/sales/controller/sales_controller.dart';
import 'package:base_project/app/modules/sales/view/date_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'Sales Report', onBackPressed: () => Navigator.pop(context)),
      body: Consumer<SalesViewModel>(
        builder: (context, sales, _) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => _showFilterBottomSheet(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.calendar_today, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sales.selectedFilter, style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                            if (sales.startDate != null)
                              Text(
                                '${_formatDate(sales.startDate!)} to ${_formatDate(sales.endDate!)}',
                                style: AppTextStyles.caption,
                              ),
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total orders', style: AppTextStyles.caption),
                          const SizedBox(height: 8),
                          Text('${sales.totalOrders} Orders', style: AppTextStyles.heading1),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Sales', style: AppTextStyles.caption.copyWith(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('£${sales.totalSales.toStringAsFixed(2)}', style: AppTextStyles.heading2.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text("Today's Order", style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildTabButton('All', sales.selectedTab == 'All', () => sales.setTab('All')),
                  const SizedBox(width: 8),
                  _buildTabButton('Cash', sales.selectedTab == 'Cash', () => sales.setTab('Cash')),
                  const SizedBox(width: 8),
                  _buildTabButton('Card', sales.selectedTab == 'Card', () => sales.setTab('Card')),
                  const SizedBox(width: 8),
                  _buildTabButton('UPI', sales.selectedTab == 'UPI', () => sales.setTab('UPI')),
                ],
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sales.filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = sales.filteredOrders[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ${order.orderNumber}', style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('${order.date}, ${order.time}', style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('£ ${order.amount.toStringAsFixed(2)}', style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  order.paymentMethod == 'Cash'
                                      ? Icons.payments_outlined
                                      : order.paymentMethod == 'UPI'
                                          ? Icons.qr_code
                                          : Icons.credit_card,
                                  size: 14,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  order.status,
                                  style: AppTextStyles.caption.copyWith(
                                    color: order.status == 'Completed' ? AppColors.success : AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Print',
                      icon: Icons.print,
                      isOutlined: true,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Download',
                      icon: Icons.download,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption(context, 'Today'),
            _buildFilterOption(context, 'Yesterday'),
            _buildFilterOption(context, 'This Week'),
            _buildFilterOption(context, 'Last Week'),
            _buildFilterOption(context, 'This Month'),
            _buildFilterOption(context, 'Last Month'),
            _buildFilterOption(context, 'Custom Range', isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String label, {bool isLast = false}) {
    return InkWell(
      onTap: () {
        if (label == 'Custom Range') {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => const AppDateRangePickerDialog(),
          );
        } else {
          Provider.of<SalesViewModel>(context, listen: false).setFilter(label);
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Text(label, style: AppTextStyles.body1),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
}
