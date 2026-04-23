import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../constants/constants.dart';

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
    final maxY = weeklyData.isEmpty
        ? 100.0
        : weeklyData.reduce((a, b) => a > b ? a : b) * 1.4;

    final spots = weeklyData.asMap().entries
        .map((e) => FlSpot(e.key.toDouble(), e.value == 0 ? 0.5 : e.value))
        .toList();

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
              Text('Spending Trend', style: AppTextStyles.heading3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.healthyBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('↘ 12.4%', style: TextStyle(color: AppColors.forest, fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          Text('Trend relative to baseline', style: AppTextStyles.caption),
          const SizedBox(height: AppSizes.paddingM),
          SizedBox(
            height: 130,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: maxY,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        const days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
                        final i = v.toInt();
                        if (i < 0 || i >= days.length) return const SizedBox();
                        return Text(days[i], style: AppTextStyles.label.copyWith(fontSize: 9));
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primaryDark,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryDark.withValues(alpha: 0.18),
                          AppColors.primaryDark.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
