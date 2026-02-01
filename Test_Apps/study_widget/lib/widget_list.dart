
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study_widget/interactive_container.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetInfo {
  final String name;
  final Widget widget;
  final String? description;
  final String? sourceCode;
  final String? url;

  WidgetInfo({required this.name, required this.widget, this.description, this.sourceCode, this.url});
}

final List<WidgetInfo> widgets = [
  WidgetInfo(
    name: 'Official Widget Catalog',
    widget: const Center(child: Text('Tap to open the official Flutter widget catalog.')),
    description: 'The official Flutter widget catalog. This will open in a new browser window.',
    sourceCode: "launch('https://flutter.dev/docs/development/ui/widgets')",
    url: 'https://flutter.dev/docs/development/ui/widgets',
  ),
  WidgetInfo(
    name: 'Text',
    widget: const Center(child: Text('Hello, World!')),
    description: 'A widget that displays a short string of text.',
    sourceCode: "const Center(child: Text('Hello, World!'))",
  ),
  WidgetInfo(
    name: 'Icon',
    widget: const Center(child: Icon(Icons.favorite, size: 50, color: Colors.red)),
    description: 'A graphical icon widget drawn from a font.',
    sourceCode: "const Center(child: Icon(Icons.favorite, size: 50, color: Colors.red))",
  ),
  WidgetInfo(
    name: 'Button',
    widget: Center(child: ElevatedButton(onPressed: () {}, child: const Text('Press Me'))),
    description: 'A material design "elevated button".',
    sourceCode: "Center(child: ElevatedButton(onPressed: () {}, child: const Text('Press Me')))",
  ),
  WidgetInfo(
    name: 'Container',
    widget: const InteractiveContainer(),
    description: 'A convenience widget that combines common painting, positioning, and sizing widgets.',
    sourceCode: """
class InteractiveContainer extends StatefulWidget {
  const InteractiveContainer({super.key});

  @override
  _InteractiveContainerState createState() => _InteractiveContainerState();
}

class _InteractiveContainerState extends State<InteractiveContainer> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Container(
              width: _width,
              height: _height,
              color: _color,
              child: const Center(child: Text('Container')),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            children: [
              _buildWidthSlider(),
              _buildHeightSlider(),
              _buildColorPicker(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWidthSlider() {
    return _buildSlider('Width', _width, (value) {
      setState(() {
        _width = value;
      });
    });
  }

  Widget _buildHeightSlider() {
    return _buildSlider('Height', _height, (value) {
      setState(() {
        _height = value;
      });
    });
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged) {
    return Row(
      children: [
        Text(label),
        Expanded(
          child: Slider(
            value: value,
            min: 50,
            max: 300,
            onChanged: onChanged,
          ),
        ),
        Text(value.toStringAsFixed(0)),
      ],
    );
  }

  Widget _buildColorPicker() {
    return Row(
      children: [
        const Text('Color'),
        const Spacer(),
        DropdownButton<Color>(
          value: _color,
          onChanged: (Color? newColor) {
            setState(() {
              _color = newColor!;
            });
          },
          items: [
            Colors.blue,
            Colors.red,
            Colors.green,
            Colors.yellow,
          ].map<DropdownMenuItem<Color>>((Color color) {
            return DropdownMenuItem<Color>(
              value: color,
              child: Container(
                width: 20,
                height: 20,
                color: color,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
""",
  ),
  WidgetInfo(
    name: 'Column',
    widget: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Column 1'),
        Text('Column 2'),
        Text('Column 3'),
      ],
    ),
    description: 'A widget that displays its children in a vertical array.',
    sourceCode: """const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Column 1'),
        Text('Column 2'),
        Text('Column 3'),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'Row',
    widget: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Row 1'),
        SizedBox(width: 10),
        Text('Row 2'),
        SizedBox(width: 10),
        Text('Row 3'),
      ],
    ),
    description: 'A widget that displays its children in a horizontal array.',
    sourceCode: """const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Row 1'),
        SizedBox(width: 10),
        Text('Row 2'),
        SizedBox(width: 10),
        Text('Row 3'),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'Stack',
    widget: Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 200, height: 200, color: Colors.red),
          Container(width: 150, height: 150, color: Colors.green),
          Container(width: 100, height: 100, color: Colors.blue),
        ],
      ),
    ),
    description: 'A widget that positions its children relative to the edges of its box.',
    sourceCode: """Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 200, height: 200, color: Colors.red),
          Container(width: 150, height: 150, color: Colors.green),
          Container(width: 100, height: 100, color: Colors.blue),
        ],
      ),
    )""",
  ),
  WidgetInfo(
    name: 'ListView',
    widget: ListView(
      children: const [
        ListTile(title: Text('Item 1')),
        ListTile(title: Text('Item 2')),
        ListTile(title: Text('Item 3')),
      ],
    ),
    description: 'A scrollable list of widgets arranged linearly.',
    sourceCode: """ListView(
      children: const [
        ListTile(title: Text('Item 1')),
        ListTile(title: Text('Item 2')),
        ListTile(title: Text('Item 3')),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'Image',
    widget: Center(
      child: Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
    ),
    description: 'A widget that displays an image.',
    sourceCode: "Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')",
  ),
  WidgetInfo(
    name: 'Card',
    widget: Center(
      child: Card(
        child: SizedBox(
          width: 200,
          height: 100,
          child: const Center(child: Text('Card')),
        ),
      ),
    ),
    description: 'A material design card. A card has slightly rounded corners and a shadow.',
    sourceCode: """Center(
      child: Card(
        child: SizedBox(
          width: 200,
          height: 100,
          child: const Center(child: Text('Card')),
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'TextField',
    widget: const Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter text',
        ),
      ),
    ),
    description: 'A text field lets the user enter text, either with hardware keyboard or with an onscreen keyboard.',
    sourceCode: """const Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter text',
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'AlertDialog',
    widget: Builder(
        builder: (context) {
          return Center(
            child: ElevatedButton(
              child: const Text('Show Dialog'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Alert Dialog'),
                    content: const Text('This is an alert dialog.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
    ),
    description: 'Alerts are urgent interruptions, requiring acknowledgement, that inform the user about a situation.',
    sourceCode: """Builder(
      builder: (context) {
        return Center(
          child: ElevatedButton(
            child: const Text('Show Dialog'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Alert Dialog'),
                  content: const Text('This is an alert dialog.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    )""",
  ),
  WidgetInfo(
    name: 'Align',
    widget: Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.red,
        child: const Text('Align'),
      ),
    ),
    description: 'A widget that aligns its child within itself and optionally sizes itself based on the child.',
    sourceCode: """Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 100,
        width: 100,
        color: Colors.red,
        child: const Text('Align'),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'Padding',
    widget: const Padding(
      padding: EdgeInsets.all(50.0),
      child: Text('This text is padded.'),
    ),
    description: 'A widget that insets its child by a given padding.',
    sourceCode: """const Padding(
      padding: EdgeInsets.all(50.0),
      child: Text('This text is padded.'),
    )""",
  ),
  WidgetInfo(
    name: 'AspectRatio',
    widget: Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.amber,
        ),
      ),
    ),
    description: 'A widget that attempts to size the child to a specific aspect ratio.',
    sourceCode: """Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.amber,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'Baseline',
    widget: Center(
      child: Baseline(
        baseline: 50,
        baselineType: TextBaseline.alphabetic,
        child: Container(
          width: 50,
          height: 50,
          color: Colors.cyan,
        ),
      ),
    ),
    description: 'A widget that positions its child according to the child\'s baseline.',
    sourceCode: """Center(
      child: Baseline(
        baseline: 50,
        baselineType: TextBaseline.alphabetic,
        child: Container(
          width: 50,
          height: 50,
          color: Colors.cyan,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'Center',
    widget: const Center(
      child: Text('Centered Text'),
    ),
    description: 'A widget that centers its child within itself.',
    sourceCode: "const Center(child: Text('Centered Text'))",
  ),
  WidgetInfo(
    name: 'ConstrainedBox',
    widget: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 200,
          minHeight: 100,
          maxHeight: 200,
        ),
        child: Container(
          color: Colors.orange,
        ),
      ),
    ),
    description: 'A widget that imposes additional constraints on its child.',
    sourceCode: """Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 200,
          minHeight: 100,
          maxHeight: 200,
        ),
        child: Container(
          color: Colors.orange,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'Expanded',
    widget: Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.indigo,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.pink,
          ),
        ),
      ],
    ),
    description: 'A widget that expands a child of a Row, Column, or Flex.',
    sourceCode: """Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.indigo,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.pink,
          ),
        ),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'FittedBox',
    widget: Center(
      child: Container(
        width: 200,
        height: 100,
        color: Colors.purple,
        child: const FittedBox(
          fit: BoxFit.contain,
          child: Text('FittedBox'),
        ),
      ),
    ),
    description: 'A widget that scales and positions its child within itself according to fit.',
    sourceCode: """Center(
      child: Container(
        width: 200,
        height: 100,
        color: Colors.purple,
        child: const FittedBox(
          fit: BoxFit.contain,
          child: Text('FittedBox'),
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'FractionallySizedBox',
    widget: Center(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Container(
          color: Colors.teal,
        ),
      ),
    ),
    description: 'A widget that sizes its child to a fraction of the total available space.',
    sourceCode: """Center(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        heightFactor: 0.5,
        child: Container(
          color: Colors.teal,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'GridView',
    widget: GridView.count(
      crossAxisCount: 3,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
        Container(color: Colors.orange),
        Container(color: Colors.pink),
        Container(color: Colors.cyan),
        Container(color: Colors.indigo),
      ],
    ),
    description: 'A grid list consists of a repeated pattern of cells arrayed in a vertical and horizontal layout.',
    sourceCode: """GridView.count(
      crossAxisCount: 3,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
        Container(color: Colors.orange),
        Container(color: Colors.pink),
        Container(color: Colors.cyan),
        Container(color: Colors.indigo),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'LimitedBox',
    widget: Center(
      child: LimitedBox(
        maxWidth: 100,
        child: Container(
          color: Colors.lime,
        ),
      ),
    ),
    description: 'A box that limits its size only when it\'s unconstrained.',
    sourceCode: """Center(
      child: LimitedBox(
        maxWidth: 100,
        child: Container(
          color: Colors.lime,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'Offstage',
    widget: const Center(
      child: Offstage(
        offstage: true,
        child: Text('This is offstage.'),
      ),
    ),
    description: 'A widget that lays out its child as if it was in the tree, but without painting anything, without making the child available for hit testing, and without taking any room in the parent.',
    sourceCode: """const Center(
      child: Offstage(
        offstage: true,
        child: Text('This is offstage.'),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'SizedBox',
    widget: const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Text('SizedBox'),
      ),
    ),
    description: 'A box with a specified size.',
    sourceCode: """const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Text('SizedBox'),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'Table',
    widget: Table(
      border: TableBorder.all(),
      children: const [
        TableRow(
          children: [
            Text('Cell 1'),
            Text('Cell 2'),
            Text('Cell 3'),
          ],
        ),
        TableRow(
          children: [
            Text('Cell 4'),
            Text('Cell 5'),
            Text('Cell 6'),
          ],
        ),
      ],
    ),
    description: 'A widget that uses the table layout algorithm for its children.',
    sourceCode: """Table(
      border: TableBorder.all(),
      children: const [
        TableRow(
          children: [
            Text('Cell 1'),
            Text('Cell 2'),
            Text('Cell 3'),
          ],
        ),
        TableRow(
          children: [
            Text('Cell 4'),
            Text('Cell 5'),
            Text('Cell 6'),
          ],
        ),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'Wrap',
    widget: Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        Chip(label: Text('Wrap')),
        Chip(label: Text('is')),
        Chip(label: Text('a')),
        Chip(label: Text('widget')),
        Chip(label: Text('that')),
        Chip(label: Text('displays')),
        Chip(label: Text('its')),
        Chip(label: Text('children')),
        Chip(label: Text('in')),
        Chip(label: Text('multiple')),
        Chip(label: Text('horizontal')),
        Chip(label: Text('or')),
        Chip(label: Text('vertical')),
        Chip(label: Text('runs.')),
      ],
    ),
    description: 'A widget that displays its children in multiple horizontal or vertical runs.',
    sourceCode: """Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: [
        Chip(label: Text('Wrap')),
        Chip(label: Text('is')),
        Chip(label: Text('a')),
        Chip(label: Text('widget')),
        Chip(label: Text('that')),
        Chip(label: Text('displays')),
        Chip(label: Text('its')),
        Chip(label: Text('children')),
        Chip(label: Text('in')),
        Chip(label: Text('multiple')),
        Chip(label: Text('horizontal')),
        Chip(label: Text('or')),
        Chip(label: Text('vertical')),
        Chip(label: Text('runs.')),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'Opacity',
    widget: Center(
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.black,
        ),
      ),
    ),
    description: 'A widget that makes its child partially transparent.',
    sourceCode: """Center(
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.black,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'DecoratedBox',
    widget: Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
          ),
        ),
        child: const SizedBox(
          width: 100,
          height: 100,
        ),
      ),
    ),
    description: 'A widget that paints a decoration either before or after its child paints.',
    sourceCode: """Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
          ),
        ),
        child: const SizedBox(
          width: 100,
          height: 100,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'RotatedBox',
    widget: const Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: Text('RotatedBox'),
      ),
    ),
    description: 'A widget that rotates its child by a number of quarter turns.',
    sourceCode: """const Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: Text('RotatedBox'),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'Transform',
    widget: Center(
      child: Transform.rotate(
        angle: 0.5,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.brown,
        ),
      ),
    ),
    description: 'A widget that applies a transformation to its child before painting.',
    sourceCode: """Center(
      child: Transform.rotate(
        angle: 0.5,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.brown,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'ClipRect',
    widget: Center(
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 0.5,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey,
          ),
        ),
      ),
    ),
    description: 'A widget that clips its child using a rectangle.',
    sourceCode: """Center(
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: 0.5,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey,
          ),
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'ClipRRect',
    widget: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.deepOrange,
        ),
      ),
    ),
    description: 'A widget that clips its child using a rounded rectangle.',
    sourceCode: """Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.deepOrange,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'ClipOval',
    widget: Center(
      child: ClipOval(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.deepPurple,
        ),
      ),
    ),
    description: 'A widget that clips its child using an oval.',
    sourceCode: """Center(
      child: ClipOval(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.deepPurple,
        ),
      ),
    )""",
  ),
  WidgetInfo(
    name: 'BackdropFilter',
    widget: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          fit: BoxFit.cover,
        ),
        Center(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: const Center(child: Text('Frosted glass')),
              ),
            ),
          ),
        ),
      ],
    ),
    description: 'A widget that applies a filter to the existing painted content and then paints the child.',
    sourceCode: """Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
          fit: BoxFit.cover,
        ),
        Center(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: const Center(child: Text('Frosted glass')),
              ),
            ),
          ),
        ),
      ],
    )""",
  ),
  WidgetInfo(
    name: 'CircularProgressIndicator',
    widget: const Center(child: CircularProgressIndicator()),
    description: 'A material design circular progress indicator, which spins to indicate that the application is busy.',
    sourceCode: "const Center(child: CircularProgressIndicator())",
  ),
  WidgetInfo(
    name: 'LinearProgressIndicator',
    widget: const Center(child: LinearProgressIndicator()),
    description: 'A material design linear progress indicator, also known as a progress bar.',
    sourceCode: "const Center(child: LinearProgressIndicator())",
  ),
  WidgetInfo(
    name: 'Slider',
    widget: const _SliderExample(),
    description: 'A slider can be used to select from either a continuous or a discrete set of values.',
    sourceCode: """
