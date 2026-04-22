enum AuthStatus { unverified, verifying, verified, failed }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.unverified,
    this.errorMessage,
  });

  bool get isVerified => status == AuthStatus.verified;
  bool get isVerifying => status == AuthStatus.verifying;
  bool get hasFailed => status == AuthStatus.failed;

  AuthState copyWith({AuthStatus? status, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
