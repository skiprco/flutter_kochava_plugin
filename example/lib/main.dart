import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_kochava_plugin/flutter_kochava_plugin.dart';
import 'secret.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await _testConfigure();
    await _testCustomEvent();
    await _testSearchEvent();
  }

  Future<void> _testConfigure() async {
    String key = null;
    if (Platform.isIOS) {
      key = iosKey;
    } else if (Platform.isAndroid) {
      key = androidKey;
    }
    if (key == null) {
      print("configureWith success");
      return;
    }
    try {
      await FlutterKochavaPlugin.configure(key: key);
      print("configureWith success");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _testCustomEvent() async {
    try {
      var event = KochavaCustomEvent(
        nameString: "testEvent ${Platform.isIOS ? "IOS" : "ANDROID"}",
        infoDictionary: {
          "custom_name": "test name",
          "age": 10,
          "happy": true,
        },
        userId: "userID1",
      );
      await FlutterKochavaPlugin.sendEvent(event);
      print("_testCustomEvent success");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _testSearchEvent() async {
    try {
      var event = KochavaSearchEvent(
          uri: "https://test", results: "some results", userId: "userID1");
      await FlutterKochavaPlugin.sendEvent(event);
      print("_testSearchEvent success");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('kochava example'),
        ),
        body: Container(),
      ),
    );
  }
}
