import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:her_wellness_calender/features/women_wellness/core/constants/wellness_constants.dart';
import 'package:her_wellness_calender/features/women_wellness/core/helpers/wellness_responsive.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_colors.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_spacing.dart';
import 'package:her_wellness_calender/features/women_wellness/core/theme/wellness_text_styles.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_animations.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_card.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_confirm_dialog.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_empty_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_error_state.dart';
import 'package:her_wellness_calender/features/women_wellness/core/widgets/wellness_loading_view.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/domain/entities/privacy_settings.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/controllers/privacy_settings_controller.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/widgets/privacy_data_info_card.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/widgets/privacy_hero_card.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/widgets/privacy_setting_tile.dart';
import 'package:her_wellness_calender/features/women_wellness/privacy/presentation/widgets/privacy_settings_section.dart';

/// Privacy and security settings with hero, grouped sections, and trust copy.
class PrivacySettingsPage extends GetView<PrivacySettingsController> {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const WellnessLoadingView();
      }
      if (controller.errorMessage.value.isNotEmpty &&
          controller.settings.value == null) {
        return WellnessErrorState(
          message: controller.errorMessage.value,
          onRetry: controller.load,
        );
      }
      final settings = controller.settings.value;
      if (settings == null) {
        return const WellnessEmptyState(
          message: WellnessConstants.privacyEmpty,
          icon: Icons.lock_outline,
        );
      }
      return _PrivacySettingsContent(
        settings: settings,
        isBusy: controller.isSaving.value || controller.isDeleting.value,
        errorMessage: controller.errorMessage.value,
        onChanged: controller.saveSettings,
        onDeleteWellnessData: () => _confirmDelete(
          context,
          title: WellnessConstants.deleteWellnessDataTitle,
          message: WellnessConstants.deleteConfirmation,
          includeAccount: false,
        ),
        onDeleteAccountAndData: () => _confirmDelete(
          context,
          title: WellnessConstants.deleteAccountAndDataTitle,
          message: WellnessConstants.deleteAccountAndDataConfirmation,
          includeAccount: true,
        ),
      );
    });
  }

  Future<void> _confirmDelete(
    BuildContext context, {
    required String title,
    required String message,
    required bool includeAccount,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => WellnessConfirmDialog(
        title: title,
        message: message,
        onConfirm: () {
          Navigator.pop(context);
          controller.deleteWellnessData(includeAccount: includeAccount);
        },
      ),
    );
  }
}

class _PrivacySettingsContent extends StatelessWidget {
  const _PrivacySettingsContent({
    required this.settings,
    required this.isBusy,
    required this.errorMessage,
    required this.onChanged,
    required this.onDeleteWellnessData,
    required this.onDeleteAccountAndData,
  });

  final PrivacySettings settings;
  final bool isBusy;
  final String errorMessage;
  final ValueChanged<PrivacySettings> onChanged;
  final VoidCallback onDeleteWellnessData;
  final VoidCallback onDeleteAccountAndData;

