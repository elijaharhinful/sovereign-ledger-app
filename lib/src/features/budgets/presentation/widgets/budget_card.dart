import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../common_widgets/status_badge.dart';
import '../../../../utils/utils.dart';
import '../../domain/budget.dart';
import '../../../transactions/domain/transaction_category.dart';

class BudgetCard extends StatelessWidget {
  final BudgetWithSpending bws;
  final String currencyCode;
  final VoidCallback? onDelete;

  const BudgetCard({
    super.key,
    required this.bws,
    required this.currencyCode,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isOver = bws.remaining < 0;
    final barColor = switch (bws.status.name) {
      'overLimit' || 'atLimit' => AppColors.danger,
      'healthy' => AppColors.forest,
      _ => AppColors.primaryDark,
    };

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
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(bws.budget.category.icon, size: 18, color: AppColors.primaryDark),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(bws.budget.category.label, style: AppTextStyles.heading3),
              ),
              StatusBadge(status: bws.status),
              if (onDelete != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onDelete,
                  child: const Icon(Icons.delete_outline, size: 18, color: AppColors.slateBlue),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),
          Row(
            children: [
              Text(
                CurrencyFormatter.format(bws.spent, currencyCode: currencyCode),
                style: AppTextStyles.amountMedium,
              ),
              Text(
                ' / ${CurrencyFormatter.format(bws.budget.limit, currencyCode: currencyCode)}',
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'USED ${(bws.percentage * 100).toInt()}%',
                style: AppTextStyles.label,
              ),
              Text(
                isOver
                    ? '-${CurrencyFormatter.format(bws.remaining.abs(), currencyCode: currencyCode)} OVER'
                    : '+${CurrencyFormatter.format(bws.remaining, currencyCode: currencyCode)} LEFT',
                style: AppTextStyles.captionBold.copyWith(
                  color: isOver ? AppColors.danger : AppColors.forest,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: bws.percentage,
              backgroundColor: AppColors.surface,
              color: barColor,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
