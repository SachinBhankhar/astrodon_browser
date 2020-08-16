import 'package:astrodon_browser/state/search_engines_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchEnginesRadioMenu extends StatefulWidget {
  @override
  _SearchEnginesRadioMenuState createState() => _SearchEnginesRadioMenuState();
}

class _SearchEnginesRadioMenuState extends State<SearchEnginesRadioMenu> {
  @override
  Widget build(BuildContext context) {
    final searchEnginesProvider = Provider.of<SearchEnginesProvider>(context);
    void setEngine(value) {
      Provider.of<SearchEnginesProvider>(context, listen: false)
          .setSearchEngine(value);
    }

    return Container(
      color: Color(0xff737373),
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Radio(
                  value: SearchEngines.google,
                  groupValue: searchEnginesProvider.selected,
                  onChanged: (value) {
                    setEngine(value);
                  },
                ),
                title: Text("Google"),
              ),
              ListTile(
                leading: Radio(
                  value: SearchEngines.bing,
                  groupValue: searchEnginesProvider.selected,
                  onChanged: (value) {
                    setEngine(value);
                  },
                ),
                title: Text("Bing"),
              ),
              ListTile(
                leading: Radio(
                  value: SearchEngines.yahoo,
                  groupValue: searchEnginesProvider.selected,
                  onChanged: (value) {
                    setEngine(value);
                  },
                ),
                title: Text("Yahoo"),
              ),
              ListTile(
                leading: Radio(
                  value: SearchEngines.duckDuckGo,
                  groupValue: searchEnginesProvider.selected,
                  onChanged: (value) {
                    setEngine(value);
                  },
                ),
                title: Text("DuckDuckGo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
