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
                GlobalKey _filterKey = GlobalKey();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Sales Report',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Consumer<SalesViewModel>(
        builder: (context, sales, _) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Date Selection Container (Full Width)
InkWell(
  splashColor: Colors.transparent,
  key: _filterKey,
  onTap: () {
    final RenderBox renderBox =
        _filterKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    OverlayEntry? overlay;

    overlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 🔹 Transparent layer to detect outside taps
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                overlay?.remove(); // ✅ closes dropdown when tapping outside
              },
              child: Container(color: Colors.transparent),
            ),
          ),

          // 🔹 Dropdown content
          Positioned(
            left: position.dx,
            top: position.dy + size.height + 0,
            width: size.width,
            child: Material(
              color: Colors.transparent,
              child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                        border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(16),

                  
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDropdownItem(context, 'Today', overlay!),
                    _buildDropdownItem(context, 'Yesterday', overlay!),
                    _buildDropdownItem(context, 'This Week', overlay!),
                    _buildDropdownItem(context, 'Last Week', overlay!),
                    _buildDropdownItem(context, 'This Month', overlay!),
                    _buildDropdownItem(context, 'Last Month', overlay!),
                    _buildDropdownItem(context, 'Custom Range', overlay!, isLast: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(overlay);
  },
  child: Container(
    height: 70,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(Icons.calendar_month, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            sales.selectedFilter,
            style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
      ],
    ),
  ),
),





              const SizedBox(height: 16),

              /// 🔹 Total Orders & Total Sales Side by Side
              Row(
                children: [
                  // Total Orders Box
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Orders', style: AppTextStyles.caption),
                          const SizedBox(height: 6),
                          Text(
                            '${sales.totalOrders} Orders',
                            style: AppTextStyles.heading2
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Total Sales Box
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Sales',
                              style: AppTextStyles.caption
                                  .copyWith(color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(
                            '£${sales.totalSales.toStringAsFixed(2)}',
                            style: AppTextStyles.heading2.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Text("Today's Order", style: AppTextStyles.heading3),
              const SizedBox(height: 16),

              /// 🔹 Filter Tabs (All, Cash, Card, UPI)
              Row(
                children: [
                  _buildTabButton('All', sales.selectedTab == 'All',
                      () => sales.setTab('All')),
                  const SizedBox(width: 8),
                  _buildTabButton('Cash', sales.selectedTab == 'Cash',
                      () => sales.setTab('Cash')),
                  const SizedBox(width: 8),
                  _buildTabButton('Card', sales.selectedTab == 'Card',
                      () => sales.setTab('Card')),
                  const SizedBox(width: 8),
                  _buildTabButton('UPI', sales.selectedTab == 'UPI',
                      () => sales.setTab('UPI')),
                ],
              ),
              const SizedBox(height: 16),

              /// 🔹 Orders List
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
                        // Order Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ${order.orderNumber}',
                                  style: AppTextStyles.body1
                                      .copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text('${order.date} | ${order.time}',
                                      style: AppTextStyles.caption),
                                  const SizedBox(width: 12),
                                       Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 4),
                                  
                                  child: Text(
                                    order.status,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: order.status == 'Completed'
                                          ? AppColors.success
                                          : AppColors.error,
                                    ),
                                  ),
                                ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Amount + Status
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('£ ${order.amount.toStringAsFixed(2)}',
                                style: AppTextStyles.body1
                                    .copyWith(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                               
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                     Icon(
                                      order.paymentMethod == 'Cash'
                                          ? Icons.payments_outlined
                                          : order.paymentMethod == 'UPI'
                                              ? Icons.qr_code
                                              : Icons.credit_card,
                                      size: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                                                        const SizedBox(width: 4),

                                    Text(order.paymentMethod,
                                        style: AppTextStyles.caption),
                                   
                                  ],
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

              const SizedBox(height: 5),

              /// 🔹 Bottom Buttons
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
                                const SizedBox(height: 5),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
Widget _buildDropdownItem(
    BuildContext context, String label, OverlayEntry overlay,
    {bool isLast = false}) {
  return InkWell(
    onTap: () {
      overlay.remove(); // ✅ still works fine
      if (label == 'Custom Range') {
        showDialog(
          context: context,
          builder: (context) => const AppDateRangePickerDialog(),
        );
      } else {
        Provider.of<SalesViewModel>(context, listen: false).setFilter(label);
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: AppTextStyles.body1.copyWith(color: AppColors.textPrimary),
        ),
      ),
    ),
  );
}


  /// 🔹 Tab Button Builder
  Widget _buildTabButton(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          label,
          style: AppTextStyles.body2.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 🔹 Bottom Filter Sheet
  void _showFilterBottomSheet(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dialog Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Date Range',
                      style: AppTextStyles.heading3
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.border),

              // Filter Options
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
    },
  );
}


  Widget _buildFilterOption(BuildContext context, String label,
      {bool isLast = false}) {
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
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: AppColors.border)),
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
