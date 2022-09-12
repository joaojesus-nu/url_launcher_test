import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ussd_service/ussd_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';

final _url = Uri(scheme: 'tel', path: Uri.encodeComponent('*#06#'));

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
  await Permission.phone.request();
  if (!await Permission.phone.isGranted) {
    throw Exception("permission missing");
  }
  SimData simData = await SimDataPlugin.getSimData();

  try {
    String? response = await UssdService.makeRequest(
        simData.cards.first.subscriptionId, "*#06#");
    print(response);
  } catch (e) {
    print('erro');
    print(e);
  }

  print('eae');
  print(_url);
  if (!await launchUrl(_url, mode: LaunchMode.externalNonBrowserApplication)) {
    throw 'Could not launch $_url';
  }
}
