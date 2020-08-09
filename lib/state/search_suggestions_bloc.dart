import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class SearchSuggestionsBloc {
  final suggestionsUrl =
      "http://suggestqueries.google.com/complete/search?output=toolbar&hl=en&q=";
  final _searchSuggestionsStreamController = StreamController<List<String>>();
  Stream<List<String>> get searchSuggestions =>
      _searchSuggestionsStreamController.stream;

  void getSuggestions(String query) async {
    if (query.isNotEmpty) {
      final res = await http.get("$suggestionsUrl$query");
      final xml = XmlDocument.parse(res.body);
      //getting all elements with suggestion tag
      final suggestionsXml = xml.findAllElements("suggestion");
      //data is attribute in xml element
      final suggestions = suggestionsXml
          .map(
            (e) => e.getAttribute("data"),
          )
          .toList();
      _searchSuggestionsStreamController.sink.add(suggestions);
    } else {
      _searchSuggestionsStreamController.sink.add([]);
    }
  }

  void close() {
    _searchSuggestionsStreamController.close();
  }
}
