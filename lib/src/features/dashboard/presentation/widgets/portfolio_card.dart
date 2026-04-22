import 'package:flutter/material.dart';
import '../../../../constants/constants.dart';
import '../../../../utils/utils.dart';

class PortfolioCard extends StatelessWidget {
  final double balance;
  final String currencyCode;
  final String currencySymbol;
  final VoidCallback? onDeposit;
  final VoidCallback? onWithdraw;

  const PortfolioCard({
    super.key,
    required this.balance,
    required this.currencyCode,
    required this.currencySymbol,
    this.onDeposit,
    this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LIQUID WEALTH PORTFOLIO',
                style: AppTextStyles.label.copyWith(color: Colors.white70),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.forest.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '+12.5%',
                  style: TextStyle(
                    color: AppColors.mint,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            CurrencyFormatter.format(balance,
                currencyCode: currencyCode, symbol: currencySymbol),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 34,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Market valuation as of today',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white54,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppSizes.paddingL),
          Row(
            children: [
              Expanded(
                child:
                    _ActionButton(label: 'DEPOSIT', onTap: onDeposit ?? () {}),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                    label: 'WITHDRAW', onTap: onWithdraw ?? () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