  @override
  Widget build(BuildContext context) {
    final bottomPad = WellnessResponsive.bottomContentInset(context);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        WellnessSpacing.lg,
        WellnessSpacing.lg,
        WellnessSpacing.lg,
        bottomPad,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: WellnessSpacing.compactMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PrivacyHeroCard(),
              const SizedBox(height: WellnessSpacing.lg),
              if (errorMessage.isNotEmpty) ...[
                WellnessCard(
                  child: Text(
                    errorMessage,
                    style: WellnessTextStyles.body.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
                const SizedBox(height: WellnessSpacing.lg),
              ],
              FadeInContainer(
                delay: const Duration(milliseconds: 80),
                child: PrivacySettingsSection(
                  title: WellnessConstants.privacySectionLock,
                  hint: WellnessConstants.privacySectionLockHint,
                  icon: Icons.lock_outline_rounded,
                  children: [
                    PrivacySettingTile(
                      icon: Icons.lock_outline,
                      title: WellnessConstants.privacyAppLockTitle,
                      subtitle: WellnessConstants.privacyAppLockSubtitle,
                      value: settings.appLockEnabled,
                      enabled: !isBusy,
                      onChanged: (value) =>
                          onChanged(settings.copyWith(appLockEnabled: value)),
                    ),
                    PrivacySettingTile(
                      icon: Icons.pin_outlined,
                      title: WellnessConstants.privacyPinTitle,
                      subtitle: WellnessConstants.privacyPinSubtitle,
                      value: settings.pinEnabled,
                      enabled: !isBusy,
                      onChanged: (value) =>
                          onChanged(settings.copyWith(pinEnabled: value)),
                    ),
                    PrivacySettingTile(
                      icon: Icons.fingerprint,
                      title: WellnessConstants.privacyBiometricTitle,
                      subtitle: WellnessConstants.privacyBiometricSubtitle,
                      value: settings.biometricEnabled,
                      enabled: !isBusy,
                      showDivider: false,
                      onChanged: (value) =>
                          onChanged(settings.copyWith(biometricEnabled: value)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: WellnessSpacing.lg),
              FadeInContainer(
                delay: const Duration(milliseconds: 120),
                child: PrivacySettingsSection(
                  title: WellnessConstants.privacySectionDiscretion,
                  hint: WellnessConstants.privacySectionDiscretionHint,
                  icon: Icons.visibility_off_outlined,
                  children: [
                    PrivacySettingTile(
                      icon: Icons.notifications_off_outlined,
                      title: WellnessConstants.privacyHideNotificationTitle,
                      subtitle: WellnessConstants.privacyHideNotificationSubtitle,
                      value: settings.hideNotificationText,
                      enabled: !isBusy,
                      showDivider: false,
                      onChanged: (value) => onChanged(
                        settings.copyWith(hideNotificationText: value),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: WellnessSpacing.lg),
              FadeInContainer(
                delay: const Duration(milliseconds: 160),
                child: PrivacySettingsSection(
                  title: WellnessConstants.privacySectionData,
                  hint: WellnessConstants.privacySectionDataHint,
                  icon: Icons.storage_outlined,
                  children: [
                    PrivacySettingTile(
                      icon: Icons.enhanced_encryption_outlined,
                      title: WellnessConstants.privacyEncryptedStorageTitle,
                      subtitle: WellnessConstants.privacyEncryptedStorageSubtitle,
                      value: settings.encryptedStorageEnabled,
                      enabled: !isBusy,
                      onChanged: (value) => onChanged(
                        settings.copyWith(encryptedStorageEnabled: value),
                      ),
                    ),
                    PrivacySettingTile(
                      icon: Icons.cloud_upload_outlined,
                      title: WellnessConstants.privacyCloudBackupTitle,
                      subtitle: WellnessConstants.privacyCloudBackupSubtitle,
                      value: settings.allowCloudBackup,
                      enabled: !isBusy,
                      showDivider: false,
                      onChanged: (value) =>
                          onChanged(settings.copyWith(allowCloudBackup: value)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: WellnessSpacing.lg),
              const FadeInContainer(
                delay: Duration(milliseconds: 200),
                child: PrivacyDataInfoCard(),
              ),
              const SizedBox(height: WellnessSpacing.lg),
              FadeInContainer(
                delay: const Duration(milliseconds: 240),
                child: _DangerZone(
                  isBusy: isBusy,
                  onDeleteWellnessData: onDeleteWellnessData,
                  onDeleteAccountAndData: onDeleteAccountAndData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DangerZone extends StatelessWidget {
  const _DangerZone({
    required this.isBusy,
    required this.onDeleteWellnessData,
    required this.onDeleteAccountAndData,
  });

  final bool isBusy;
  final VoidCallback onDeleteWellnessData;
  final VoidCallback onDeleteAccountAndData;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return WellnessCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            WellnessConstants.dangerZone,
            style: WellnessTextStyles.sectionHeader(brightness).copyWith(
              color: WellnessColors.error,
            ),
          ),
          const SizedBox(height: WellnessSpacing.sm),
          Text(
            WellnessConstants.privacyTrustDelete,
            style: WellnessTextStyles.caption(context),
          ),
          const SizedBox(height: WellnessSpacing.md),
          OutlinedButton.icon(
            onPressed: isBusy ? null : onDeleteWellnessData,
            icon: const Icon(Icons.delete_outline),
            label: const Text(WellnessConstants.deleteWellnessData),
          ),
          const SizedBox(height: WellnessSpacing.sm),
          FilledButton.icon(
            onPressed: isBusy ? null : onDeleteAccountAndData,
            icon: const Icon(Icons.warning_amber_outlined),
            label: const Text(WellnessConstants.deleteAccountAndData),
            style: FilledButton.styleFrom(
              backgroundColor: WellnessColors.error,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
