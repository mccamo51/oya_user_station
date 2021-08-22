import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:oya_porter/pages/Users/config/navigation.dart';
import 'package:oya_porter/spec/colors.dart';

class WebBroswer extends StatefulWidget {
  final String url;
  final bool nowWaiting;
  final bool terms;
  final bool home;
  final String title;

  WebBroswer({
    @required this.url,
    @required this.nowWaiting,
    this.terms = false,
    this.home = false,
    this.title = "Privacy Policy",
  });

  @override
  _WebBroswerState createState() => _WebBroswerState();
}

class _WebBroswerState extends State<WebBroswer> {
  final _urlController = new TextEditingController();
  String selectedUrl;

  // Instance of WebView plugin
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  // On destroy stream
  StreamSubscription _onDestroy;
  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;
  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  StreamSubscription<double> _onProgressChanged;

  final _history = [];

  bool showWeb = true;
  bool success;

  // bool showWeb = false;
  // bool success = true;

  @override
  void initState() {
    selectedUrl = widget.url;
    flutterWebViewPlugin.close();

    _urlController.addListener(() {
      selectedUrl = _urlController.text;
    });

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.

      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
      print(selectedUrl);
    });

    _onProgressChanged =
        flutterWebViewPlugin.onProgressChanged.listen((double progress) {
      // if (mounted) {
      //   setState(() {
      //     _history.add('onProgressChanged: $progress');
      //   });
      // }
    });

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      if (mounted) {
        setState(() {
          _history.add('onStateChanged: ${state.type} ${state.url}');
          print(state.url);
          String url = state.url;
          List<String> splitUrl = url.split('/');
          print(splitUrl);

          if (splitUrl[splitUrl.length - 1].toLowerCase() == "success") {
            setState(() {
              showWeb = false;
              success = true;
            });
          }
        });
      }
    });

    _onHttpError =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
      if (mounted) {
        setState(() {
          _history.add('onHttpError: ${error.code} ${error.url}');
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onProgressChanged.cancel();

    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return;
        },
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: WHITE.withOpacity(.6),
            child: WebviewScaffold(
              url: selectedUrl,
              mediaPlaybackRequiresUserGesture: false,
              appBar: Platform.isIOS
                  ? CupertinoNavigationBar(
                      leading: Center(
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Close",
                            style: TextStyle(
                                color: BLACK,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          onPressed: () {
                            flutterWebViewPlugin.canGoBack().then((value) {
                              if (value) {
                                flutterWebViewPlugin.goBack();
                              } else {
                                Navigator.pop(context);
                              }
                            });
                          },
                        ),
                      ),
                      middle: Text('${widget.title}'),
                    )
                  : AppBar(
                      title: Text('${widget.title}'),
                      centerTitle: true,
                      leading: Center(
                        child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Close",
                              style: TextStyle(
                                  color: BLACK,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            onPressed: () {
                              flutterWebViewPlugin.canGoBack().then((value) {
                                if (value) {
                                  flutterWebViewPlugin.goBack();
                                } else {
                                  Navigator.pop(context);
                                }
                              });
                            }),
                      )),
              withZoom: true,
              withLocalStorage: true,
              withJavascript: true,
              hidden: true,
              initialChild: Container(
                color: WHITE.withOpacity(.7),
                child: const Center(
                  child: CupertinoActivityIndicator(radius: 25),
                ),
              ),
            )));
  }

  void _onProceed() {
    if (widget.nowWaiting) {
      if (success) {
        navigation(context: context, pageName: "homepage");
      } else {
        setState(() {
          showWeb = false;
        });
      }
    } else {
      navigation(context: context, pageName: "homepage");
    }
  }

  // _onChechIfPaymentResponseDelay() {
  //   try {
  //     Timer _timer;
  //     _timer = Timer.periodic(
  //       Duration(seconds: 20),
  //       (timer) async {
  //         //  final response = await http.get("url?reference=${widget.}").timeout(Duration(seconds: 15));
  //       },
  //     );
  //   } catch (e) {}
  // }

  // void _onProceed() {
  //   if (widget.nowWaiting) {
  //     if (success) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => VideoCallPage(
  //             channelName: widget.channelName,
  //             receiver: "",
  //             name: "",
  //           ),
  //         ),
  //       );
  //     } else {
  //       setState(() {
  //         showWeb = false;
  //       });
  //     }
  //   } else {
  //     navigation(context: context, pageName: "patientHomepage");
  //   }
  // }
}
