import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../routing/app_routes.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../utils/utils.dart';
import '../application/budgets_service.dart';
import '../../settings/application/settings_service.dart';
import '../../settings/domain/app_settings.dart';
import 'widgets/budget_card.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsWithSpending = ref.watch(budgetsWithSpendingProvider);
    final summary = ref.watch(monthlyBudgetSummaryProvider);
    final settings = ref.watch(settingsProvider).value ?? AppSettings();
    final now = DateTime.now();

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
                    // Header
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.go(AppRoutes.dashboard),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.arrow_back, size: 20, color: AppColors.primaryDark),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('Budgets & Limits', style: AppTextStyles.heading3.copyWith(color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingL),
                    Text('MONTHLY OVERVIEW', style: AppTextStyles.label),
                    const SizedBox(height: 4),
                    Text(
                      '${_monthName(now.month)} Budgets',
                      style: AppTextStyles.heading1,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                        children: [
                          const TextSpan(text: "You've utilized "),
                          TextSpan(
                            text: '${(summary.percentage * 100).toInt()}%',
                            style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w700),
                          ),
                          const TextSpan(text: ' of your total monthly allowance.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Total Spent Card
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Spent', style: AppTextStyles.caption),
                          const SizedBox(height: 4),
                          Text(
                            CurrencyFormatter.format(summary.totalSpent, currencyCode: settings.currencyCode),
                            style: AppTextStyles.amountLarge,
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: summary.percentage,
                              backgroundColor: AppColors.surface,
                              color: summary.percentage > 0.9 ? AppColors.danger : AppColors.primaryDark,
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'of ${CurrencyFormatter.format(summary.totalBudget, currencyCode: settings.currencyCode)} total budget',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Action Buttons
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push(AppRoutes.addBudget),
                        icon: const Icon(Icons.add, color: AppColors.white, size: 18),
                        label: const Text('Add New Category', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryDark,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusLarge)),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined, size: 16, color: AppColors.primary),
                        label: const Text('Edit Budgets', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: AppColors.periwinkle),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusLarge)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.sort, size: 16, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text('Sort by: Usage %', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                  ],
                ),
              ),
            ),

            // Budget cards
            budgetsWithSpending.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.paddingXL),
                        child: Column(
                          children: [
                            const Icon(Icons.credit_card_off_outlined, size: 48, color: AppColors.slateBlue),
                            const SizedBox(height: 12),
                            Text(
                              'No budgets set yet.\nTap "Add New Category" to get started.',
                              style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => BudgetCard(
                          bws: budgetsWithSpending[index],
                          currencyCode: settings.currencyCode,
                          onDelete: () => ref
                              .read(budgetsProvider.notifier)
                              .deleteBudget(budgetsWithSpending[index].budget.id),
                        ),
                        childCount: budgetsWithSpending.length,
                      ),
                    ),
                  ),

            // Smart Allocation Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingL),
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: summary.percentage * 0.75,
                              backgroundColor: Colors.white24,
                              color: AppColors.mint,
                              strokeWidth: 6,
                            ),
                            Text(
                              '${(summary.percentage * 75).toInt()}%',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const Positioned(
                              bottom: 0,
                              child: Text(
                                'GOAL',
                                style: TextStyle(color: Colors.white54, fontSize: 9, letterSpacing: 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingM),
                      const Text(
                        'Smart Allocation Detected',
                        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "We noticed a budget opportunity. Would you like to re-allocate funds to optimize your savings?",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.paddingM),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.white),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusLarge)),
                          ),
                          child: const Text('Allocate Now', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  String _monthName(int month) {
    const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    return months[month - 1];
  }
}
