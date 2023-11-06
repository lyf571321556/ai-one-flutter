import 'package:flutter/material.dart';

import '../../../../l10n/intl_delegate.dart';

class WebViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: new Text(
          '新页面',
          style: new TextStyle(fontSize: 16.0),
        )),
        body: Container(
            color: Colors.orange,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.welcomeCountContent('111', 2),
              ),
            )));
  }
}
