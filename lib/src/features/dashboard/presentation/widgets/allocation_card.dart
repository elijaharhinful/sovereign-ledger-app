import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../settings/application/settings_service.dart';
import '../../../budgets/domain/budget.dart';

class AllocationCard extends ConsumerWidget {
  final BudgetWithSpending allocation;
  final VoidCallback? onTap;

  const AllocationCard({
    super.key,
    required this.allocation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyCode =
        ref.watch(settingsProvider).value?.currencyCode ?? 'USD';
    final bws = allocation;
    final isOver = bws.remaining < 0;

    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(bws.budget.category.icon,
                size: 16, color: AppColors.primaryDark),
          ),
          const SizedBox(height: 6),
          Text(bws.budget.category.label, style: AppTextStyles.caption),
          Text(
            CurrencyFormatter.format(bws.spent, currencyCode: currencyCode),
            style: AppTextStyles.bodyMedium
                .copyWith(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: bws.percentage.clamp(0.0, 1.0),
              backgroundColor: AppColors.surface,
              color: isOver ? AppColors.danger : AppColors.primaryDark,
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            isOver
                ? '${CurrencyFormatter.format(bws.remaining.abs(), currencyCode: currencyCode)} OVER'
                : '${CurrencyFormatter.format(bws.remaining, currencyCode: currencyCode)} LEFT',
            style: AppTextStyles.caption.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: isOver ? AppColors.danger : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
