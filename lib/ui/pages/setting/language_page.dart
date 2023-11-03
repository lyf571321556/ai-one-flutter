import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/l10n/intl_delegate.dart';
import 'package:ones_ai_flutter/main.dart';
import 'package:ones_ai_flutter/models/setting/model_language.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:redux/redux.dart';

class LanguageSelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LanguageSelectPageState();
  }
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  List<LanguageModel> _Languagelist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    Store<OnesGlobalState> store = StoreProvider.of(context);
//    store.state.platformLocale = WidgetsBinding.instance.window.locale;
//    print(store.state.platformLocale);
  }

  void _changeLauguage(
      LanguageModel languageModel, Store<OnesGlobalState> store) {
    setState(() {});
    if (languageModel.titleId == AppLocalizations.of(context)!.languageAuto) {
      CommonUtils.changeLocale(store, null);
      LocalDataHelper.put(Config.LOCALE, '');
    } else {
      CommonUtils.changeLocale(
          store, Locale(languageModel.languageCode, languageModel.countryCode));
      LocalDataHelper.put(Config.LOCALE,
          languageModel.languageCode + '-' + languageModel.countryCode);
    }
    PageRouteManager.closePage(context);
  }

  @override
  Widget build(BuildContext context) {
    _Languagelist.clear();
    _Languagelist.add(
        LanguageModel(AppLocalizations.of(context)!.languageAuto, '', ''));
    _Languagelist.add(
        LanguageModel(AppLocalizations.of(context)!.languageZH, 'zh', 'CH'));
    _Languagelist.add(
        LanguageModel(AppLocalizations.of(context)!.languageTW, 'zh', 'TW'));
    _Languagelist.add(
        LanguageModel(AppLocalizations.of(context)!.languageHK, 'zh', 'HK'));
    _Languagelist.add(
        LanguageModel(AppLocalizations.of(context)!.languageEN, 'en', 'US'));
    return Material(child: StoreBuilder<OnesGlobalState>(
      builder: (context, store) {
        return Scaffold(
          appBar: new AppBar(
              title: new Text(
            AppLocalizations.of(context)!.changeLanguage,
            style: new TextStyle(fontSize: 16.0),
          )),
          body: ListView.builder(
            itemBuilder: (context, index) {
              final LanguageModel languageModel = _Languagelist[index];
              final String title = languageModel.titleId ==
                      AppLocalizations.of(context)!.languageAuto
                  ? languageModel.titleId
                  : languageModel.titleId;
              bool isSelected = store.state.locale != null &&
                  store.state.locale?.countryCode ==
                      languageModel.countryCode &&
                  store.state.locale?.languageCode ==
                      languageModel.languageCode;
              if (languageModel.titleId ==
                  AppLocalizations.of(context)!.languageAuto) {
                isSelected = store.state.locale == null;
              }
              return ListTile(
                title: Text(
                  title,
                  style: new TextStyle(fontSize: 13.0),
                ),
                trailing: new Radio(
                    value: true,
                    groupValue: isSelected,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      _changeLauguage(languageModel, store);
                    }),
                onTap: () {
                  _changeLauguage(languageModel, store);
                },
              );
            },
            itemCount: _Languagelist.length,
          ),
        );
      },
    ));
  }
}
