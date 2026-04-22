import 'dart:async';
import 'package:facial_liveness_verification/facial_liveness_verification.dart';

class AuthRepository {
  Future<bool> verifyLiveness() async {
    final detector = LivenessDetector(const LivenessConfig());
    final completer = Completer<bool>();
    StreamSubscription<LivenessState>? subscription;

    try {
      await detector.initialize();

      subscription = detector.stateStream.listen((state) {
        if (state.type == LivenessStateType.completed) {
          if (!completer.isCompleted) completer.complete(true);
        } else if (state.type == LivenessStateType.error) {
          if (!completer.isCompleted) completer.complete(false);
        }
      });

      await detector.start();
      return await completer.future;
    } catch (_) {
      return false;
    } finally {
      await subscription?.cancel();
      await detector.dispose();
    }
  }
}
