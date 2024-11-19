import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
