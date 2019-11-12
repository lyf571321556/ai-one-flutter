import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/bloc/bloc_widget.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/project_list_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectListPageContentState();
  }
}

class _ProjectListPageContentState extends State<ProjectListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("ComListPage build......");
    RefreshController _refreshController =
        new RefreshController(initialRefresh: true);
    final ProjectListBloc _projectListBloc =
        BlocListProviderWidget.of<ProjectListBloc>(context);
    _projectListBloc.projectListEventStream.listen((action) {
      switch (action) {
        case ListAction.RefreshAction:
          _refreshController.refreshCompleted();
          print("_refreshController.refreshCompleted");
          break;
        case ListAction.LoadAction:
          _refreshController.loadComplete();
          print("_refreshController.loadComplete");
          break;
      }
    });
    return StreamBuilder(
      stream: _projectListBloc.projectListStream,
      builder: (context, snapshot) {
        return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropHeader(
            waterDropColor: Theme.of(context).primaryColor,
          ),
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowAlways,
            completeDuration: Duration(milliseconds: 500),
          ),
          onLoading: () {
            _projectListBloc.onLoadMore();
          },
          onRefresh: () {
            _projectListBloc.onRefresh();
          },
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              itemExtent: 100,
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(snapshot.data[index]),
                );
              }),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}