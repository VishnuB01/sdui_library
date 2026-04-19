import 'package:flutter/material.dart';

class SampleExportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: Key('export_container'),
          width: 100,
          height: 100,
          child: Text('Hello widget'),
        ),
      ],
    );
  }
}
