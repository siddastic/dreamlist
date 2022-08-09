import 'package:dreamlist/screens/auth/login.dart';
import 'package:dreamlist/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LaunchDecider extends StatefulWidget {
  static const String routeName = "/launch_decider";
  const LaunchDecider({Key? key}) : super(key: key);

  @override
  State<LaunchDecider> createState() => _LaunchDeciderState();
}

class _LaunchDeciderState extends State<LaunchDecider> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Center(
        child: Transform.scale(
          scale: .5,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
