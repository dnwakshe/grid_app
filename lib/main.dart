import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobi_task/get_grid_count.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SlpashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SlpashScreen extends StatefulWidget {
  const SlpashScreen({Key? key}) : super(key: key);

  @override
  State<SlpashScreen> createState() => _SlpashScreenState();
}

class _SlpashScreenState extends State<SlpashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Grid())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        // child: FlutterLogo(size: MediaQuery.of(context).size.height),
        child: const Center(
          child: Text(
            "Mobigic",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
