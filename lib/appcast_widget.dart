import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class AppCastWidget extends StatelessWidget {
  const AppCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appcastURL =
        'https://raw.githubusercontent.com/jeejaykim/apispa/jeejaykim-test/test.xml';
    final cfg =
        AppcastConfiguration(url: appcastURL, supportedOS: ['android', 'ios']);

    return Scaffold(
        body: UpgradeAlert(
      upgrader: Upgrader(
        appcastConfig: cfg,
        debugLogging: true,
      ),
      child: const Center(child: Text('Checking for update...')),
    ));
  }
}
