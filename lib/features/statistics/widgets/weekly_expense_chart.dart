import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';

/// DTO dữ liệu chi tiêu theo từng ngày trong tuần
class DayExpenseData {
  final DateTime date;
  final String label; // T2, T3, T4...
  final double amount;
  final bool isToday;

  const DayExpenseData({
    required this.date,
    required this.label,
    required this.amount,
    required this.isToday,
  });
}

/// Biểu đồ cột thể hiện chi tiêu 7 ngày trong tuần
/// Đồ án yêu cầu:
/// - Lập trình thuần bằng Flutter CustomPainter & Canvas API
/// - Có hiệu ứng hoạt họa (Animation) mọc từ đáy lên
/// - Tương tác chạm vào từng cột để xem tooltip số tiền chi tiêu
/// - Thích ứng hoàn hảo với cả Light Mode và Dark Mode
class WeeklyExpenseChart extends StatefulWidget {
  final List<DayExpenseData> weeklyData;

  const WeeklyExpenseChart({
    super.key,
    required this.weeklyData,
  });

  @override
  State<WeeklyExpenseChart> createState() => _WeeklyExpenseChartState();
}

class _WeeklyExpenseChartState extends State<WeeklyExpenseChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant WeeklyExpenseChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weeklyData != widget.weeklyData) {
      _controller.reset();
      _controller.forward();
      _selectedIndex = null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxAmount = widget.weeklyData.fold(
      0.0,
      (max, day) => day.amount > max ? day.amount : max,
    );

    // Tính tổng chi tiêu trong tuần
    final totalWeek = widget.weeklyData.fold(0.0, (sum, day) => sum + day.amount);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: context.isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tiêu đề & Tổng chi trong tuần
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chi tiêu trong tuần',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.weeklyData.isNotEmpty
                        ? 'Thứ 2 - CN (${AppFormatter.formatDate(widget.weeklyData.first.date)} - ${AppFormatter.formatDate(widget.weeklyData.last.date)})'
                        : 'Thứ 2 - Chủ nhật',
                    style: TextStyle(fontSize: 11.5, color: context.textSecondary),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppFormatter.formatCurrency(totalWeek),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: context.isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                  Text(
                    'Tổng tuần',
                    style: TextStyle(fontSize: 11, color: context.textMuted),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Hiển thị thông tin cột được chạm vào
          if (_selectedIndex != null && _selectedIndex! < widget.weeklyData.length) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: context.isDark ? AppColors.primaryContainerDark : AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.weeklyData[_selectedIndex!].label} (${AppFormatter.formatDate(widget.weeklyData[_selectedIndex!].date)})',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: context.isDark ? Colors.white : AppColors.primaryDark,
                    ),
                  ),
                  Text(
                    AppFormatter.formatCurrency(widget.weeklyData[_selectedIndex!].amount),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: context.isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: 6),
          ],

          // Vùng vẽ Biểu đồ cột CustomPainter
          SizedBox(
            height: 160,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return GestureDetector(
                  onTapUp: (details) {
                    final renderBox = context.findRenderObject() as RenderBox?;
                    if (renderBox == null) return;
                    final width = renderBox.size.width;
                    final itemWidth = width / widget.weeklyData.length;
                    final index = (details.localPosition.dx / itemWidth).floor();
                    if (index >= 0 && index < widget.weeklyData.length) {
                      setState(() {
                        _selectedIndex = _selectedIndex == index ? null : index;
                      });
                    }
                  },
                  child: CustomPaint(
                    size: const Size(double.infinity, 160),
                    painter: _WeeklyBarChartPainter(
                      data: widget.weeklyData,
                      maxAmount: maxAmount > 0 ? maxAmount : 100000,
                      animationProgress: _animation.value,
                      selectedIndex: _selectedIndex,
                      trackColor: context.surfaceVariantBg,
                      gridColor: context.borderColor,
                      textColor: context.textSecondary,
                      textPrimaryColor: context.textPrimary,
                      primaryColor: context.isDark ? AppColors.primaryLight : AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// CustomPainter vẽ các cột biểu đồ thuần Canvas
class _WeeklyBarChartPainter extends CustomPainter {
  final List<DayExpenseData> data;
  final double maxAmount;
  final double animationProgress;
  final int? selectedIndex;
  final Color trackColor;
  final Color gridColor;
  final Color textColor;
  final Color textPrimaryColor;
  final Color primaryColor;

  _WeeklyBarChartPainter({
    required this.data,
    required this.maxAmount,
    required this.animationProgress,
    this.selectedIndex,
    required this.trackColor,
    required this.gridColor,
    required this.textColor,
    required this.textPrimaryColor,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final bottomPadding = 24.0;
    final topPadding = 16.0;
    final chartHeight = size.height - bottomPadding - topPadding;
    final count = data.length;
    final slotWidth = size.width / count;
    final barWidth = 18.0;

    // 1. Vẽ đường lưới ngang (Grid lines mờ)
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 3; i++) {
      final y = topPadding + (chartHeight * (i / 3));
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // 2. Vẽ từng cột chi tiêu
    for (int i = 0; i < count; i++) {
      final day = data[i];
      final isSelected = selectedIndex == i;
      final centerX = (i * slotWidth) + (slotWidth / 2);

      // Cột nền phía sau (Background Track)
      final trackRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          centerX - (barWidth / 2),
          topPadding,
          barWidth,
          chartHeight,
        ),
        const Radius.circular(6),
      );
      final trackPaint = Paint()..color = trackColor;
      canvas.drawRRect(trackRect, trackPaint);

      // Cột giá trị thực tế (Active Bar)
      final normalizedHeight = (day.amount / maxAmount) * chartHeight * animationProgress;
      final barTop = topPadding + chartHeight - normalizedHeight;

      if (normalizedHeight > 0) {
        final barRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            centerX - (barWidth / 2),
            barTop,
            barWidth,
            normalizedHeight,
          ),
          const Radius.circular(6),
        );

        final barPaint = Paint()
          ..color = isSelected
              ? AppColors.accent
              : (day.isToday ? primaryColor : AppColors.primaryLight);

        canvas.drawRRect(barRect, barPaint);
      }

      // 3. Vẽ nhãn thứ trong tuần (T2, T3, T4...)
      final textSpan = TextSpan(
        text: day.label,
        style: TextStyle(
          color: day.isToday
              ? primaryColor
              : (isSelected ? textPrimaryColor : textColor),
          fontSize: 11,
          fontWeight: (day.isToday || isSelected) ? FontWeight.w700 : FontWeight.w500,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(
          centerX - (textPainter.width / 2),
          size.height - bottomPadding + 6,
        ),
      );

      // Chấm đánh dấu hôm nay (Today Dot)
      if (day.isToday) {
        final dotPaint = Paint()..color = primaryColor;
        canvas.drawCircle(
          Offset(centerX, size.height - 2),
          2.5,
          dotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WeeklyBarChartPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.data != data;
  }
}
