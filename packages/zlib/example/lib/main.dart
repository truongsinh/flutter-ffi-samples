
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:zlib/zlib.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _zlibV = 'Unknown';
  int _zlibInitReturn = -1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String zlibV = zlibVersion();
    int zlibInitReturn = deflateInit();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _zlibV = zlibV;
      _zlibInitReturn = zlibInitReturn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Zlib version: $_zlibV\nInit return: $_zlibInitReturn\n'),
        ),
      ),
    );
  }
}
