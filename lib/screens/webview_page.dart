import 'package:astrodon_browser/state/search_engines_provider.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

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
    final searchEngineUrl =
        Provider.of<SearchEnginesProvider>(context).getSearchEngineUrl();
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
                } else if (value.contains(".")) {
                  _webViewController.loadUrl(url: "https://$value");
                } else {
                  _webViewController.loadUrl(
                    url: "$searchEngineUrl$value",
                  );
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
                      : "$searchEngineUrl${widget.query}",
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
                        title: Text(
                          "The Page is not available\nPlease check the url again.",
                        ),
                      ),
                    );
                  },

                  onDownloadStart:
                      (InAppWebViewController controller, String url) async {
                    final dir = await DownloadsPathProvider.downloadsDirectory;
                    print(dir.path);
                    await FlutterDownloader.enqueue(
                      url: url,
                      savedDir: dir.path,
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
