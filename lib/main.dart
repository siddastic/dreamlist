import 'package:dreamlist/screens/home/add_todo.dart';
import 'package:dreamlist/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff89cbf0),
        scaffoldBackgroundColor: const Color(0xfffefefe),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff46549e),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