class _SliderExample extends StatefulWidget {
  const _SliderExample({Key? key}) : super(key: key);

  @override
  __SliderExampleState createState() => __SliderExampleState();
}

class __SliderExampleState extends State<_SliderExample> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}
""",
  ),
  WidgetInfo(
    name: 'Switch',
    widget: const _SwitchExample(),
    description: 'A two-state material design switch.',
    sourceCode: """
class _SwitchExample extends StatefulWidget {
  const _SwitchExample({Key? key}) : super(key: key);

  @override
  __SwitchExampleState createState() => __SwitchExampleState();
}

class __SwitchExampleState extends State<_SwitchExample> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: _isSwitched,
        onChanged: (value) {
          setState(() {
            _isSwitched = value;
          });
        },
      ),
    );
  }
}
""",
  ),
  WidgetInfo(
    name: 'Checkbox',
    widget: const _CheckboxExample(),
    description: 'A material design checkbox.',
    sourceCode: """
class _CheckboxExample extends StatefulWidget {
  const _CheckboxExample({Key? key}) : super(key: key);

  @override
  __CheckboxExampleState createState() => __CheckboxExampleState();
}

class __CheckboxExampleState extends State<_CheckboxExample> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: _isChecked,
        onChanged: (value) {
          setState(() {
            _isChecked = value!;
          });
        },
      ),
    );
  }
}
""",
  ),
];

class _SliderExample extends StatefulWidget {
  const _SliderExample({Key? key}) : super(key: key);

  @override
  __SliderExampleState createState() => __SliderExampleState();
}

class __SliderExampleState extends State<_SliderExample> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}

class _SwitchExample extends StatefulWidget {
  const _SwitchExample({Key? key}) : super(key: key);

  @override
  __SwitchExampleState createState() => __SwitchExampleState();
}

class __SwitchExampleState extends State<_SwitchExample> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: _isSwitched,
        onChanged: (value) {
          setState(() {
            _isSwitched = value;
          });
        },
      ),
    );
  }
}

class _CheckboxExample extends StatefulWidget {
  const _CheckboxExample({Key? key}) : super(key: key);

  @override
  __CheckboxExampleState createState() => __CheckboxExampleState();
}

class __CheckboxExampleState extends State<_CheckboxExample> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: _isChecked,
        onChanged: (value) {
          setState(() {
            _isChecked = value!;
          });
        },
      ),
    );
  }
}

