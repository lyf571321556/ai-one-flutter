import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/l10n/intl_delegate.dart';
import 'package:ones_ai_flutter/main.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:redux/redux.dart';

class MainLeftMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainLeftMenuPageState();
  }
}

class PageInfo {
  PageInfo(this.titleId, this.iconData, this.pagePath,
      [this.withScaffold = true]);

  String titleId;
  IconData iconData;
  String pagePath;
  bool withScaffold;
}

class _MainLeftMenuPageState extends State<MainLeftMenuPage> {
  int currentPageIndex = 0;
  List<PageInfo> _pageInfo = [];
  late PageInfo loginOut;

  @override
  void initState() {
    super.initState();
    /**
     *
     *
     *
     *
        _pageInfo.add(PageInfo(
        Strings.titleHome,
        Icons.collections,
        new CollectionPage(
        labelId: Strings.titleHome,
        ),
        )); */
  }

  @override
  Widget build(BuildContext context) {
    _pageInfo.clear();
    loginOut = PageInfo(
        AppLocalizations.of(navigatorKey.currentContext!)!.titleHome,
        Icons.power_settings_new,
        '');
    _pageInfo.add(PageInfo(
        AppLocalizations.of(navigatorKey.currentContext!)!.titleLanguage,
        Icons.language,
        PageRouteManager.languagePagePath));
    _pageInfo.add(PageInfo(
        AppLocalizations.of(navigatorKey.currentContext!)!.titleTheme,
        Icons.color_lens,
        PageRouteManager.themePagePath));
    _pageInfo.add(PageInfo(
        AppLocalizations.of(navigatorKey.currentContext!)!.titleLoginOut,
        Icons.exit_to_app,
        ''));
    /*
    if (Util.isLogin()) {
      if (!_pageInfo.contains(loginOut)) {
        _pageInfo.add(loginOut);
        UserModel userModel =
            SpHelper.getObject<UserModel>(BaseConstant.keyUserModel);
        _userName = userModel?.username ?? "";
        LogUtil.e("_userName : $_userName");
      }
    } else {
      _userName = "Sky24n";
      if (_pageInfo.contains(loginOut)) {
        _pageInfo.remove(loginOut);
      }
    }
    */
    final Store<OnesGlobalState> store = StoreProvider.of(context);
    return new Column(
      children: <Widget>[
        new Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 10.0),
          child: new Stack(
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: 60.0,
                    height: 60.0,
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          ResourceUtils.getImgPath('default_avatar'),
                        ),
                      ),
                    ),
                    child: kIsWeb
                        ? Image.network(
                            StoreProvider.of<OnesGlobalState>(context)
                                    .state
                                    .user
                                    ?.avatar ??
                                '',
                            fit: BoxFit.cover,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 12, bottom: 12, right: 8),
                            child: CachedNetworkImage(
                              imageUrl:
                                  StoreProvider.of<OnesGlobalState>(context)
                                          .state
                                          .user
                                          ?.avatar ??
                                      '',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ResourceUtils.getImgPath(
                                          'default_avatar'),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        ResourceUtils.getImgPath(
                                            'default_avatar'),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  SizedBox(height: 6),
                  new Text(
                    '部门/职位',
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  new Text(
                    StoreProvider.of<OnesGlobalState>(context)
                            .state
                            .user
                            ?.name ??
                        '暂无',
                    style: new TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
              ),
              new Align(
                alignment: Alignment.topRight,
                child: new IconButton(
                    iconSize: 18.0,
                    icon:
                        new Icon(Icons.edit, color: Colors.white.withAlpha(0)),
                    onPressed: () {}),
              )
            ],
          ),
        ),
//          new Container(
//            height: 50.0,
//            child: new Material(
//              color: Colors.grey[200],
//              child: new InkWell(
//                onTap: () {
//
//                },
//                child: new Center(
//                  child: new Text(
//                    "divider",
//                    style: new TextStyle(
//                        color: Theme.of(context).primaryColor, fontSize: 16.0),
//                  ),
//                ),
//              ),
//            ),
//          ),
        new Expanded(
          child: new ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemCount: _pageInfo.length,
              itemBuilder: (BuildContext context, int index) {
                final PageInfo pageInfo = _pageInfo[index];
                return new ListTile(
                  leading: new Icon(pageInfo.iconData,
                      color: index == currentPageIndex
                          ? Theme.of(context).primaryColor
                          : null),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(pageInfo.titleId),
                  onTap: () async {
                    if (pageInfo.pagePath == '') {
                      await UserDao.saveLoginUserInfo(null, store);
                      PageRouteManager.openNewPage(
                          context, PageRouteManager.loginPagePath,
                          replace: true);
                    } else {
                      PageRouteManager.openNewPage(context, pageInfo.pagePath);
                    }
                  },
                );
              }),
          flex: 1,
        )
      ],
    );
  }
}
