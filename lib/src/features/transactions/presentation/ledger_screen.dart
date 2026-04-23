import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../routing/app_routes.dart';
import '../application/transactions_service.dart';
import '../../../features/settings/application/settings_service.dart';
import 'widgets/transaction_tile.dart';

class LedgerScreen extends ConsumerWidget {
  const LedgerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final transactions = transactionsAsync.value ?? [];
    final settingsAsync = ref.watch(settingsProvider);
    final settings = settingsAsync.value;
    final currencyCode = settings?.currencyCode ?? 'USD';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: 14),
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
                      child: const Icon(Icons.arrow_back, size: 20, color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Recent Ledgers', style: AppTextStyles.heading3),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  if (transactions.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'No transactions yet.',
                          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => TransactionTile(
                            transaction: transactions[index],
                            currencyCode: currencyCode,
                            onDelete: () => ref
                                .read(transactionsProvider.notifier)
                                .deleteTransaction(transactions[index].id),
                          ),
                          childCount: transactions.length,
                        ),
                      ),
                    ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSizes.paddingM),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.paddingM),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.receipt_long_outlined, size: 28, color: AppColors.primaryDark),
                            const SizedBox(height: 8),
                            Text('New Entry', style: AppTextStyles.heading3),
                            Text('Record a new transaction', style: AppTextStyles.caption),
                            const SizedBox(height: AppSizes.paddingM),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => context.push(AppRoutes.addTransaction),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryDark,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusLarge)),
                                ),
                                child: const Text('Quick Add', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDialFab(
        actions: [
          SpeedDialAction(icon: Icons.receipt_long_outlined, tooltip: 'Ledger', onTap: () => context.push(AppRoutes.ledger)),
          SpeedDialAction(icon: Icons.add_card_outlined, tooltip: 'Add Transaction', onTap: () => context.push(AppRoutes.addTransaction)),
          SpeedDialAction(icon: Icons.category_outlined, tooltip: 'New Category', onTap: () => context.push(AppRoutes.addBudget)),
        ],
      ),
    );
  }
}
