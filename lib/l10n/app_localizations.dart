import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';
import 'app_localizations_tg.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru'),
    Locale('tg'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tg, this message translates to:
  /// **'Maydon'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In tg, this message translates to:
  /// **'Асосӣ'**
  String get navHome;

  /// No description provided for @navNews.
  ///
  /// In tg, this message translates to:
  /// **'Навгониҳо'**
  String get navNews;

  /// No description provided for @navDelivery.
  ///
  /// In tg, this message translates to:
  /// **'Таҳвил'**
  String get navDelivery;

  /// No description provided for @navSupport.
  ///
  /// In tg, this message translates to:
  /// **'Профил'**
  String get navSupport;

  /// No description provided for @notifications.
  ///
  /// In tg, this message translates to:
  /// **'Хабарҳо'**
  String get notifications;

  /// No description provided for @markAllRead.
  ///
  /// In tg, this message translates to:
  /// **'Ҳамаро хондашуда қайд кардан'**
  String get markAllRead;

  /// No description provided for @newNotifications.
  ///
  /// In tg, this message translates to:
  /// **'Нав'**
  String get newNotifications;

  /// No description provided for @readNotifications.
  ///
  /// In tg, this message translates to:
  /// **'Хондашуда'**
  String get readNotifications;

  /// No description provided for @noNewNotifications.
  ///
  /// In tg, this message translates to:
  /// **'Хабарҳои нав нестанд'**
  String get noNewNotifications;

  /// No description provided for @noReadNotifications.
  ///
  /// In tg, this message translates to:
  /// **'Хабарҳои хондашуда нестанд'**
  String get noReadNotifications;

  /// No description provided for @greeting.
  ///
  /// In tg, this message translates to:
  /// **'Салом, Истифодабаранда'**
  String get greeting;

  /// No description provided for @tournamentTitle.
  ///
  /// In tg, this message translates to:
  /// **'Кубок Азизон'**
  String get tournamentTitle;

  /// No description provided for @tournamentDescription.
  ///
  /// In tg, this message translates to:
  /// **'Мусобикаи шаҳри оид ба футзал, мусобиқаи футболи хурд, бахшида ба номи шодравон Нарзулло Юсупов'**
  String get tournamentDescription;

  /// No description provided for @teamsCount.
  ///
  /// In tg, this message translates to:
  /// **'16 даста'**
  String get teamsCount;

  /// No description provided for @tournamentDateRange.
  ///
  /// In tg, this message translates to:
  /// **'18.12.25 - 08.01.26'**
  String get tournamentDateRange;

  /// No description provided for @info.
  ///
  /// In tg, this message translates to:
  /// **'Маълумот'**
  String get info;

  /// No description provided for @schedule.
  ///
  /// In tg, this message translates to:
  /// **'Ҷадвали мусобиқа'**
  String get schedule;

  /// No description provided for @teams.
  ///
  /// In tg, this message translates to:
  /// **'Руйхати дастаҳо'**
  String get teams;

  /// No description provided for @results.
  ///
  /// In tg, this message translates to:
  /// **'Натиҷаи бозиҳо'**
  String get results;

  /// No description provided for @calendar.
  ///
  /// In tg, this message translates to:
  /// **'Тақвими бозиҳо'**
  String get calendar;

  /// No description provided for @scorers.
  ///
  /// In tg, this message translates to:
  /// **'Нишонзанҳо'**
  String get scorers;

  /// No description provided for @video.
  ///
  /// In tg, this message translates to:
  /// **'Видеои бозиҳо'**
  String get video;

  /// No description provided for @rules.
  ///
  /// In tg, this message translates to:
  /// **'Регламент'**
  String get rules;

  /// No description provided for @news.
  ///
  /// In tg, this message translates to:
  /// **'Хабарҳо'**
  String get news;

  /// No description provided for @videoComingSoon.
  ///
  /// In tg, this message translates to:
  /// **'Видео ба зудӣ дар дастрас хоҳад буд'**
  String get videoComingSoon;

  /// No description provided for @rulesComingSoon.
  ///
  /// In tg, this message translates to:
  /// **'Қоидаҳо ба зудӣ дар дастрас хоҳанд буд'**
  String get rulesComingSoon;

  /// No description provided for @tournamentRules.
  ///
  /// In tg, this message translates to:
  /// **'Регламент'**
  String get tournamentRules;

  /// No description provided for @tournamentRulesContent.
  ///
  /// In tg, this message translates to:
  /// **'Тибқи низомномаи мазкур, қоидаҳои асосие, ки нишон дода шудааст ба Шумо маълум менамоем:\n1. Шумораи бозингарон дар майдон 6 нафар ҳар даста (5 бозингари майдонӣ ва 1 дарвозабон).\n2. Иштирок бо либоси ягонаи варзишӣ.\n3. Тӯб шумораи 5 (панҷ).\n4. Бозингари ҳирфави (проффесионал) ба дархостнома 3 нафар дар як вақт танҳо 2 нафари онҳо бозӣ карда метавонад.\n5. Дастаҳо имконияти, номаҳдуди ивази (замена) бозингарро дар доранд.\n6. Танҳо 14 нафар варзишгар метавонад дар мусобиқаи мазкур иштирок кунад, баъди пешниҳоди дархост дастаҳо дигар имконияти ворид кардани варзишгарро надоранд.\n7. Ҳар як даста аз танаффуси як дақиқаги дар ҳар як қисм метавонад истифода кунад.\n8. Мусобиқа бо системаи гурӯҳи оғоз гардида аз 4 гурӯҳ иборат мебошад.Аз ҳар гурӯҳ 2 дастаи беҳтарин ба плей офф роҳ меёбад.Бозиҳо аз ду қисм иборат буда, ҳар як қисм 25 дақиқаги ва 5 дақиқа барои истироҳат вақт ҷуда мешавад.\n9. Дастае, ки дархост пешниҳод намекунад ба чемпионатт мазкур роҳ дода намешавад.\n10. Ҳамчунон, аз дигар шаҳру ноҳияи Ҷумҳурии Тоҷикистон ва берун аз он ҳуқуқи иштирокро надоранд.\nБа Шумо тақвими бозиҳо бо сана ва вақти баргузории бозиҳо пешниҳод карда мешавад, ки хоҳиш менамоем риоя кунед!'**
  String get tournamentRulesContent;

  /// No description provided for @onboardingWelcome.
  ///
  /// In tg, this message translates to:
  /// **'Хуш омадед ба Maydon'**
  String get onboardingWelcome;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In tg, this message translates to:
  /// **' '**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingCalendar.
  ///
  /// In tg, this message translates to:
  /// **'Тақвими бозӣҳо'**
  String get onboardingCalendar;

  /// No description provided for @onboardingCalendarSubtitle.
  ///
  /// In tg, this message translates to:
  /// **'Ҳамаи бозиҳоро дар як ҷо дида, вақти бозӣҳоро пайгирӣ кунед'**
  String get onboardingCalendarSubtitle;

  /// No description provided for @onboardingResults.
  ///
  /// In tg, this message translates to:
  /// **'Натиҷаҳо'**
  String get onboardingResults;

  /// No description provided for @onboardingResultsSubtitle.
  ///
  /// In tg, this message translates to:
  /// **'Натиҷаҳои ҳамаи бозиҳоро ба таври замонавӣ пайгирӣ кунед'**
  String get onboardingResultsSubtitle;

  /// No description provided for @onboardingScorers.
  ///
  /// In tg, this message translates to:
  /// **'Нишонзанони беҳтарин'**
  String get onboardingScorers;

  /// No description provided for @onboardingScorersSubtitle.
  ///
  /// In tg, this message translates to:
  /// **'Нишонзанҳои беҳтаринро дар турнир дида баред'**
  String get onboardingScorersSubtitle;

  /// No description provided for @onboardingLive.
  ///
  /// In tg, this message translates to:
  /// **'Пахши зинда'**
  String get onboardingLive;

  /// No description provided for @onboardingLiveSubtitle.
  ///
  /// In tg, this message translates to:
  /// **'Бозиҳоро ба таври зинда тамошо кунед ва хабарҳо гиред'**
  String get onboardingLiveSubtitle;

  /// No description provided for @skip.
  ///
  /// In tg, this message translates to:
  /// **'Гузарондан'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In tg, this message translates to:
  /// **'Ба паш'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In tg, this message translates to:
  /// **'Оғоз кардан'**
  String get getStarted;

  /// No description provided for @navCalendar.
  ///
  /// In tg, this message translates to:
  /// **'Тақвим'**
  String get navCalendar;

  /// No description provided for @navProfile.
  ///
  /// In tg, this message translates to:
  /// **'Профил'**
  String get navProfile;

  /// No description provided for @profileAbout.
  ///
  /// In tg, this message translates to:
  /// **'Мо мехоҳем ҳамаи дӯстдорони футболро дар Тоҷикистон муттаҳид кунем ва аз ин рӯ ин барномаро сохтем. Барои он ки одамон лаззат баранд ва дар шакли қулай аз барнома истифода баранд. Матчҳоро тамошо кунед, ҷадвал, ва дигар чорабиниҳои муҳимматеро, ки бо футбол алоқаманд аст, пайгирӣ кунед.'**
  String get profileAbout;

  /// No description provided for @profileSupportUs.
  ///
  /// In tg, this message translates to:
  /// **'Моро дастгирӣ кунед ва обуна шавед'**
  String get profileSupportUs;

  /// No description provided for @profileWriteSupport.
  ///
  /// In tg, this message translates to:
  /// **'Ба админ навистан'**
  String get profileWriteSupport;

  /// No description provided for @profileLanguage.
  ///
  /// In tg, this message translates to:
  /// **'Забон'**
  String get profileLanguage;

  /// No description provided for @profileNotifications.
  ///
  /// In tg, this message translates to:
  /// **'Хабарҳо'**
  String get profileNotifications;

  /// No description provided for @profileNotificationsDescription.
  ///
  /// In tg, this message translates to:
  /// **'Гирифтани огоҳиномаҳо'**
  String get profileNotificationsDescription;

  /// No description provided for @profileRussian.
  ///
  /// In tg, this message translates to:
  /// **'Русский'**
  String get profileRussian;

  /// No description provided for @profileTajik.
  ///
  /// In tg, this message translates to:
  /// **'Тоҷикӣ'**
  String get profileTajik;

  /// No description provided for @shareApp.
  ///
  /// In tg, this message translates to:
  /// **'Ба дигарон равон кардан'**
  String get shareApp;

  /// No description provided for @viewAll.
  ///
  /// In tg, this message translates to:
  /// **'Ҳамаро дидан'**
  String get viewAll;

  /// No description provided for @profilePrivacy.
  ///
  /// In tg, this message translates to:
  /// **'Конфиденсиалият'**
  String get profilePrivacy;

  /// No description provided for @privacyPolicy.
  ///
  /// In tg, this message translates to:
  /// **'Политика конфиденсиалият'**
  String get privacyPolicy;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In tg, this message translates to:
  /// **'Ин барномаи содда аст ва мо ҳеҷ чизро нигоҳ намедорем.\n\nМо:\n• Маълумоти шахсиро ҷамъ намекунем\n• Паролҳо ё маълумоти ҳисобро нигоҳ намедорем\n• Маълумоти шахсиро ба дигарон намефурӯшем\n• Танзимоти шахсиро дар сервер нигоҳ намедорем\n\nИн барнома танҳо барои тамошои маълумоти турнир ва навгониҳо истифода мешавад. Ҳамаи маълумот дар қурбонӣ (device) нигоҳ дошта мешаванд ва ба сервер фиристода намешаванд.'**
  String get privacyPolicyContent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru', 'tg'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
    case 'tg':
      return AppLocalizationsTg();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
