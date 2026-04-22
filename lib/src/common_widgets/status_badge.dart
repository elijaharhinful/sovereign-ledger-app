import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../features/budgets/domain/budget_status.dart';

class StatusBadge extends StatelessWidget {
  final BudgetStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (status) {
      BudgetStatus.overLimit => (AppColors.overLimitBg, AppColors.overLimit),
      BudgetStatus.atLimit => (AppColors.overLimitBg, AppColors.overLimit),
      BudgetStatus.healthy => (AppColors.healthyBg, AppColors.forest),
      BudgetStatus.onTrack => (AppColors.onTrackBg, AppColors.primary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: AppTextStyles.captionBold.copyWith(color: fg, fontSize: 10),
      ),
    );
  }
}
