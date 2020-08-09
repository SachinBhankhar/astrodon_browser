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
                          print("s tapped");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: () {
                          print("mic tapped");
                        },
                      ),
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
