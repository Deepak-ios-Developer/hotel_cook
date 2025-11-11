import 'package:base_project/app/constants/app_button.dart';
import 'package:base_project/app/constants/app_colors.dart';
import 'package:base_project/app/constants/app_fonts.dart';
import 'package:base_project/app/modules/sales/controller/sales_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDateRangePickerDialog extends StatefulWidget {
  const AppDateRangePickerDialog({Key? key}) : super(key: key);

  @override
  State<AppDateRangePickerDialog> createState() => _AppDateRangePickerDialogState();
}

class _AppDateRangePickerDialogState extends State<AppDateRangePickerDialog> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _displayedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Range', style: AppTextStyles.heading3),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(_getDateRangeText(), style: AppTextStyles.caption),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => setState(() => _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1)),
                ),
                Text('${_getMonthName(_displayedMonth.month)} ${_displayedMonth.year}', style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.w600)),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => setState(() => _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildWeekDays(),
            const SizedBox(height: 8),
            _buildCalendar(),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Filter',
              onPressed: _startDate != null && _endDate != null
                  ? () {
                      Provider.of<SalesViewModel>(context, listen: false).setDateRange(_startDate!, _endDate!);
                      Navigator.pop(context);
                    }
                  : () {},
            ),
          ],
        ),
      ),
    );
  }

  String _getDateRangeText() {
    if (_startDate == null) return 'Select start date';
    if (_endDate == null) return 'Select end date';
    return '${_formatDate(_startDate!)} to ${_formatDate(_endDate!)}';
  }

  Widget _buildWeekDays() {
    const weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays.map((day) => SizedBox(width: 40, child: Center(child: Text(day, style: AppTextStyles.caption)))).toList(),
    );
  }

  Widget _buildCalendar() {
    final firstDay = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDay = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final startWeekday = firstDay.weekday % 7;

    List<Widget> dateWidgets = [];
    for (int i = 0; i < startWeekday; i++) {
      dateWidgets.add(const SizedBox(width: 40, height: 40));
    }

    for (int day = 1; day <= lastDay.day; day++) {
      final date = DateTime(_displayedMonth.year, _displayedMonth.month, day);
      dateWidgets.add(_buildDateCell(date));
    }

    return Wrap(spacing: 0, runSpacing: 8, children: dateWidgets);
  }

  Widget _buildDateCell(DateTime date) {
    final isSelected = (_startDate != null && _isSameDay(date, _startDate!)) || (_endDate != null && _isSameDay(date, _endDate!));
    final isInRange = _startDate != null && _endDate != null && date.isAfter(_startDate!) && date.isBefore(_endDate!);

    return InkWell(
      onTap: () {
        setState(() {
          if (_startDate == null || (_startDate != null && _endDate != null)) {
            _startDate = date;
            _endDate = null;
          } else if (date.isBefore(_startDate!)) {
            _startDate = date;
          } else {
            _endDate = date;
          }
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : (isInRange ? AppColors.primary.withOpacity(0.2) : Colors.transparent),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(fontSize: 14, color: isSelected ? Colors.white : AppColors.textPrimary, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal),
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  String _getMonthName(int month) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
}