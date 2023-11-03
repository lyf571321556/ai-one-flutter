import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl_messages.dart';
import 'languages/messages_all_locales.dart';
import 'package:sprintf/sprintf.dart';

extension AppLocalizationsExtension on AppLocalizations {
  /// 根据key动态获取对应语言的值
  String getMessageBy(String? key) {
    return Intl.message('',
        name: key,
        desc: sprintf('get localized language string by %s', [key]),
        args: []);
  }
}

class AppLocalizations with LocalizationMessagesMixin {
  AppLocalizations(this.localeName);

  final String localeName;
  static List<Locale> supportedLocales = const [
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
    Locale('zh', 'HK'),
    Locale('zh', 'MO'),
    Locale('en', 'US'),
    Locale('ja', 'JP')
  ];

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        (locale.countryCode == null || locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations(localeName);
    });
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
