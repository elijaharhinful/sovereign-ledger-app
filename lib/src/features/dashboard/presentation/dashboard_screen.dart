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
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingM,
                  vertical: AppSizes.paddingM,
                ),
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
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications_outlined, size: 20, color: AppColors.primaryDark),
                    ),
                  ],
                ),
              ),
            ),

            // Portfolio Card
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: PortfolioCard(
                  balance: summary.balance,
                  currencyCode: summary.currencyCode,
                  currencySymbol: summary.currencySymbol,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSizes.paddingM)),

            // Quick Actions Row
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _QuickAction(icon: Icons.receipt_outlined, onTap: () => context.push(AppRoutes.ledger)),
                      _QuickAction(icon: Icons.edit_outlined, onTap: () => context.push(AppRoutes.addTransaction)),
                      _QuickAction(icon: Icons.credit_card_outlined, onTap: () => context.go(AppRoutes.budgets)),
                      _QuickAction(icon: Icons.account_balance_outlined, onTap: () {}),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSizes.paddingM)),

            // Allocations Section
            if (budgetsWithSpending.isNotEmpty) ...[
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                sliver: SliverToBoxAdapter(
                  child: SectionHeader(
                    title: 'Allocations',
                    actionLabel: 'View All',
                    onAction: () => context.go(AppRoutes.budgets),
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
                      budgetWithSpending: budgetsWithSpending[index],
                      currencyCode: summary.currencyCode,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSizes.paddingM)),
            ],

            // Spending Trend Chart
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

            // Savings breakdown
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              sliver: SliverToBoxAdapter(
                child: _SavingsCard(
                  totalIncome: summary.totalIncome,
                  totalExpenses: summary.totalExpenses,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSizes.paddingM)),

            // Recent Ledger
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

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.addTransaction),
        backgroundColor: AppColors.primaryDark,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuickAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: AppColors.primaryDark),
      ),
    );
  }
}

class _SavingsCard extends StatelessWidget {
  final double totalIncome;
  final double totalExpenses;

  const _SavingsCard({required this.totalIncome, required this.totalExpenses});

  @override
  Widget build(BuildContext context) {
    final savings = (totalIncome - totalExpenses).clamp(0.0, double.infinity);
    final investmentPct = totalIncome > 0 ? ((savings * 0.65) / totalIncome).clamp(0.0, 1.0) : 0.0;
    final cashPct = totalIncome > 0 ? ((savings * 0.25) / totalIncome).clamp(0.0, 1.0) : 0.0;
    final cryptoPct = totalIncome > 0 ? ((savings * 0.10) / totalIncome).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Savings', style: AppTextStyles.heading3),
              const Icon(Icons.language, size: 18, color: AppColors.slateBlue),
            ],
          ),
          const SizedBox(height: AppSizes.paddingM),
          _SavingsRow(label: 'INVESTMENTS', pct: investmentPct, color: AppColors.primaryDark),
          const SizedBox(height: 10),
          _SavingsRow(label: 'CASH SAVINGS', pct: cashPct, color: AppColors.primary),
          const SizedBox(height: 10),
          _SavingsRow(label: 'CRYPTO VAULT', pct: cryptoPct, color: AppColors.mint),
        ],
      ),
    );
  }
}

class _SavingsRow extends StatelessWidget {
  final String label;
  final double pct;
  final Color color;

  const _SavingsRow({required this.label, required this.pct, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: AppTextStyles.label),
        ),
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: AppColors.surface,
              color: color,
              minHeight: 6,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '${(pct * 100).toInt()}%',
          style: AppTextStyles.captionBold.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
