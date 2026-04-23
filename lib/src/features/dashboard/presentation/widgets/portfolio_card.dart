import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';

class PortfolioCard extends StatelessWidget {
  final double balance;
  final String currencyCode;
  final String currencySymbol;
  final VoidCallback? onExpense;
  final VoidCallback? onWithdraw;

  const PortfolioCard({
    super.key,
    required this.balance,
    required this.currencyCode,
    required this.currencySymbol,
    this.onExpense,
    this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0949A4), Color(0xFF013380)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Portfolio Balance',
            style: AppTextStyles.caption.copyWith(color: Colors.white60),
          ),
          const SizedBox(height: 6),
          Text(
            CurrencyFormatter.format(balance, currencyCode: currencyCode),
            style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: AppColors.white, letterSpacing: -1),
          ),
          const SizedBox(height: AppSizes.paddingM),
          Row(
            children: [
              _ActionPill(label: 'EXPENSE', onTap: onExpense),
              const SizedBox(width: 10),
              _ActionPill(label: 'WITHDRAW', onTap: onWithdraw, filled: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool filled;

  const _ActionPill({required this.label, this.onTap, this.filled = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: filled ? AppColors.white : Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          border: filled ? null : Border.all(color: Colors.white30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: filled ? AppColors.primaryDark : AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

