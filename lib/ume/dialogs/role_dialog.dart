import 'package:flutter/material.dart';

class RoleDialog extends StatelessWidget {
  const RoleDialog({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Page'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Role Dialog'),
          ),
        ),
      ),
    );
  }
}
