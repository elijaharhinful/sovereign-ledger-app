import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../routing/app_routes.dart';
import '../../../utils/utils.dart';
import '../application/budgets_service.dart';
import '../../settings/application/settings_service.dart';
import '../../settings/domain/app_settings.dart';
import '../../transactions/domain/transaction_category.dart';

class BudgetAllocationScreen extends ConsumerStatefulWidget {
  const BudgetAllocationScreen({super.key});

  @override
  ConsumerState<BudgetAllocationScreen> createState() =>
      _BudgetAllocationScreenState();
}

class _BudgetAllocationScreenState
    extends ConsumerState<BudgetAllocationScreen> {
  int _filterIndex = 0; // 0=All, 1=Below, 2=Over

  @override
  Widget build(BuildContext context) {
    final budgetsWithSpending = ref.watch(budgetsWithSpendingProvider);
    final settings = ref.watch(settingsProvider).value ?? AppSettings();

    final filtered = budgetsWithSpending.where((b) {
      if (_filterIndex == 1) return b.remaining >= 0;
      if (_filterIndex == 2) return b.remaining < 0;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingM, vertical: 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back,
                          size: 20, color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Budget Allocation', style: AppTextStyles.heading3),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('PERFORMANCE ANALYTICS', style: AppTextStyles.label),
                  const SizedBox(height: 4),
                  Text('Budget Overview', style: AppTextStyles.heading1),
                  const SizedBox(height: AppSizes.paddingL),

                  // Filter Tabs
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    ),
                    child: Row(
                      children: ['All', 'Below Limit', 'Over Limit']
                          .asMap()
                          .entries
                          .map((e) {
                        final isSelected = _filterIndex == e.key;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _filterIndex = e.key),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final bws = filtered[index];
                  final isOver = bws.remaining < 0;
                  final isHealthy = bws.percentage < 0.8;

                  String badgeLabel = isOver
                      ? 'OVER LIMIT'
                      : (isHealthy ? 'HEALTHY' : 'ON TRACK');
                  Color badgeColor = isOver
                      ? AppColors.danger
                      : (isHealthy ? AppColors.forest : AppColors.primaryDark);
                  Color barColor = isOver
                      ? AppColors.danger
                      : (isHealthy ? AppColors.mint : AppColors.primaryDark);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(AppSizes.paddingM),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(bws.budget.category.icon,
                                  size: 20, color: AppColors.primaryDark),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: badgeColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                badgeLabel,
                                style: TextStyle(
                                    color: badgeColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(bws.budget.category.label,
                            style: AppTextStyles.bodyMedium
                                .copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(
                          '${CurrencyFormatter.format(bws.spent, currencyCode: settings.currencyCode)} / ${CurrencyFormatter.format(bws.budget.limit, currencyCode: settings.currencyCode)}',
                          style:
                              AppTextStyles.amountMedium.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: bws.percentage.clamp(0.0, 1.0),
                            backgroundColor: AppColors.surface,
                            color: barColor,
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('USED ${(bws.percentage * 100).toInt()}%',
                                style: AppTextStyles.caption),
                            const Spacer(),
                            Text(
                              isOver
                                  ? '-\$${bws.remaining.abs().toStringAsFixed(2)} OVER'
                                  : '+\$${bws.remaining.toStringAsFixed(2)} LEFT',
                              style: AppTextStyles.caption.copyWith(
                                color: badgeColor,
                                fontWeight: FontWeight.w700,
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
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Container(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusCard),
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
                        onPressed: () => context.push(AppRoutes.addAllocation),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryDark,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusLarge)),
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
            ),
          ],
        ),
      ),
    );
  }
}
