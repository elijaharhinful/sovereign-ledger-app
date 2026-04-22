import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../features/auth/presentation/liveness_screen.dart';
import '../features/auth/presentation/liveness_controller.dart';
import '../features/auth/domain/auth_state.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/transactions/presentation/add_transaction_screen.dart';
import '../features/transactions/presentation/ledger_screen.dart';
import '../features/budgets/presentation/budgets_screen.dart';
import '../features/budgets/presentation/add_budget_screen.dart';
import '../features/insights/presentation/insights_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _AuthNotifier(ref);

  final router = GoRouter(
    initialLocation: AppRoutes.liveness,
    refreshListenable: notifier,
    redirect: (context, state) {
      final isVerified = ref.read(authStateProvider).isVerified;
      final isOnLiveness = state.matchedLocation == AppRoutes.liveness;

      if (!isVerified && !isOnLiveness) return AppRoutes.liveness;
      if (isVerified && isOnLiveness) return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.liveness,
        builder: (context, state) => const LivenessScreen(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.addTransaction,
        builder: (context, state) => const AddTransactionScreen(),
      ),
      GoRoute(
        path: AppRoutes.ledger,
        builder: (context, state) => const LedgerScreen(),
      ),
      GoRoute(
        path: AppRoutes.budgets,
        builder: (context, state) => const BudgetsScreen(),
      ),
      GoRoute(
        path: AppRoutes.addBudget,
        builder: (context, state) => const AddBudgetScreen(),
      ),
      GoRoute(
        path: AppRoutes.insights,
        builder: (context, state) => const InsightsScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
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
