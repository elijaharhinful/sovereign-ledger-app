import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
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
                  Text('Recent Ledger', style: AppTextStyles.heading3),
                ],
              ),
            ),
            Expanded(
              child: transactions.isEmpty
                  ? Center(
                      child: Text(
                        'No transactions yet.',
                        style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) => TransactionTile(
                        transaction: transactions[index],
                        currencyCode: currencyCode,
                        onDelete: () => ref
                            .read(transactionsProvider.notifier)
                            .deleteTransaction(transactions[index].id),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addTransaction),
        backgroundColor: AppColors.primaryDark,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
