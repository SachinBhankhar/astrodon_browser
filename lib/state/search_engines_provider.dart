import 'package:flutter/cupertino.dart';

enum SearchEngines {
  google,
  bing,
  yahoo,
  duckDuckGo,
}

class SearchEnginesProvider with ChangeNotifier {
  SearchEngines selected = SearchEngines.google;

  void setSearchEngine(SearchEngines engine) {
    selected = engine;
    notifyListeners();
  }

  String getSearchEngineUrl() {
    switch (selected) {
      case SearchEngines.google:
        return "https://www.google.com/search?q=";
        break;
      case SearchEngines.bing:
        return "https://www.bing.com/search?q=";
        break;
      case SearchEngines.yahoo:
        return "https://in.search.yahoo.com/search?p=";
        break;
      case SearchEngines.duckDuckGo:
        return "https://duckduckgo.com/?q=f";
        break;
    }
  }
}
