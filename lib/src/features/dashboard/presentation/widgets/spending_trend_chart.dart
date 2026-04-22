import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';

class SpendingTrendChart extends StatelessWidget {
  final List<double> weeklyData;
  final String currencyCode;

  const SpendingTrendChart({
    super.key,
    required this.weeklyData,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (int i = 0; i < weeklyData.length; i++) {
      spots.add(FlSpot(i.toDouble(), weeklyData[i]));
    }

    final maxY = weeklyData.isEmpty
        ? 100.0
        : (weeklyData.reduce((a, b) => a > b ? a : b) * 1.3)
            .clamp(100.0, double.infinity);

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Spending Trend', style: AppTextStyles.heading3),
                  Text(
                    'Last 7 days',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryDark,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.slateBlue.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const labels = [
                          'W1',
                          'W2',
                          'W3',
                          'W4',
                          'W5',
                          'W6',
                          'W7'
                        ];
                        final idx = value.toInt();
                        if (idx < 0 || idx >= labels.length) {
                          return const SizedBox();
                        }
                        return Text(labels[idx],
                            style: AppTextStyles.label.copyWith(fontSize: 10));
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots.isEmpty
                        ? [const FlSpot(0, 0), const FlSpot(6, 0)]
                        : spots,
                    isCurved: true,
                    color: AppColors.primaryDark,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.periwinkle.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.paddingM),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: Row(
              children: [
                const Icon(Icons.pie_chart_outline,
                    size: 18, color: AppColors.primaryDark),
                const SizedBox(width: 8),
                Text(
                  'Budget Remaining',
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary),
                ),
                const Spacer(),
                Text(
                  CurrencyFormatter.format(
                    weeklyData.fold(0.0, (a, b) => a + b),
                    currencyCode: currencyCode,
                  ),
                  style: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.primaryDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
