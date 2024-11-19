import 'package:flutter/material.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Page'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Language Dialog'),
          ),
        ),
      ),
    );
  }
}
