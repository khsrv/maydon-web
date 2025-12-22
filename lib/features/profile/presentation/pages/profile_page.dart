import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:postj/features/web_view/presentation/cubit/locale_cubit.dart';
import 'package:postj/l10n/app_localizations.dart';
import 'package:postj/src/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<void> _openTelegram() async {
    final url = Uri.parse('https://t.me/shogasupport');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openSocialMedia(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = context.watch<LocaleCubit>().state ?? const Locale('tg');
    final isTajik = currentLocale.languageCode == 'tg';

    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // About section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kWebViewHeaderBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: kWhite.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.sports_soccer,
                            color: kWhite,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Maydon',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.profileAbout,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Social media section
              Text(
                l10n.profileSupportUs,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.telegram,
                      label: 'Telegram',
                      color: const Color(0xFF0088CC),
                      onTap: () => _openSocialMedia('https://t.me/istaravshan_cup'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.camera_alt,
                      label: 'Instagram',
                      color: const Color(0xFFE4405F),
                      onTap: () => _openSocialMedia('https://www.instagram.com/istaravshan_cup?igsh=MWlmeG5jYmVuN3pwZw=='),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Support button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _openTelegram,
                  icon: const Icon(Icons.support_agent, color: kWhite),
                  label: Text(
                    l10n.profileWriteSupport,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kWhite,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kWebViewHeaderBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Settings section
              _SettingItem(
                icon: Icons.language,
                title: l10n.profileLanguage,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LanguageChip(
                      label: l10n.profileTajik,
                      isSelected: isTajik,
                      onTap: () {
                        context.read<LocaleCubit>().setLocale(const Locale('tg'));
                      },
                    ),
                    const SizedBox(width: 8),
                    _LanguageChip(
                      label: l10n.profileRussian,
                      isSelected: !isTajik,
                      onTap: () {
                        context.read<LocaleCubit>().setLocale(const Locale('ru'));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _SettingItem(
                icon: Icons.privacy_tip_outlined,
                title: l10n.profilePrivacy,
                trailing: const Icon(Icons.chevron_right, color: kGrey),
                onTap: () => context.push('/privacy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  // ignore: unused_element
  final String? subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
        children: [
          Icon(icon, color: kGrey, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kBlack,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: kGrey,
                    ),
                  ),
                ],
              ],
            ),
          ),
          trailing,
        ],
      ),
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kWebViewHeaderBlue : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? kWebViewHeaderBlue : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? kWhite : kGrey,
          ),
        ),
      ),
    );
  }
}
