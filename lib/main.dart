import 'package:dreamlist/providers/todo_provider.dart';
import 'package:dreamlist/screens/auth/launch_decider.dart';
import 'package:dreamlist/screens/auth/login.dart';
import 'package:dreamlist/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
        primaryColor: const Color(0xff2EBAEF),
        scaffoldBackgroundColor: const Color(0xfffefefe),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff46549e),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        LaunchDecider.routeName: (ctx) => const LaunchDecider(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
