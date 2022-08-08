import 'package:animations/animations.dart';
import 'package:dreamlist/screens/home/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      floatingActionButton: OpenContainer(
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        closedBuilder: (ctx, openAction) {
          return FloatingActionButton(
            onPressed: openAction,
            child: Icon(Ionicons.add_outline, size: 30),
          );
        },
        openBuilder: (ctx, closeActions) {
          return AddTodoScreen();
        },
      ),
    );
  }
}
