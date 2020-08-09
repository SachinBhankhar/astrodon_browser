import 'package:astrodon_browser/state/search_suggestions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSuggestionsPage extends StatelessWidget {
  final searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream:
                  Provider.of<SearchSuggestionsBloc>(context).searchSuggestions,
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          leading: IconButton(
                            icon: Icon(Icons.arrow_downward),
                            onPressed: () {
                              searchTextController.text = snapshot.data[index];
                            },
                          ),
                          title: Text(snapshot.data[index]),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("No Suggestions"),
                    );
                  }
                }
                return Center(
                  child: Text("No Suggestions"),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchTextController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onChanged: (value) {
                      Provider.of<SearchSuggestionsBloc>(context, listen: false)
                          .getSuggestions(value.trim());
                    },
                    onSubmitted: (value) {},
                  ),
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
