import 'package:dreamlist/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dreamlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff89cbf0),
        scaffoldBackgroundColor: const Color(0xfffefefe),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff46549e),
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
