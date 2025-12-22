import 'package:flutter/material.dart';
import 'package:postj/l10n/app_localizations.dart';
import 'package:postj/src/theme/app_theme.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: kWebViewBgLight,
      appBar: AppBar(
        title: Text(l10n.rules),
        backgroundColor: kWebViewHeaderBlue,
        foregroundColor: kWhite,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              l10n.tournamentRules,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kWebViewHeaderBlue,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                l10n.tournamentRulesContent,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: kGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
