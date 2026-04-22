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
        context.go(AppRoutes.dashboard);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusMedium),
                      ),
                      child: const Icon(Icons.arrow_back,
                          size: 20, color: AppColors.primaryDark),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('Settings & Profile',
                      style: AppTextStyles.heading3
                          .copyWith(color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: AppSizes.paddingL),
              Text('SECURITY VERIFICATION', style: AppTextStyles.label),
              const SizedBox(height: AppSizes.paddingS),
              Text('Biometric Liveness\nVerification',
                  style: AppTextStyles.heading1),
              const SizedBox(height: AppSizes.paddingM),
              Text(
                'Please position your face within the frame. We need to verify that you are the account holder.',
                style:
                    AppTextStyles.body.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppSizes.paddingL),

              // Camera Frame
              Container(
                width: double.infinity,
                height: 260,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Scanning lines indicator
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        children: [
                          _ScanLine(active: authState.isVerifying),
                          const SizedBox(width: 6),
                          _ScanLine(active: authState.isVerifying, delay: true),
                          const SizedBox(width: 6),
                          _ScanLine(active: false),
                        ],
                      ),
                    ),
                    if (authState.isVerifying)
                      const CircularProgressIndicator(
                        color: AppColors.mint,
                        strokeWidth: 3,
                      )
                    else if (authState.isVerified)
                      const Icon(Icons.check_circle,
                          color: AppColors.mint, size: 64)
                    else if (authState.hasFailed)
                      const Icon(Icons.cancel,
                          color: AppColors.danger, size: 64)
                    else
                      Icon(Icons.face,
                          color: Colors.white.withValues(alpha: 0.5), size: 64),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(AppSizes.radiusLarge),
                            bottomRight: Radius.circular(AppSizes.radiusLarge),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              authState.isVerifying
                                  ? 'Verifying...'
                                  : authState.isVerified
                                      ? 'Verified!'
                                      : authState.hasFailed
                                          ? 'Please try again'
                                          : 'Please blink twice',
                              style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              authState.hasFailed
                                  ? authState.errorMessage ??
                                      'Verification failed'
                                  : "IF YOU'RE SAFE",
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 11,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.paddingL),

              // Verification Steps
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verification Steps',
                        style: AppTextStyles.heading3
                            .copyWith(color: AppColors.primary)),
                    const SizedBox(height: AppSizes.paddingM),
                    _VerificationStep(
                      number: 1,
                      title: 'Position Face',
                      subtitle:
                          'Align your head within the square and stay still.',
                      isCompleted:
                          authState.isVerifying || authState.isVerified,
                      isActive: !authState.isVerifying && !authState.isVerified,
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    _VerificationStep(
                      number: 2,
                      title: 'Follow Prompts',
                      subtitle:
                          'Blink or smile when requested to verify liveness.',
                      isCompleted: authState.isVerified,
                      isActive: authState.isVerifying,
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    _VerificationStep(
                      number: 3,
                      title: 'System Check',
                      subtitle: 'Encryption and validity cross-reference.',
                      isCompleted: false,
                      isActive: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),

              // Tips Card
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingM),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.wb_sunny_outlined,
                            size: 18, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text('Tips for Success',
                            style: AppTextStyles.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingS),
                    ...[
                      'Ensure your face is well-lit from the front.',
                      'Remove glasses or hats if verification fails.',
                      'Maintain a neutral background.',
                    ].map((tip) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ',
                                  style: TextStyle(
                                      color: AppColors.textSecondary)),
                              Expanded(
                                  child: Text(tip,
                                      style: AppTextStyles.body.copyWith(
                                          color: AppColors.textSecondary))),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),

              // Status indicators
              _StatusIndicator(
                  label: 'Lighting conditions optimal', isOk: true),
              const SizedBox(height: 8),
              _StatusIndicator(
                  label: 'Camera ready', isOk: !authState.hasFailed),
              const SizedBox(height: AppSizes.paddingL),

              // CTA Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authState.isVerifying
                      ? null
                      : () => ref
                          .read(authStateProvider.notifier)
                          .startVerification(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    ),
                  ),
                  child: Text(
                    authState.hasFailed
                        ? 'Retry Verification'
                        : 'Begin Verification',
                    style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () =>
                      ref.read(authStateProvider.notifier).bypassForDev(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    side: const BorderSide(color: AppColors.slateBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    ),
                  ),
                  child: const Text(
                    'Cancel Verification',
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingL),
              Center(
                child: Text(
                  'PROTECTED BY SOVEREIGN LEDGER ENCRYPTION V4.2',
                  style:
                      AppTextStyles.label.copyWith(color: AppColors.slateBlue),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSizes.paddingM),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanLine extends StatelessWidget {
  final bool active;
  final bool delay;

  const _ScanLine({required this.active, this.delay = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        decoration: BoxDecoration(
          color: active
              ? (delay ? AppColors.slateBlue : AppColors.mint)
              : Colors.white24,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _VerificationStep extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;

  const _VerificationStep({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppColors.forest
                : isActive
                    ? AppColors.primaryDark
                    : AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: AppColors.white, size: 14)
                : Text(
                    '$number',
                    style: TextStyle(
                      color: isActive ? AppColors.white : AppColors.slateBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isActive || isCompleted
                      ? AppColors.textPrimary
                      : AppColors.slateBlue,
                ),
              ),
              Text(subtitle, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final String label;
  final bool isOk;

  const _StatusIndicator({required this.label, required this.isOk});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color:
                isOk ? AppColors.mint : AppColors.danger.withValues(alpha: 0.5),
            width: 3,
          ),
        ),
        color: isOk ? AppColors.mintLight : AppColors.overLimitBg,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isOk ? Icons.check_circle : Icons.warning_amber,
            color: isOk ? AppColors.forest : AppColors.danger,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.body.copyWith(
              color: isOk ? AppColors.forest : AppColors.danger,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
