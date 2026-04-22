import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/constants.dart';
import '../routing/app_routes.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: AppSizes.bottomNavHeight,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.grid_view_rounded,
                label: 'OVERVIEW',
                isSelected: currentIndex == 0,
                onTap: () => context.go(AppRoutes.dashboard),
              ),
              _NavItem(
                icon: Icons.credit_card_outlined,
                label: 'BUDGETS',
                isSelected: currentIndex == 1,
                onTap: () => context.go(AppRoutes.budgets),
              ),
              _NavItem(
                icon: Icons.show_chart,
                label: 'INSIGHTS',
                isSelected: currentIndex == 2,
                onTap: () => context.go(AppRoutes.insights),
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                label: 'SETTINGS',
                isSelected: currentIndex == 3,
                onTap: () => context.go(AppRoutes.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.primaryDark : AppColors.slateBlue,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: isSelected ? AppColors.primaryDark : AppColors.slateBlue,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
