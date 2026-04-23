import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../features/auth/presentation/liveness_screen.dart';
import '../features/auth/presentation/liveness_controller.dart';
import '../features/auth/presentation/verification_success_screen.dart';
import '../features/auth/domain/auth_state.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/transactions/presentation/add_transaction_screen.dart';
import '../features/transactions/presentation/ledger_screen.dart';
import '../features/budgets/presentation/budgets_screen.dart';
import '../features/budgets/presentation/add_budget_screen.dart';
import '../features/budgets/presentation/category_list_screen.dart';
import '../features/budgets/presentation/budget_allocation_screen.dart';
import '../features/budgets/presentation/add_allocation_screen.dart';
import '../features/insights/presentation/insights_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/auth/presentation/change_password_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _AuthNotifier(ref);

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: notifier,
    redirect: (context, state) {
      final isVerified = ref.read(authStateProvider).isVerified;
      final location = state.matchedLocation;

      const openRoutes = [
        AppRoutes.splash,
        AppRoutes.liveness,
        AppRoutes.verificationSuccess,
      ];

      if (openRoutes.contains(location)) return null;
      if (!isVerified) return AppRoutes.liveness;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: AppRoutes.liveness, builder: (_, __) => const LivenessScreen()),
      GoRoute(path: AppRoutes.verificationSuccess, builder: (_, __) => const VerificationSuccessScreen()),
      GoRoute(path: AppRoutes.dashboard, builder: (_, __) => const DashboardScreen()),
      GoRoute(path: AppRoutes.addTransaction, builder: (_, __) => const AddTransactionScreen()),
      GoRoute(path: AppRoutes.ledger, builder: (_, __) => const LedgerScreen()),
      GoRoute(path: AppRoutes.budgets, builder: (_, __) => const BudgetsScreen()),
      GoRoute(path: AppRoutes.addBudget, builder: (_, __) => const AddBudgetScreen()),
      GoRoute(path: AppRoutes.categoryList, builder: (_, __) => const CategoryListScreen()),
      GoRoute(path: AppRoutes.budgetAllocation, builder: (_, __) => const BudgetAllocationScreen()),
      GoRoute(path: AppRoutes.addAllocation, builder: (_, __) => const AddAllocationScreen()),
      GoRoute(path: AppRoutes.insights, builder: (_, __) => const InsightsScreen()),
      GoRoute(path: AppRoutes.settings, builder: (_, __) => const SettingsScreen()),
      GoRoute(path: AppRoutes.changePassword, builder: (_, __) => const ChangePasswordScreen()),
    ],
  );

  ref.listen<AuthState>(authStateProvider, (_, __) {
    notifier.notifyListeners();
  });

  return router;
});

class _AuthNotifier extends ChangeNotifier {
  _AuthNotifier(Ref ref);
}
