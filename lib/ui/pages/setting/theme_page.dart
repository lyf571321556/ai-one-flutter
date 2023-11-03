import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/l10n/intl_delegate.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:redux/redux.dart';

class ThemeSelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThemeSelectPageState();
  }
}

class _ThemeSelectPageState extends State<ThemeSelectPage> {
  List<String>? list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = themeColorMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: StoreBuilder<OnesGlobalState>(builder: (context, store) {
        return Scaffold(
          appBar: new AppBar(
            title: new Text(
              AppLocalizations.of(context)!.changeTheme,
              style: new TextStyle(fontSize: 16.0),
            ),
            actions: <Widget>[],
          ),
          body: Container(
            alignment: Alignment.topCenter,
            child:
//            SingleChildScrollView(
//                    child: Wrap(
//                      children: List.generate(list.length, (index) {
//                        return _buildGridItem(context, index, store);
//                      }),
//                    ),
//                  ):
//                GridView.builder(
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount:
//                            (window.physicalSize.width / 100).toInt(),
//                        childAspectRatio: 1.0,
//                        crossAxisSpacing: 0),
//                    itemCount: list.length,
//                    itemBuilder: (context, index) {
//                      return _buildGridItem(context, index, store);
//                    },
//                  )
                GridView.extent(
              maxCrossAxisExtent: 100,
              children: List.generate(list?.length ?? 0, (inedx) {
                return _buildGridItem(context, inedx, store);
              }),
            ),
          ),
        );
      }),
    );
  }

  void _changeTheme(String key, Store<OnesGlobalState> store) {
    final ThemeData newThemeData = ThemeData.light().copyWith(
        primaryColor: themeColorMap[key],
        colorScheme: ColorScheme.fromSwatch(accentColor: themeColorMap[key]),
        indicatorColor: themeColorMap[key],
        platform: TargetPlatform.iOS);
    CommonUtils.changeTheme(store, newThemeData);
    LocalDataHelper.put(Config.THEME_COLOR, key);
    setState(() {});
    PageRouteManager.closePage(context);
  }

  Widget _buildGridItem(
      BuildContext context, int index, Store<OnesGlobalState> store) {
    final String key = list![index];
    final Color? color = themeColorMap[key];
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AbsorbPointer(
          absorbing: color == store.state.themeData?.primaryColor,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {
              _changeTheme(key, store);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: Text(
                key,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1, wordSpacing: 1),
              ),
              constraints: BoxConstraints(maxHeight: 80, maxWidth: 80),
              decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ),
        Positioned(
          child: AbsorbPointer(
            absorbing: false,
            child: Opacity(
              opacity: 0,
              child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    //do nothing
                  }),
            ),
          ),
          top: 0,
          right: 0,
        )
      ],
    );
  }
}
