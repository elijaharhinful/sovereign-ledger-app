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

class CategoryListScreen extends ConsumerWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetsWithSpending = ref.watch(budgetsWithSpendingProvider);
    final settings = ref.watch(settingsProvider).value ?? AppSettings();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
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
                  Text('Categories', style: AppTextStyles.heading3),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                itemCount: budgetsWithSpending.length,
                itemBuilder: (context, index) {
                  final bws = budgetsWithSpending[index];
                  final isOver = bws.remaining < 0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(AppSizes.paddingM),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                    ),
                    child: Row(
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(bws.budget.category.label,
                                  style: AppTextStyles.bodyMedium),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: bws.percentage.clamp(0.0, 1.0),
                                  backgroundColor: AppColors.surface,
                                  color: isOver
                                      ? AppColors.danger
                                      : AppColors.primaryDark,
                                  minHeight: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              CurrencyFormatter.format(bws.budget.limit,
                                  currencyCode: settings.currencyCode),
                              style: AppTextStyles.bodyMedium
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isOver
                                  ? '${CurrencyFormatter.format(bws.remaining.abs(), currencyCode: settings.currencyCode)} OVER'
                                  : '${CurrencyFormatter.format(bws.remaining, currencyCode: settings.currencyCode)} LEFT',
                              style: AppTextStyles.caption.copyWith(
                                color: isOver
                                    ? AppColors.danger
                                    : AppColors.forest,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
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
              child: GestureDetector(
                onTap: () => context.push(AppRoutes.addBudget),
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingM),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add,
                            size: 20, color: AppColors.primaryDark),
                      ),
                      const SizedBox(width: 12),
                      Text('Create New Category',
                          style: AppTextStyles.bodyMedium),
                      const Spacer(),
                      const Icon(Icons.chevron_right,
                          color: AppColors.slateBlue),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
