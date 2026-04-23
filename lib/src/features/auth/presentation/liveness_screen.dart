import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../routing/app_routes.dart';
import 'liveness_controller.dart';
import '../domain/auth_state.dart';

class LivenessScreen extends ConsumerWidget {
  const LivenessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    ref.listen<AuthState>(authStateProvider, (prev, next) {
      if (next.isVerified) {
        context.go(AppRoutes.verificationSuccess);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.periwinkle.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.face_retouching_natural, size: 30, color: AppColors.primaryDark),
              ),
              const SizedBox(height: AppSizes.paddingM),
              const Text(
                'Identity Verification',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary, letterSpacing: -0.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'We need to perform a quick liveness check',
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.paddingM),
              _buildInfoPill(authState),
              const SizedBox(height: AppSizes.paddingL),
              _buildViewfinder(authState),
              const SizedBox(height: AppSizes.paddingM),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.surface),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shield_outlined, size: 14, color: AppColors.primaryDark),
                    const SizedBox(width: 6),
                    Text('End-to-end encrypted', style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary)),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.paddingL),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authState.isVerifying
                      ? null
                      : () => ref.read(authStateProvider.notifier).startVerification(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.radiusXL)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        authState.isVerifying ? 'Verifying...' : authState.hasFailed ? 'Retry Verification' : 'Start Verification',
                        style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      if (!authState.isVerifying) ...const [
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: AppColors.white, size: 18),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
              GestureDetector(
                onTap: () => ref.read(authStateProvider.notifier).bypassForDev(),
                child: Text(
                  'Cancel',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPill(AuthState state) {
    final isError = state.hasFailed;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isError ? AppColors.overLimitBg : AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isError ? AppColors.danger.withValues(alpha: 0.3) : AppColors.surface),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isError ? Icons.warning_amber_outlined : Icons.info_outline,
            size: 14,
            color: isError ? AppColors.danger : AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            isError ? (state.errorMessage ?? 'Verification failed. Try again.') : 'Center your face in the frame',
            style: AppTextStyles.caption.copyWith(color: isError ? AppColors.danger : AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildViewfinder(AuthState state) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryDark, width: 4),
        color: const Color(0xFFDDE8FF),
      ),
      child: Center(
        child: state.isVerifying
            ? const CircularProgressIndicator(color: AppColors.primaryDark, strokeWidth: 3)
            : const Icon(Icons.videocam_outlined, size: 56, color: AppColors.slateBlue),
      ),
    );
  }
}
