import 'package:flutter/material.dart';
import 'package:study_widget/widget_list.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

class WidgetDetail extends StatefulWidget {
  final WidgetInfo widgetInfo;

  const WidgetDetail({super.key, required this.widgetInfo});

  @override
  _WidgetDetailState createState() => _WidgetDetailState();
}

class _WidgetDetailState extends State<WidgetDetail> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.widgetInfo.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Preview'),
            Tab(text: 'Description'),
            Tab(text: 'Source Code'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          widget.widgetInfo.widget,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.widgetInfo.description ?? 'No description available.'),
          ),
          SyntaxView(
            code: widget.widgetInfo.sourceCode ?? 'No source code available.',
            syntax: Syntax.DART,
            syntaxTheme: SyntaxTheme.dracula(),
            withLinesCount: true,
            withZoom: true,
          ),
        ],
      ),
    );
  }
}
