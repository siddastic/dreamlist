import 'package:animations/animations.dart';
import 'package:dreamlist/constants/colors.dart';
import 'package:dreamlist/providers/todo_provider.dart';
import 'package:dreamlist/screens/home/add_todo.dart';
import 'package:dreamlist/widgets/todo_list_tile.dart';
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
    Provider.of<TodoProvider>(context, listen: false).loadTodos();
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
              "https://static.vecteezy.com/system/resources/thumbnails/005/101/992/small_2x/mountain-beautiful-landscape-background-abstract-illustration-free-vector.jpg",
              fit: BoxFit.cover,
            ),
          ),
          const VSpace(),
          const ListTile(
            title: Text(
              "INBOX",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: ConstantColors.grey,
              ),
            ),
          ),
          for (var todo
              in todoProvider.todos.where((element) => !element.isDone))
            TodoListTile(todo: todo),
          const VSpace(),
          ListTile(
            title: Row(
              children: [
                Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: ConstantColors.grey,
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ConstantColors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "${todoProvider.todos.where((element) => element.isDone).length}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (var todo
              in todoProvider.todos.where((element) => element.isDone))
            TodoListTile(todo: todo),
          const VSpace(h: 50),
        ],
      ),
      floatingActionButton: Material(
        shadowColor: Theme.of(context).primaryColor,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: OpenContainer(
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
      ),
    );
  }
}
