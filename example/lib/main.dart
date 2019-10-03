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
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await _testConfigureAndroid();
    await _testCustomEvent();
    await _testSearchEvent();
  }

  Future<void> _testConfigureAndroid() async {
    try {
      await FlutterKochavaPlugin.configure(key: androidKey);
      print("configureWith success");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _testConfigureIos() async {
    try {
      await FlutterKochavaPlugin.configure(key: iosKey);
      print("configureWith success");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _testCustomEvent() async {
    try {
      var event = KochavaCustomEvent(
        nameString: "testEvent",
        infoDictionary: {
          "custom_name": "test name",
          "age": 10,
          "happy": true,
        },
      );
      await FlutterKochavaPlugin.sendEvent(event);
      print("_testCustomEvent success");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _testSearchEvent() async {
    try {
      var event =
          KochavaSearchEvent(uri: "https://test", results: "some results");
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
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
