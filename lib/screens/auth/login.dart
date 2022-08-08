import 'package:dreamlist/widgets/fade_animation.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

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
              onPressed: () {},
            ),
          ),
          const VSpace(h: 20),
        ],
      ),
    );
  }
}
