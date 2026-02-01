import 'package:flutter/material.dart';
import 'package:study_widget/widget_detail.dart';
import 'package:study_widget/widget_list.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetExplorer(),
    );
  }
}

class WidgetExplorer extends StatefulWidget {
  const WidgetExplorer({super.key});

  @override
  _WidgetExplorerState createState() => _WidgetExplorerState();
}

class _WidgetExplorerState extends State<WidgetExplorer> {
  final _searchController = TextEditingController();
  List<WidgetInfo> _filteredWidgets = [];

  @override
  void initState() {
    super.initState();
    _filteredWidgets = widgets;
    _searchController.addListener(() {
      filterWidgets();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterWidgets() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredWidgets = widgets.where((widget) {
        return widget.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Explorer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredWidgets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredWidgets[index].name),
                  onTap: () {
                    if (_filteredWidgets[index].url != null) {
                      launch(_filteredWidgets[index].url!);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WidgetDetail(widgetInfo: _filteredWidgets[index]),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
