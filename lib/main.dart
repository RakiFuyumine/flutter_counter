import 'package:flutter/material.dart';
import 'package:flutter_counter/screens/CounterPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static String appName = "Counter App";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: darkTheme(),
      initialRoute: "/",
      routes: {
        '/': (context) => CounterPage(),
      },
    );
  }
  ThemeData darkTheme() {
    return ThemeData(
      backgroundColor: Colors.red,
      scaffoldBackgroundColor: Colors.white70,
      appBarTheme: AppBarTheme(
        color: Colors.blue
      ),
      primarySwatch: Colors.blue,
    );
  }
}