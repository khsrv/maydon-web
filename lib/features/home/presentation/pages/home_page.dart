import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postj/l10n/app_localizations.dart';
import 'package:postj/src/theme/app_theme.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _shareButtonKey = GlobalKey();

  Future<void> _shareApp(BuildContext context) async {
    const appDescription = 'Maydon - Приложение для футбольных турниров';
    const googlePlayLink = 'https://play.google.com/store/apps/details?id=com.maydon';
    const appStoreLink = 'https://apps.apple.com/us/app/майдон/id6756840511';
    
    final shareText = '$appDescription\n\n'
        'Скачайте приложение:\n'
        'Android: $googlePlayLink\n'
        'iOS: $appStoreLink';
    
    try {
      if (Platform.isIOS && _shareButtonKey.currentContext != null) {
        // Для iOS нужно указать позицию для popover
        final RenderBox? renderBox = _shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;
          await Share.share(
            shareText,
            subject: appDescription,
            sharePositionOrigin: Rect.fromLTWH(
              position.dx,
              position.dy,
              size.width,
              size.height,
            ),
          );
        } else {
          // Fallback если не удалось получить позицию
          await Share.share(shareText, subject: appDescription);
        }
      } else {
        // Для Android и других платформ
        await Share.share(
          shareText,
          subject: appDescription,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при попытке поделиться: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header

                // Main Tournament Card
                _TournamentCard(
                  title: l10n.tournamentTitle,
                  description: l10n.tournamentDescription,
                  teamsCount: l10n.teamsCount,
                  dateRange: l10n.tournamentDateRange,
                ),
                const SizedBox(height: 16),

                // Статистика турнира
                _TournamentStatsSection(),
                const SizedBox(height: 16),

                // Grid of action cards
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                  children: [
                    _ActionCard(
                      icon: Icons.list_alt,
                      title: l10n.schedule,
                      color: kBlue,
                      onTap: () => context.push(
                        '/webview?url=${Uri.encodeComponent('https://maydon.join.football/tournament/1060010/tables')}&title=${Uri.encodeComponent(l10n.schedule)}',
                      ),
                    ),
                    _ActionCard(
                      icon: Icons.people,
                      title: l10n.teams,
                      color: kViolet,
                      onTap: () => context.push(
                        '/webview?url=${Uri.encodeComponent('https://maydon.join.football/tournament/1060010/teams')}&title=${Uri.encodeComponent(l10n.teams)}',
                      ),
                    ),
                    _ActionCard(
                      icon: Icons.calendar_today,
                      title: l10n.calendar,
                      color: kOrange,
                      onTap: () => context.push(
                        '/webview?url=${Uri.encodeComponent('https://maydon.join.football/tournament/1060010/calendar')}&title=${Uri.encodeComponent(l10n.calendar)}',
                      ),
                    ),
                    _ActionCard(
                      icon: Icons.sports_soccer,
                      title: l10n.scorers,
                      color: kYellow,
                      onTap: () => context.push(
                        '/webview?url=${Uri.encodeComponent('https://maydon.join.football/tournament/1060010/stats')}&title=${Uri.encodeComponent(l10n.scorers)}',
                      ),
                    ),
                    _ActionCard(
                      icon: Icons.menu_book,
                      title: l10n.rules,
                      color: kViolet,
                      onTap: () => context.push('/rules'),
                    ),
                    _ActionCard(
                      icon: Icons.videocam,
                      title: 'Видео-обзоры',
                      color: kRed,
                      onTap: () => context.push('/video'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Кнопка "Поделиться приложением"
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    key: _shareButtonKey,
                    onPressed: () => _shareApp(context),
                    icon: const Icon(Icons.share, color: kWhite),
                    label: Text(
                      l10n.shareApp,
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
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TournamentCard extends StatelessWidget {
  const _TournamentCard({
    required this.title,
    required this.description,
    required this.teamsCount,
    required this.dateRange,
  });

  final String title;
  final String description;
  final String teamsCount;
  final String dateRange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWebViewHeaderBlue,
        borderRadius: BorderRadius.circular(20),
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
                  color: kGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.emoji_events, color: kWhite, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.people, color: Colors.white70, size: 18),
              const SizedBox(width: 6),
              Text(
                teamsCount,
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.calendar_today, color: Colors.white70, size: 18),
              const SizedBox(width: 6),
              Text(
                dateRange,
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: kBlack),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kBlack,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Статистика турнира
class _TournamentStatsSection extends StatelessWidget {
  const _TournamentStatsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.sports_soccer,
            value: '16',
            label: 'Дастаҳо',
            color: kBlue,
          ),
          Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
          _StatItem(
            icon: Icons.calendar_today,
            value: '32',
            label: 'Бозиҳо',
            color: kOrange,
          ),
          Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
          _StatItem(
            icon: Icons.emoji_events,
            value: '4',
            label: 'Гурӯҳҳо',
            color: kYellow,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: kGrey)),
      ],
    );
  }
}
