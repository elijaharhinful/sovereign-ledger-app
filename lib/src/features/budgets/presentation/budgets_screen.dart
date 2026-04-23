import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../constants/constants.dart';
import '../../../routing/app_routes.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../utils/utils.dart';
import '../application/budgets_service.dart';
import '../../settings/application/settings_service.dart';
import '../../settings/domain/app_settings.dart';
import '../../transactions/application/transactions_service.dart';
import '../../transactions/domain/transaction_category.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsWithSpending = ref.watch(budgetsWithSpendingProvider);
    final summary = ref.watch(monthlyBudgetSummaryProvider);
    final settings = ref.watch(settingsProvider).value ?? AppSettings();
    final txNotifier = ref.watch(transactionsProvider.notifier);
    final weeklyData = txNotifier.getWeeklySpending();
    final recentTx =
        (ref.watch(transactionsProvider).value ?? []).take(3).toList();

    final burnPct = settings.monthlyBudgetLimit > 0
        ? (summary.totalSpent / settings.monthlyBudgetLimit).clamp(0.0, 1.0)
        : 0.0;
    final remaining = settings.monthlyBudgetLimit - summary.totalSpent;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM, vertical: AppSizes.paddingM),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryDark,
                      child: Icon(Icons.person_outline,
                          color: AppColors.white, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Text('Sovereign Ledger', style: AppTextStyles.heading3),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.notifications_outlined,
                          size: 20, color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _MonthlyBurnCard(
                      spent: summary.totalSpent,
                      limit: settings.monthlyBudgetLimit,
                      burnPct: burnPct,
                      remaining: remaining,
                      currencyCode: settings.currencyCode,
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    _SpendingVelocityCard(
                      weeklyData: weeklyData,
                      remaining: remaining,
                      currencyCode: settings.currencyCode,
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    Text('CATEGORY', style: AppTextStyles.label),
                    const SizedBox(height: 10),
                    _CategoryCarousel(
                      budgetsWithSpending: budgetsWithSpending,
                      onNew: () => context.push(AppRoutes.categoryList),
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push(AppRoutes.addBudget),
                        icon: const Icon(Icons.add,
                            color: AppColors.white, size: 18),
                        label: const Text('Add New Category',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryDark,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusLarge)),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    SectionHeader(
                      title: 'Recent Allocation Adjustments',
                      actionLabel: '',
                      onAction: () {},
                    ),
                    const SizedBox(height: 8),
                    ...recentTx.map((tx) => _AdjustmentTile(
                          icon: tx.amount > 100
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          iconColor: tx.amount > 100
                              ? AppColors.danger
                              : AppColors.forest,
                          title: tx.note ?? tx.category.label,
                          subtitle: tx.amount > 100
                              ? 'Increased by +\$${tx.amount.toStringAsFixed(2)}'
                              : 'Reduced by -\$${tx.amount.toStringAsFixed(2)}',
                          dateLabel: _dateLabel(tx.date),
                        )),
                    const SizedBox(height: AppSizes.paddingM),
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusCard),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.credit_card_outlined,
                              size: 28, color: AppColors.primaryDark),
                          const SizedBox(height: 8),
                          Text('New Allocation', style: AppTextStyles.heading3),
                          Text('Record a new Allocation',
                              style: AppTextStyles.caption),
                          const SizedBox(height: AppSizes.paddingM),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  context.push(AppRoutes.addAllocation),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDark,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radiusLarge)),
                              ),
                              child: const Text('Quick Add',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDialFab(
        actions: [
          SpeedDialAction(
              icon: Icons.receipt_long_outlined,
              tooltip: 'Ledger',
              onTap: () => context.push(AppRoutes.ledger)),
          SpeedDialAction(
              icon: Icons.add_card_outlined,
              tooltip: 'Add Transaction',
              onTap: () => context.push(AppRoutes.addTransaction)),
          SpeedDialAction(
              icon: Icons.category_outlined,
              tooltip: 'New Category',
              onTap: () => context.push(AppRoutes.addBudget)),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff == 0) return 'TODAY';
    if (diff == 1) return 'YESTERDAY';
    return '${_monthAbbr(date.month)} ${date.day}';
  }

  String _monthAbbr(int m) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    return months[m - 1];
  }
}

class _MonthlyBurnCard extends StatelessWidget {
  final double spent;
  final double limit;
  final double burnPct;
  final double remaining;
  final String currencyCode;

