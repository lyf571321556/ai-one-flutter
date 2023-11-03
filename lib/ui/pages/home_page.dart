//import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/ui/drawers/main_left_page.dart';
import 'package:ones_ai_flutter/ui/pages/dashboard/list/dashboard_page.dart';
import 'package:ones_ai_flutter/ui/pages/notification/list/notification_list_page.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/list_project_page.dart';
import 'package:ones_ai_flutter/ui/pages/wiki/list/wiki_list_page.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';

class HomePage extends StatefulWidget {
  static final String pageName = 'HomePage';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageContentState();
  }
}

class _ChildPage {
  final String labelId;
  final String iconId;

  _ChildPage(this.labelId, this.iconId);
}

final List<_ChildPage> _allChildPages = <_ChildPage>[
  new _ChildPage(Strings.titleProject, Drawables.PROJECT_ICON),
  new _ChildPage(Strings.titleWiki, Drawables.WIKI_ICON),
  new _ChildPage(Strings.titleDashboard, Drawables.DASHBOARD_ICON),
  new _ChildPage(Strings.titleNotification, Drawables.NOTIFICATION_ICON),
];

class _HomePageContentState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime? _lastPressedAt;
  TabController? _tabController;
  GlobalKey<_NavigationBarState> _NavigationBarStateKey = GlobalKey();
  final _titleValueNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        new TabController(vsync: this, length: _allChildPages.length);
    _tabController!.addListener(() {
      _NavigationBarStateKey.currentState?.changeTo(_tabController!.index);
      _titleValueNotifier.value = IntlUtil.getString(
          context, _allChildPages[_tabController!.index].labelId);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    _titleValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final String avatar =
        StoreProvider.of<OnesGlobalState>(context).state.user?.avatar ?? '';
    return WillPopScope(
      onWillPop: () async {
        if (Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).openEndDrawer();
          return false;
        }
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
//          BotToast.showText(
//              text: IntlUtil.getString(context, Strings.exitApp),
//              backgroundColor: Colors.grey);
          return false;
        } else {
          return true;
        }
      },
      child: Hero(
        tag: Config.LOGIN_HERO_TAG,
        child: Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              elevation: 1,
              leading: kIsWeb
                  ? Image.network(
                      avatar,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      height: 24,
                      width: 24,
                      imageUrl: avatar,
                      imageBuilder: (context, imageProvider) => Container(
                        constraints:
                            BoxConstraints.tightFor(width: 24, height: 24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        constraints:
                            BoxConstraints.tightFor(width: 24, height: 24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              ResourceUtils.getImgPath('default_avatar'),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) {
                        return Container(
                          constraints:
                              BoxConstraints.tightFor(width: 24, height: 24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                ResourceUtils.getImgPath('default_avatar'),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
              title: ValueListenableBuilder<String>(
                valueListenable: _titleValueNotifier,
                builder: (context, value, child) {
                  return Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  );
                },
                child: Text(''),
              ),
//                title: NavigationBarWidget(_tabController),
              centerTitle: false,
              actions: <Widget>[
                new IconButton(icon: new Icon(Icons.search), onPressed: () {})
              ],
            ),
            preferredSize: Size(double.infinity, 55),
          ),
          body: TabContentViewWidget(tabController: _tabController!),
          drawer: new Drawer(
            child: MainLeftMenuPage(),
          ),
          bottomNavigationBar: NavigationBarWidget(
            _tabController!,
            key: _NavigationBarStateKey,
          ),
        ),
      ),
    );
  }
}

class NavigationBarWidget extends StatefulWidget {
  final TabController _tabController;

  NavigationBarWidget(this._tabController, {required Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavigationBarState();
  }
}

class _NavigationBarState extends State<NavigationBarWidget> {
  static int _currentIndex = 0;

  void changeTo(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: SafeArea(
//          child:
//          CupertinoTabBar(
//        currentIndex: _currentIndex,
//        backgroundColor: Colors.white,
//        items: _allChildPages
//            .map((_ChildPage page) => BottomNavigationBarItem(
//                icon: new Icon(Icons.assignment, size: 20.0),
//                title: Text(IntlUtil.getString(context, page.labelId)),
//                activeIcon: new Icon(
//                  Icons.assignment,
//                  size: 20.0,
//                  color: Colors.blueAccent,
//                )))
//            .toList(),
          child: TabBar(
        controller: widget._tabController,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: _allChildPages
            .map((_ChildPage page) => new Tab(
                  icon: Icon(
                    Icons.home,
                    size: 25.0,
                    color: Colors.blue,
                  ),
                  text: IntlUtil.getString(
                    context,
                    page.labelId,
                  ),
//                  child: new Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      new Icon(Icons.home, size: 25.0,color:Colors.blue,),
//                      new Text(
//                        ,
//                        style: TextStyle(color: Colors.black26),
//                      )
//                    ],
//                  ),
                ))
            .toList(),
        onTap: (index) {
          widget._tabController.animateTo(index);
          setState(() {
            _currentIndex = index;
          });
        },
      )),
    );
  }
}

class TabContentViewWidget extends StatelessWidget {
  final TabController? tabController;

  TabContentViewWidget({Key? key, this.tabController}) : super(key: key);

  Widget buildTabView(BuildContext context, _ChildPage page) {
    final String labelId = page.labelId;
    switch (labelId) {
      case Strings.titleProject:
        return ListProjectPage();
      case Strings.titleWiki:
        return WikiListPage();
      case Strings.titleDashboard:
        return DashboardPage();
      case Strings.titleNotification:
        return NotificationListPage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TabBarView(
        controller: tabController,
        children: _allChildPages.map((_ChildPage page) {
          return buildTabView(context, page);
        }).toList());
  }
}
