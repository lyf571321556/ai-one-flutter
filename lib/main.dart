import 'dart:async';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/dao/app_dao.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/ui/pages/home_page.dart';
import 'package:ones_ai_flutter/ui/pages/login_page.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/platform/web/main_web.dart'
    if (dart.library.io) 'package:ones_ai_flutter/platform/mobile/main_mobile.dart';
import 'common/routes/page_route.dart';
import 'l10n/intl_delegate.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() {
    debugPaintSizeEnabled = !true;
    WidgetsFlutterBinding.ensureInitialized();
    initByPlatform();
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return Container(color: Colors.transparent);
    };
//    WidgetsFlutterBinding.ensureInitialized();
    PageRouteManager.initRoutes();
//    SystemChrome.setEnabledSystemUIOverlays([]);
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
//    runAutoSizeApp(OnesApp());;
    runApp(OnesApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
  }, (Object error, StackTrace stack) {
    print('===============global error start===============');
    print(error);
    print(stack);
    print('===============global error end===============');
  });
}

void initPlatformStateForUniLinks() async {
  print('request coming');
  final String? url = await getCurrentRequestUrl();
  print(url);
  final AppRouteMatch? appRouteMatch =
      PageRouteManager.pageRouter.match(getCurrentRequestUrlPath());
  print(appRouteMatch?.parameters);
  if (appRouteMatch != null && url != null) {
    goToDestPage(url);
  }
  print('request ending');
}

class OnesApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OnesAppState();
  }
}

class OnesAppState extends State<OnesApp> {
  var _buildDataFuture;
  late Store<OnesGlobalState> onesStore;

  @override
  void initState() {
    // TODO: implement initState
    initPlatformStateForUniLinks();
    final Locale? deviceLocale = PlatformDispatcher.instance.locale;
    onesStore = new Store<OnesGlobalState>(createOnesAppReducer,
        middleware: onesMiddlewares,
        initialState: new OnesGlobalState(
            themeData: ThemeData.light().copyWith(
                primaryColor: Colors.blueAccent,
                colorScheme:
                    ColorScheme.fromSwatch(accentColor: Colors.blueAccent),
                hintColor: Colors.grey.withOpacity(0.5),
                highlightColor: Colors.lightBlueAccent,
                indicatorColor: Colors.white,
                platform: TargetPlatform.iOS),
            platformLocale: deviceLocale));
    _buildDataFuture = AppDao.initApp(onesStore);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    Future.wait([AppDao.initApp(onesStore)]).then((Void) {
//      //do sometging
//      return true;
//    });
//    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
//      AppDao.initApp(onesStore).then((Void) {
//        NavigatorUtils.pushReplacementNamed(context, HomePage.pageName);
//        return true;
//      });
//    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _buildWidgetBuilder,
      future: _buildDataFuture,
    );
  }

  Route<dynamic>? generateRoute(RouteSettings routeSettings) {
//    print('Incoming Route Setting\n- Name: ${routeSettings.name}\n- Param: ${routeSettings.arguments}\n- isInitial: ${routeSettings.isInitialRoute}\n\n');
    return PageRouteManager.pageRouter.generator(routeSettings);
  }

  Widget _buildWidgetBuilder(BuildContext context, AsyncSnapshot snapshot) {
    print('-------1--------');
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      print('-------2--------');
      return StoreProvider<OnesGlobalState>(
          store: snapshot.data,
          child: StoreBuilder<OnesGlobalState>(builder: (context, store) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              onGenerateRoute: PageRouteManager.pageRouter.generator,
              debugShowCheckedModeBanner: false,
              title: 'Ones App',
              locale: store.state.locale ?? store.state.platformLocale,
              supportedLocales: AppLocalizations.supportedLocales,
              onGenerateTitle: (BuildContext context) {
                return AppLocalizations.of(context)!.titleHome;
              },
              localizationsDelegates: [
                AppLocalizationsDelegate(),
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              // localeListResolutionCallback:
              //     (List<Locale>? locales, Iterable<Locale> supportedLocales) {
              //   //自定义如何解析和选择应用程序的语言列表
              //   return supportedLocales.first;
              // },
              theme: store.state.themeData,
//                  routes: {
//                    HomePage.pageName: (context) {
//                      return new LocalizationsWidget(
//                        child: NavigatorUtils.pageContainer(new HomePage()),
//                      );
//                    }
//                  },
              home: _getHomePage(store.state.user != null),
            );
          }));
    } else {
      print('-------3--------');
      return Container(
        decoration: BoxDecoration(color: Colors.red),
      );
    }
  }

  Widget _getHomePage(bool isLogin) {
    return isLogin ? HomePage() : LoginPage(); //WebViewPage(); //
  }
}
