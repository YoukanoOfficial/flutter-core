import 'package:flutter/material.dart';

class MonitorDialog extends StatelessWidget {
  const MonitorDialog({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitor Page'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Monitor Dialog'),
          ),
        ),
      ),
    );
  }
}
