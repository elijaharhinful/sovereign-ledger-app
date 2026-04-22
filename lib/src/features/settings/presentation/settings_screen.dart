import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/constants.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../routing/app_routes.dart';
import '../application/settings_service.dart';
import '../domain/app_settings.dart';
import '../../auth/presentation/liveness_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final settings = settingsAsync.value ?? AppSettings();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingM, vertical: 14),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.dashboard),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12)),
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
                child: Column(
                  children: [
                    // Profile Card
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingM),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusCard)),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: AppColors.primaryDark,
                            child: Text(
                              settings.userName.isNotEmpty
                                  ? settings.userName[0]
                                  : 'A',
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(settings.userName,
                                    style: AppTextStyles.heading3),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDark,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text('PRO MEMBER',
                                      style: TextStyle(
                                          color: AppColors.mint,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.8)),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right,
                              color: AppColors.slateBlue),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Ledger + Upgrade Row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(AppSizes.paddingM),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusCard)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.credit_card_outlined,
                                    size: 22, color: AppColors.primaryDark),
                                const SizedBox(height: 6),
                                Text('Default Ledger',
                                    style: AppTextStyles.caption),
                                Text('Main Savings',
                                    style: AppTextStyles.bodyMedium),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(AppSizes.paddingM),
                            decoration: BoxDecoration(
                              color: AppColors.primaryDark,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusCard),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.auto_awesome,
                                    size: 22, color: AppColors.white),
                                const SizedBox(height: 6),
                                const Text('Upgrade to Sovereign',
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 11)),
                                const Text('Executive',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingM),

                    // Security & Access
                    _SectionLabel(label: 'SECURITY & ACCESS'),
                    _SettingsTile(
                      icon: Icons.fingerprint,
                      title: 'Biometrics',
                      subtitle:
                          'FaceID or TouchID ${settings.biometricsEnabled ? "Enabled" : "Disabled"}',
                      trailing: Switch(
                        value: settings.biometricsEnabled,
                        onChanged: (_) => ref
                            .read(settingsProvider.notifier)
                            .toggleBiometrics(),
                        activeThumbColor: AppColors.primaryDark,
                      ),
                    ),
                    _SettingsTile(
                        icon: Icons.pin_outlined,
                        title: 'Security PIN',
                        subtitle: 'Last updated 12 days ago',
                        onTap: () => context.push(AppRoutes.liveness)),
                    _SettingsTile(
                        icon: Icons.lock_outline,
                        title: 'User Password',
                        subtitle: 'Last updated 5 days ago',
                        onTap: () {}),
                    _SettingsTile(
                        icon: Icons.security,
                        title: 'Two-Factor Authentication',
                        subtitle: 'Last updated 1 month ago',
                        onTap: () {}),
                    const SizedBox(height: AppSizes.paddingM),

                    // Data Management
                    _SectionLabel(label: 'DATA MANAGEMENT'),
                    _SettingsTile(
                      icon: Icons.upload_file,
                      title: 'Export Data',
                      subtitle: 'CSV, PDF, or JSON',
                      onTap: () async {
                        try {
                          final path =
                              await ref.read(exportServiceProvider).exportCsv();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Exported to: $path'),
                                  backgroundColor: AppColors.forest),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Export failed: $e'),
                                  backgroundColor: AppColors.danger),
                            );
                          }
                        }
                      },
                    ),
                    _SettingsTile(
                        icon: Icons.cloud_upload_outlined,
                        title: 'Cloud Backup',
                        subtitle: 'Auto-sync enabled',
                        onTap: () {}),
                    _SettingsTile(
                        icon: Icons.analytics_outlined,
                        title: 'User Analytics',
                        subtitle: 'Real-time insights available',
                        onTap: () {}),
                    _SettingsTile(
                        icon: Icons.description_outlined,
                        title: 'Custom Reports',
                        subtitle: 'Schedule and automate generation',
                        onTap: () {}),
                    const SizedBox(height: AppSizes.paddingM),

                    // Preferences
                    _SectionLabel(label: 'PREFERENCES'),
                    _SettingsTile(
                        icon: Icons.attach_money,
                        title: 'Currency',
                        subtitle:
                            '${settings.currencyCode} (${settings.currencySymbol})',
                        onTap: () => _showCurrencyPicker(context, ref)),
                    _SettingsTile(
                        icon: Icons.language,
                        title: 'Language',
                        subtitle: settings.language,
                        onTap: () {}),
                    _SettingsTile(
                        icon: Icons.access_time,
                        title: 'Timezone',
                        subtitle: 'UTC -5',
                        onTap: () {}),
                    _SettingsTile(
                        icon: Icons.help_outline,
                        title: 'Help Center',
                        subtitle: 'FAQs and direct support',
                        onTap: () {}),
                    _SettingsTile(
                        icon: Icons.payment,
                        title: 'Payment Method',
                        subtitle: 'Credit Card',
                        onTap: () {}),
                    const SizedBox(height: AppSizes.paddingL),

                    // Sign Out
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref.read(authStateProvider.notifier).reset();
                          context.go(AppRoutes.liveness);
                        },
                        icon: const Icon(Icons.logout,
                            color: AppColors.danger, size: 18),
                        label: const Text('Sign Out',
                            style: TextStyle(
                                color: AppColors.danger,
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFFFFE5E5)),
                          backgroundColor: const Color(0xFFFFF5F5),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusLarge)),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingM),
                    Text('SOVEREIGN LEDGER V2.4.0',
                        style: AppTextStyles.label
                            .copyWith(color: AppColors.slateBlue)),
                    const SizedBox(height: AppSizes.paddingL),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  void _showCurrencyPicker(BuildContext context, WidgetRef ref) {
    final currencies = [
      ('USD', '\$', 'US Dollar'),
      ('EUR', '€', 'Euro'),
      ('GBP', '£', 'British Pound'),
      ('GHS', '₵', 'Ghana Cedi'),
      ('NGN', '₦', 'Nigerian Naira'),
      ('JPY', '¥', 'Japanese Yen'),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSizes.radiusXL)),
      ),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Text('Select Currency', style: AppTextStyles.heading3),
          const SizedBox(height: 8),
          ...currencies.map(
            (c) => ListTile(
              leading: Text(c.$2, style: const TextStyle(fontSize: 22)),
              title: Text(c.$1, style: AppTextStyles.bodyMedium),
              subtitle: Text(c.$3, style: AppTextStyles.caption),
              onTap: () {
                final current =
                    ref.read(settingsProvider).value ?? AppSettings();
                ref.read(settingsProvider.notifier).updateSettings(
                      current.copyWith(
                          currencyCode: c.$1, currencySymbol: c.$2),
                    );
                Navigator.pop(ctx);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: AppTextStyles.label),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingM, vertical: 2),
        tileColor: AppColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium)),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: AppColors.primaryDark),
        ),
        title: Text(title, style: AppTextStyles.bodyMedium),
        subtitle: Text(subtitle, style: AppTextStyles.caption),
        trailing: trailing ??
            const Icon(Icons.chevron_right,
                color: AppColors.slateBlue, size: 18),
        onTap: onTap,
      ),
    );
  }
}
