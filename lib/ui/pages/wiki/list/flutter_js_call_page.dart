import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

//class WebViewPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
////    ui.platformViewRegistry.registerViewFactory(
////        'hello-world-html',
////        (int viewId) => IFrameElement()
////          ..width = '640'
////          ..height = '360'
////          ..src = 'https://www.youtube.com/embed/IyFZznAk69U'
////          ..style.border = 'none');
//
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//          title: new Text(
//            "新页面",
//            style: new TextStyle(fontSize: 16.0),
//          )) ,
//      body: Container(
//          color: Colors.orange,
//          child: RaisedButton(onPressed: () {
//            _launchURL();
//          },child: Text("open"),)
////        child: RaisedButton(onPressed: () {
////          js.context
////              .callMethod("open", ["https://stackoverflow.com/questions/ask"]);
////        },child: Text("open"),)
////      child: HtmlElementView(
////        viewType: "hello-world-html",
////      ),
//      ),
//    );
//  }
////
////  void _loadHtmlFromAssets(WebViewController webViewController) async {
////    String fileHtmlContents =
////        await rootBundle.loadString("assets/html/index.html");
////    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
////            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
////        .toString());
////  }
//
//  _launchURL() async {
//    const url = 'https://flutter.io';
//    print(url);
//    if (await canLaunch(url)) {
//      print("launch");
//      await launch(url);
//    } else {
//      print("throw");
//      throw 'Could not launch $url';
//    }
//  }
//}

class WebViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

final Params = {};

final _injectFlutterJsBridge = '''
    window.onesMobile = {
        clickViewAttachment: function (data) {
        FlutterJsBridge.postMessage(data);
        },
    }
    window.onesMobile.params = ${Params};
  ''';

class WebViewPageState extends State<WebViewPage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webViewController = WebViewController();
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            _webViewController.runJavaScript(_injectFlutterJsBridge);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'FlutterJsBridge',
        onMessageReceived: (args) async {
          final data = json.decode(args.message);
          debugPrint('回调======$data');
        },
      );
    _webViewController.loadRequest(Uri.parse('http://192.168.1.213:8080/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebViewWidget(
          controller: _webViewController,
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _webViewController
              .runJavaScriptReturningResult('callJS("visible")')
              .then((result) => {});
        },
        child: Text('call JS'),
      ),
    );
  }
}
