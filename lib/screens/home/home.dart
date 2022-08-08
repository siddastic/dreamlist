import 'package:animations/animations.dart';
import 'package:dreamlist/constants/colors.dart';
import 'package:dreamlist/providers/todo_provider.dart';
import 'package:dreamlist/screens/home/add_todo.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<TodoProvider>(context,listen: false).loadTodos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 270,
            child: Image.network(
              "https://i.pinimg.com/originals/0c/a0/dd/0ca0ddd9bf8dfee8a2c26227bf21f6b8.gif",
              fit: BoxFit.cover,
            ),
          ),
          VSpace(),
          ListTile(
            title: Text(
              "INBOX",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: ConstantColors.grey,
              ),
            ),
          ),
          VSpace(),
          ListTile(
            title: Text(
              "Completed",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: ConstantColors.grey,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: OpenContainer(
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        closedBuilder: (ctx, openAction) {
          return FloatingActionButton(
            onPressed: openAction,
            child: const Icon(Ionicons.add_outline, size: 30),
          );
        },
        openBuilder: (ctx, closeActions) {
          return const AddTodoScreen();
        },
      ),
    );
  }
}
