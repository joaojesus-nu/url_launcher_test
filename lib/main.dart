import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final _url = Uri(scheme: 'tel', path: '*#06#');

void main() => runApp(
      const MaterialApp(
        home: Material(
          child: Center(
            child: ElevatedButton(
              onPressed: _launchUrl,
              child: Text('IMEI'),
            ),
          ),
        ),
      ),
    );

Future<void> _launchUrl() async {
  print(_url);
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $_url';
  }
}
