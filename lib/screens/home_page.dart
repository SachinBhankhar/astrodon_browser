import 'package:astrodon_browser/custom_widgets/search_engines_radio_menu_widget.dart';
import 'package:astrodon_browser/screens/search_suggestions_page.dart';
import 'package:astrodon_browser/state/search_suggestions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO:Make the value persistent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return Provider<SearchSuggestionsBloc>(
                        create: (BuildContext context) =>
                            SearchSuggestionsBloc(),
                        child: SearchSuggestionsPage(),
                      );
                    }),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearchEnginesBottomSheet(context);
                        },
                      ),
                      /*     IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: () async {
                          final speech = stt.SpeechToText();
                          String text = "";
                          bool available = await speech.initialize();
                          if (available) {
                            speech.listen(
                              onResult: (SpeechRecognitionResult result) {
                                print(result);
                                text = result.recognizedWords;
                              },
                            );
                          } else {
                            print(
                                "The user has denied the use of speech recognition.");
                          }
                          if (text != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewPage(query: text),
                              ),
                            );
                          }
                        },
                      ),*/
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSearchEnginesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SearchEnginesRadioMenu();
      },
    );
  }
}
