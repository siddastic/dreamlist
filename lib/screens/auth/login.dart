import 'package:dreamlist/screens/home/home.dart';
import 'package:dreamlist/widgets/fade_animation.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: FadeAnimation(
              delay: 1,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(35, 37, 47, 1),
                    width: 10,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.asset('assets/images/app_icon.png'),
              ),
            ),
          ),
          const VSpace(),
          const FadeAnimation(
            delay: 5,
            child: Text(
              "DreamList",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          const Spacer(),
          FadeAnimation(
            delay: 15,
            child: SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () async {
                try {
                  final UserCredential userCredential =
                      await signInWithGoogle();
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                } catch (e) {
                  print(e);
                }
              },
            ),
          ),
          const VSpace(h: 20),
        ],
      ),
    );
  }
}
