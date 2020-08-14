import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';

class WebViewPage extends StatefulWidget {
  final String query;
  WebViewPage({Key key, @required this.query});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController _webViewController;
  final TextEditingController _textEditingController = TextEditingController();
  double pageProgress = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: TextField(
              controller: _textEditingController,
              onSubmitted: (value) {
                if (value.contains("http")) {
                  _webViewController.loadUrl(url: value);
                } else {
                  _webViewController.loadUrl(url: "https://$value");
                }
              },
            ),
            leading: IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
                onPressed: () {
                  _webViewController.reload();
                },
              )
            ],
          ),
          body: Column(
            children: [
              pageProgress < 1.0
                  ? LinearProgressIndicator(
                      value: pageProgress,
                    )
                  : Container(),
              Expanded(
                child: InAppWebView(
                  //TODO:refactor

                  initialUrl: widget.query.contains(".")
                      ? "https://${widget.query}"
                      : "https://google.com/search?q=${widget.query}",
                  onWebViewCreated: (InAppWebViewController webViewController) {
                    _webViewController = webViewController;
                  },
                  onLoadStart: (InAppWebViewController controller, String url) {
                    _textEditingController.text = url;
                  },
                  onLoadStop:
                      (InAppWebViewController controller, String url) async {
                    _textEditingController.text = url;
                  },
                  onProgressChanged:
                      (InAppWebViewController webViewController, int progress) {
                    setState(() {
                      pageProgress = progress.toDouble() / 100;
                    });
                  },
                  onLoadError: (InAppWebViewController controller, String url,
                      int code, String message) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text(message),
                      ),
                    );
                  },

                  onDownloadStart:
                      (InAppWebViewController controller, String url) async {
                    final dir = await getExternalStorageDirectories(
                      type: StorageDirectory.downloads,
                    );
                    print(dir[0].path);
                    final taskId = await FlutterDownloader.enqueue(
                      url: url,
                      savedDir: dir[0].path,
                      showNotification:
                          true, // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                    );
                  },
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useOnDownloadStart: true,
                    ),
                    android: AndroidInAppWebViewOptions(
                      allowContentAccess: true,
                      allowFileAccess: true,
                      allowFileAccessFromFileURLs: true,
                      allowUniversalAccessFromFileURLs: true,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
