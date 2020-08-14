import 'package:astrodon_browser/screens/search_suggestions_page.dart';
import 'package:astrodon_browser/state/search_suggestions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
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
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                color: Color(0xff737373),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: Column(
                                      children: [],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
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
}
