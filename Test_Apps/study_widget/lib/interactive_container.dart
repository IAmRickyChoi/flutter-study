import 'package:flutter/material.dart';

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
