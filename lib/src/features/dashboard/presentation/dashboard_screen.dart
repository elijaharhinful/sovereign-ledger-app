import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../routing/app_routes.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../transactions/application/transactions_service.dart';
import '../../budgets/application/budgets_service.dart';
import '../application/dashboard_service.dart';
import 'widgets/portfolio_card.dart';
import 'widgets/spending_trend_chart.dart';
import 'widgets/allocation_card.dart';
import '../../transactions/presentation/widgets/transaction_tile.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final recentTransactions = transactionsAsync.value ?? [];
    final budgetsWithSpending = ref.watch(budgetsWithSpendingProvider);
    final weeklySpending = ref.watch(transactionsProvider.notifier).getWeeklySpending();
    final recentTx = recentTransactions.take(5).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM, vertical: AppSizes.paddingM),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryDark,
                      child: Text(
                        summary.userName.isNotEmpty ? summary.userName[0] : 'A',
                        style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Sovereign Ledger', style: AppTextStyles.heading3),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.notifications_outlined, size: 20, color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: PortfolioCard(
                  balance: summary.balance,
                  currencyCode: summary.currencyCode,
                  currencySymbol: summary.currencySymbol,
                  onExpense: () => context.push(AppRoutes.addTransaction),
                  onWithdraw: () => context.push(AppRoutes.addTransaction),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSizes.paddingM)),

            if (budgetsWithSpending.isNotEmpty) ...[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                sliver: SliverToBoxAdapter(
                  child: SectionHeader(
                    title: 'Allocations',
                    actionLabel: 'View All',
                    onAction: () => context.go(AppRoutes.budgetAllocation),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 140,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                    itemCount: budgetsWithSpending.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) => AllocationCard(
                      allocation: budgetsWithSpending[index],
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSizes.paddingM)),
            ],

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: SpendingTrendChart(
                  weeklyData: weeklySpending,
                  currencyCode: summary.currencyCode,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSizes.paddingM)),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Recent Ledger',
                  actionLabel: 'VIEW ALL',
                  onAction: () => context.push(AppRoutes.ledger),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: recentTx.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.paddingL),
                          child: Text(
                            'No transactions yet.\nTap + to add one.',
                            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TransactionTile(
                          transaction: recentTx[index],
                          currencyCode: summary.currencyCode,
                        ),
                        childCount: recentTx.length,
                      ),
                    ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: SpeedDialFab(
        actions: [
          SpeedDialAction(
            icon: Icons.receipt_long_outlined,
            tooltip: 'Ledger',
            onTap: () => context.push(AppRoutes.ledger),
          ),
          SpeedDialAction(
            icon: Icons.add_card_outlined,
            tooltip: 'Add Transaction',
            onTap: () => context.push(AppRoutes.addTransaction),
          ),
          SpeedDialAction(
            icon: Icons.category_outlined,
            tooltip: 'New Category',
            onTap: () => context.push(AppRoutes.addBudget),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
