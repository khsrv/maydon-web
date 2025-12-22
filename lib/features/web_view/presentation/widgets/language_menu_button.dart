import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postj/features/web_view/presentation/cubit/locale_cubit.dart';

class LanguageMenuButton extends StatelessWidget {
  const LanguageMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.watch<LocaleCubit>().state?.languageCode;
    return PopupMenuButton<_Lang>(
      tooltip: 'Language',
      icon: const Icon(Icons.language_rounded),
      onSelected: (lang) {
        context.read<LocaleCubit>().setLocale(Locale(lang.code));
      },
      itemBuilder: (context) => [
        _item(_Lang('ru', 'Русский', '🇷🇺'), current),
        _item(_Lang('en', 'English', '🇬🇧'), current),
        _item(_Lang('ar', 'العربية', '🇸🇦'), current),
        _item(_Lang('tr', 'Türkçe', '🇹🇷'), current),
        _item(_Lang('uz', 'Oʻzbekcha', '🇺🇿'), current),
        _item(_Lang('tg', 'Тоҷикӣ', '🇹🇯'), current),
        _item(_Lang('ky', 'Кыргызча', '🇰🇬'), current),
      ],
    );
  }

  PopupMenuItem<_Lang> _item(_Lang lang, String? currentCode) {
    final selected = currentCode == lang.code;
    return PopupMenuItem<_Lang>(
      value: lang,
      child: Row(
        children: [
          Text(lang.flag, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(child: Text(lang.label)),
          if (selected) const Icon(Icons.check, size: 18),
        ],
      ),
    );
  }
}

class _Lang {
  final String code;
  final String label;
  final String flag;
  const _Lang(this.code, this.label, this.flag);
}
