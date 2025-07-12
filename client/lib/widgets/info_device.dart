import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoDevice extends StatefulWidget {
  const InfoDevice({super.key});

  @override
  State<InfoDevice> createState() => _InfoDeviceState();
}

class _InfoDeviceState extends State<InfoDevice> {
  String _appVersion = '';
  String _appBuild = '';
  String _deviceModel = '';
  String _androidVersion = '';
  String _supportedAbis = '';

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    final deviceInfoPlugin = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;

    if (Platform.isAndroid) {
      androidInfo = await deviceInfoPlugin.androidInfo;
    }

    setState(() {
      _appVersion = packageInfo.version;
      _appBuild = packageInfo.buildNumber;

      if (androidInfo != null) {
        _deviceModel = androidInfo.model;
        _androidVersion = androidInfo.version.release;
        _supportedAbis = androidInfo.supportedAbis.join(', ');
      }

      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelSmall;

    return DefaultTextStyle(
      style: textStyle ?? const TextStyle(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Version: $_appVersion'),
          Text('Build: $_appBuild'),
          Text('Model: $_deviceModel'),
          Text('Android Version: $_androidVersion'),
          Text('Supported Archs: $_supportedAbis'),
        ],
      ),
    );
  }
}
