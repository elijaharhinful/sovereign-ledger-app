import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../domain/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

final authStateProvider = NotifierProvider<LivenessController, AuthState>(
  LivenessController.new,
);

class LivenessController extends Notifier<AuthState> {
  late final AuthRepository _repo;

  @override
  AuthState build() {
    _repo = ref.watch(authRepositoryProvider);
    return const AuthState();
  }

  Future<void> startVerification() async {
    state = state.copyWith(status: AuthStatus.verifying);
    try {
      final success = await _repo.verifyLiveness();
      if (success) {
        state = state.copyWith(status: AuthStatus.verified);
      } else {
        state = state.copyWith(
          status: AuthStatus.failed,
          errorMessage: 'Liveness check failed. Please try again.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.failed,
        errorMessage: 'Verification error: ${e.toString()}',
      );
    }
  }

  void reset() {
    state = const AuthState();
  }

  void bypassForDev() {
    state = state.copyWith(status: AuthStatus.verified);
  }
}