  const _MonthlyBurnCard({
    required this.spent,
    required this.limit,
    required this.burnPct,
    required this.remaining,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF013380), Color(0xFF0949A4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('MONTHLY BURN',
                  style: AppTextStyles.label.copyWith(color: Colors.white60)),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.mint.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: AppColors.mint.withValues(alpha: 0.4)),
                ),
                child: const Text('ON TRACK',
                    style: TextStyle(
                        color: AppColors.mint,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            CurrencyFormatter.format(spent, currencyCode: currencyCode),
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: -1),
          ),
          const SizedBox(height: AppSizes.paddingM),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: burnPct,
              backgroundColor: Colors.white24,
              color: AppColors.mint,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                '${(burnPct * 100).toInt()}% of ${CurrencyFormatter.format(limit, currencyCode: currencyCode)} limit',
                style: const TextStyle(color: Colors.white60, fontSize: 11),
              ),
              const Spacer(),
              Text(
                '${CurrencyFormatter.format(remaining, currencyCode: currencyCode)} left',
                style: const TextStyle(
                    color: AppColors.mint,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpendingVelocityCard extends StatelessWidget {
  final List<double> weeklyData;
  final double remaining;
  final String currencyCode;

  const _SpendingVelocityCard({
    required this.weeklyData,
    required this.remaining,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = weeklyData.isEmpty
        ? 100.0
        : weeklyData.reduce((a, b) => a > b ? a : b) * 1.4;

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Spending Velocity', style: AppTextStyles.heading3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: AppColors.healthyBg,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('↘ 12.4%',
                    style: TextStyle(
                        color: AppColors.forest,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          Text('Trend relative to baseline', style: AppTextStyles.caption),
          const SizedBox(height: AppSizes.paddingM),
          SizedBox(
            height: 110,
            child: BarChart(BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: maxY,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                      if (i < 0 || i >= days.length) return const SizedBox();
                      return Text(days[i],
                          style: AppTextStyles.label.copyWith(fontSize: 8));
                    },
                  ),
                ),
              ),
              barGroups: weeklyData.asMap().entries.map((e) {
                final isHighest =
                    weeklyData.reduce((a, b) => a > b ? a : b) == e.value;
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: e.value == 0 ? 0.5 : e.value,
                      color: isHighest
                          ? AppColors.primaryDark
                          : AppColors.periwinkle,
                      width: 16,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                  ],
                );
              }).toList(),
            )),
          ),
          const SizedBox(height: AppSizes.paddingS),
          Row(
            children: [
              const Icon(Icons.account_balance_wallet_outlined,
                  size: 16, color: AppColors.primaryDark),
              const SizedBox(width: 6),
              Text('Budget Remaining', style: AppTextStyles.body),
              const Spacer(),
              Text(
                CurrencyFormatter.format(remaining, currencyCode: currencyCode),
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryDark, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryCarousel extends StatelessWidget {
  final List budgetsWithSpending;
  final VoidCallback onNew;

  const _CategoryCarousel(
      {required this.budgetsWithSpending, required this.onNew});

  @override
  Widget build(BuildContext context) {
    final categories =
        budgetsWithSpending.map((bws) => bws.budget.category).toSet().toList();

    return SizedBox(
      height: 76,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...categories
              .map((cat) => _CategoryChip(icon: cat.icon, label: cat.label)),
          _CategoryChip(
            icon: Icons.add,
            label: 'New',
            onTap: onNew,
            isAction: true,
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isAction;

  const _CategoryChip(
      {required this.icon,
      required this.label,
      this.onTap,
      this.isAction = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isAction
              ? AppColors.primaryDark.withValues(alpha: 0.08)
              : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          border: isAction
              ? Border.all(color: AppColors.primaryDark.withValues(alpha: 0.3))
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 20,
                color:
                    isAction ? AppColors.primaryDark : AppColors.primaryDark),
            const SizedBox(height: 4),
            Text(label,
                style: AppTextStyles.caption.copyWith(fontSize: 10),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _AdjustmentTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String dateLabel;

  const _AdjustmentTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.dateLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusCard)),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          Text(dateLabel,
              style: AppTextStyles.captionBold
                  .copyWith(color: AppColors.slateBlue, fontSize: 10)),
        ],
      ),
    );
  }
}
