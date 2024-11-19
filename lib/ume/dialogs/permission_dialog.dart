import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Page'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Permission Dialog'),
          ),
        ),
      ),
    );
  }
}
