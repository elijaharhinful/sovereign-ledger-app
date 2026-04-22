import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../constants/constants.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../utils/utils.dart';
import '../../transactions/application/transactions_service.dart';
import '../../budgets/application/budgets_service.dart';
import '../../settings/application/settings_service.dart';
import '../../settings/domain/app_settings.dart';
import '../../transactions/domain/transaction_category.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  int _periodIndex = 2; // Monthly selected

  @override
  Widget build(BuildContext context) {
    // final transactionsAsync = ref.watch(transactionsProvider);
    final txNotifier = ref.watch(transactionsProvider.notifier);
    final budgetsWithSpending = ref.watch(budgetsWithSpendingProvider);
    final summary = ref.watch(monthlyBudgetSummaryProvider);
    final settingsAsync = ref.watch(settingsProvider);
    final settings = settingsAsync.value ?? AppSettings();
    final weeklyData = txNotifier.getWeeklySpending();
    final monthlyExpenses = txNotifier.getMonthlyExpensesByCategory();

    final totalMonthlyExpense =
        monthlyExpenses.values.fold(0.0, (a, b) => a + b);
    final monthlyBurnLimit = settings.monthlyBudgetLimit;
    final burnPct = monthlyBurnLimit > 0
        ? (totalMonthlyExpense / monthlyBurnLimit).clamp(0.0, 1.0)
        : 0.0;

    // Donut chart sections
    final pieColors = [
      AppColors.primaryDark,
      AppColors.primary,
      AppColors.mint,
      AppColors.slateBlue
    ];
    final categoryEntries = monthlyExpenses.entries.toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.arrow_back,
                                size: 20, color: AppColors.primaryDark),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('Financial Insights',
                            style: AppTextStyles.heading3
                                .copyWith(color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingL),
                    Text('PERFORMANCE ANALYTICS', style: AppTextStyles.label),
                    const SizedBox(height: 4),
                    Text('Financial Insights', style: AppTextStyles.heading1),
                    const SizedBox(height: AppSizes.paddingM),

                    // Period Tabs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusLarge)),
                      child: Row(
                        children: ['Daily', 'Weekly', 'Monthly']
                            .asMap()
                            .entries
                            .map((e) {
                          final isSelected = _periodIndex == e.key;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _periodIndex = e.key),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryDark
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMedium),
                                ),
                                child: Center(
                                  child: Text(
                                    e.value,
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Spending Velocity Bar Chart
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusCard)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Spending Velocity',
                                  style: AppTextStyles.heading3),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.healthyBg,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('↘ 12.4%',
                                    style: TextStyle(
                                        color: AppColors.forest,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                          Text('Trend relative to baseline',
                              style: AppTextStyles.caption),
                          const SizedBox(height: AppSizes.paddingM),
                          SizedBox(
                            height: 140,
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: weeklyData.isEmpty
                                    ? 100
                                    : weeklyData.reduce(
                                                (a, b) => a > b ? a : b) *
                                            1.3 +
                                        1,
                                gridData: const FlGridData(show: false),
                                borderData: FlBorderData(show: false),
                                titlesData: FlTitlesData(
                                  leftTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: const AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (v, _) {
                                        const days = [
                                          'MON',
                                          'TUE',
                                          'WED',
                                          'THU',
                                          'FRI',
                                          'SAT',
                                          'SUN'
                                        ];
                                        final i = v.toInt();
                                        if (i < 0 || i >= days.length) {
                                          return const SizedBox();
                                        }
                                        return Text(days[i],
                                            style: AppTextStyles.label
                                                .copyWith(fontSize: 9));
                                      },
                                    ),
                                  ),
                                ),
                                barGroups: weeklyData.asMap().entries.map((e) {
                                  final isHighest = e.value ==
                                      weeklyData
                                          .reduce((a, b) => a > b ? a : b);
                                  return BarChartGroupData(
                                    x: e.key,
                                    barRods: [
                                      BarChartRodData(
                                        toY: e.value == 0 ? 0.1 : e.value,
                                        color: isHighest
                                            ? AppColors.primaryDark
                                            : AppColors.periwinkle,
                                        width: 18,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(4)),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                  ],
                ),
              ),
            ),

            // Allocations horizontal scroll
            if (budgetsWithSpending.isNotEmpty) ...[
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                sliver: SliverToBoxAdapter(
                  child: SectionHeader(
                      title: 'Allocations',
                      actionLabel: 'View All',
                      onAction: () {}),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingM),
                    itemCount: budgetsWithSpending.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final bws = budgetsWithSpending[index];
                      final isRed = bws.remaining < 0;
                      return Container(
                        width: 120,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusCard)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(bws.budget.category.icon,
                                size: 18, color: AppColors.primaryDark),
                            const SizedBox(height: 4),
                            Text(bws.budget.category.label,
                                style: AppTextStyles.caption),
                            Text(
                              CurrencyFormatter.format(bws.spent,
                                  currencyCode: settings.currencyCode),
                              style: AppTextStyles.bodyMedium.copyWith(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: bws.percentage,
                                backgroundColor: AppColors.surface,
                                color: isRed
                                    ? AppColors.danger
                                    : AppColors.primaryDark,
                                minHeight: 4,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isRed
                                  ? '${CurrencyFormatter.format(bws.remaining.abs(), currencyCode: settings.currencyCode)} OVER'
                                  : '${CurrencyFormatter.format(bws.remaining, currencyCode: settings.currencyCode)} LEFT',
                              style: AppTextStyles.caption.copyWith(
                                color: isRed
                                    ? AppColors.danger
                                    : AppColors.textSecondary,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.paddingM)),
            ],

            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Monthly Burn Card
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusCard)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.healthyBg,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text('ON TRACK',
                                style: TextStyle(
                                    color: AppColors.forest,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11)),
                          ),
                          const SizedBox(height: 8),
                          Text('Total Monthly Burn',
                              style: AppTextStyles.heading3),
                          Text(
                              'MONTHLY THRESHOLD: ${CurrencyFormatter.format(monthlyBurnLimit, currencyCode: settings.currencyCode)}',
                              style: AppTextStyles.caption),
                          const SizedBox(height: AppSizes.paddingM),
                          Row(
                            children: [
                              Text(
                                  '${(burnPct * 100).toStringAsFixed(1)}% utilized',
                                  style: AppTextStyles.caption),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(totalMonthlyExpense,
                                currencyCode: settings.currencyCode),
                            style: AppTextStyles.amountLarge
                                .copyWith(fontSize: 32),
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: burnPct,
                              backgroundColor: AppColors.surface,
                              color: AppColors.mint,
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Donut Allocation Chart
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusCard)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Allocation', style: AppTextStyles.heading3),
                          const SizedBox(height: AppSizes.paddingM),
                          Row(
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    PieChart(
                                      PieChartData(
                                        sectionsSpace: 2,
                                        centerSpaceRadius: 32,
                                        sections: categoryEntries.isEmpty
                                            ? [
                                                PieChartSectionData(
                                                    value: 1,
                                                    color: AppColors.surface,
                                                    radius: 20,
                                                    showTitle: false)
                                              ]
                                            : categoryEntries
                                                .asMap()
                                                .entries
                                                .map((e) {
                                                // final pct = totalMonthlyExpense > 0 ? (e.value.value / totalMonthlyExpense) * 100 : 0.0;
                                                return PieChartSectionData(
                                                  value: e.value.value,
                                                  color: pieColors[
                                                      e.key % pieColors.length],
                                                  radius: 20,
                                                  showTitle: false,
                                                );
                                              }).toList(),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('TOTAL',
                                            style: AppTextStyles.label
                                                .copyWith(fontSize: 8)),
                                        Text(
                                          CurrencyFormatter.formatCompact(
                                              totalMonthlyExpense +
                                                  summary.totalBudget,
                                              currencyCode:
                                                  settings.currencyCode),
                                          style: AppTextStyles.bodyMedium
                                              .copyWith(
                                                  color: AppColors.primaryDark,
                                                  fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSizes.paddingM),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _LegendItem(
                                        color: AppColors.primaryDark,
                                        label: 'Housing & Utilities',
                                        pct: '45%'),
                                    _LegendItem(
                                        color: AppColors.primary,
                                        label: 'Investments',
                                        pct: '25%'),
                                    _LegendItem(
                                        color: AppColors.mint,
                                        label: 'Lifestyle',
                                        pct: '15%'),
                                    _LegendItem(
                                        color: AppColors.slateBlue,
                                        label: 'Others',
                                        pct: '15%'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Savings Propensity
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusCard)),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(Icons.trending_up,
                                color: AppColors.primaryDark, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Savings Propensity',
                                    style: AppTextStyles.bodyMedium),
                                Text('Growth index 0.82',
                                    style: AppTextStyles.caption),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Target Met',
                                        style: AppTextStyles.body),
                                    Text('92%',
                                        style: AppTextStyles.bodyMedium
                                            .copyWith(
                                                color: AppColors.primaryDark,
                                                fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: const LinearProgressIndicator(
                                    value: 0.92,
                                    backgroundColor: AppColors.surface,
                                    color: AppColors.mint,
                                    minHeight: 6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Smart Suggestions
                    SectionHeader(
                        title: 'Smart Suggestions',
                        actionLabel: 'View All',
                        onAction: () {}),
                    const SizedBox(height: 10),
                    _SuggestionCard(
                      icon: Icons.auto_awesome,
                      title: 'Optimize Subscriptions',
                      badge: 'HIGH IMPACT',
                      badgeColor: AppColors.forest,
                      body:
                          'You have overlapping streaming services. Consolidating could save you \$34.99/mo.',
                    ),
                    const SizedBox(height: 10),
                    _SuggestionCard(
                      icon: Icons.credit_card_outlined,
                      title: 'Investment Rebalance',
                      badge: 'STRATEGY',
                      badgeColor: AppColors.primary,
                      body:
                          "Your 'Lifestyle' allocation is exceeding targets. Shift \$200 to your index fund.",
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String pct;

  const _LegendItem(
      {required this.color, required this.label, required this.pct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Expanded(child: Text(label, style: AppTextStyles.caption)),
          Text(pct,
              style: AppTextStyles.captionBold
                  .copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String badge;
  final Color badgeColor;
  final String body;

  const _SuggestionCard({
    required this.icon,
    required this.title,
    required this.badge,
    required this.badgeColor,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, size: 18, color: AppColors.primaryDark),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(title, style: AppTextStyles.bodyMedium)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(badge,
                          style: TextStyle(
                              color: badgeColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(body,
                    style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary, fontSize: 13)),
                const SizedBox(height: 6),
                Text('Take Action ›',
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.primary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
