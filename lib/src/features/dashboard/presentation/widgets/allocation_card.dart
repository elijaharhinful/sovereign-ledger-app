import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../budgets/domain/budget.dart';
import '../../../transactions/domain/transaction_category.dart';

class AllocationCard extends StatelessWidget {
  final BudgetWithSpending budgetWithSpending;
  final String currencyCode;

  const AllocationCard({
    super.key,
    required this.budgetWithSpending,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    final bws = budgetWithSpending;
    final isOverBudget = bws.remaining < 0;
    final barColor = isOverBudget ? AppColors.danger : AppColors.primaryDark;

    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              bws.budget.category.icon,
              size: 18,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(bws.budget.category.label, style: AppTextStyles.body.copyWith(fontSize: 13)),
          const SizedBox(height: 4),
          Text(
            CurrencyFormatter.format(bws.spent, currencyCode: currencyCode),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryDark,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: bws.percentage,
              backgroundColor: AppColors.surface,
              color: barColor,
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isOverBudget
                ? '${CurrencyFormatter.format(bws.remaining.abs(), currencyCode: currencyCode)} OVER'
                : '${CurrencyFormatter.format(bws.remaining, currencyCode: currencyCode)} LEFT',
            style: AppTextStyles.caption.copyWith(
              color: isOverBudget ? AppColors.danger : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
