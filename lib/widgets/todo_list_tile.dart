import 'package:dreamlist/api/global_helpers.dart';
import 'package:dreamlist/constants/colors.dart';
import 'package:dreamlist/models/todo.dart';
import 'package:dreamlist/providers/todo_provider.dart';
import 'package:dreamlist/screens/home/home.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class TodoListTile extends StatefulWidget {
  final Todo todo;
  const TodoListTile({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  void popUntilHome() {
    Navigator.of(context).popUntil(ModalRoute.withName(HomeScreen.routeName));
  }

  void showOptionsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VSpace(),
            Container(
              width: 50,
              height: 3,
              decoration: BoxDecoration(
                color: ConstantColors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const VSpace(h: 25),
            if (widget.todo.description != null) ...[
              Text(
                widget.todo.description!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ConstantColors.grey,
                ),
              ),
              const VSpace(),
              Divider(color: ConstantColors.grey),
            ],
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: const Icon(
                Ionicons.pencil,
                color: ConstantColors.grey,
              ),
              title: const Text(
                "Edit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ConstantColors.grey,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Provider.of<TodoProvider>(context, listen: false)
                    .removeTodo(widget.todo);
                popUntilHome();
              },
              leading: const Icon(
                Ionicons.trash,
                color: Colors.red,
              ),
              title: const Text(
                "Delete",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ConstantColors.grey,
                ),
              ),
            ),
            const VSpace(h: 20),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: false);
    final endDate = widget.todo.endDate;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {
            todoProvider.changeTodoStatus(widget.todo);
          },
          onLongPress: showOptionsSheet,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.todo.isDone ? Ionicons.checkmark : Icons.circle_outlined,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
            ],
          ),
          title: Text(
            widget.todo.title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            widget.todo.place,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: ConstantColors.grey,
            ),
          ),
          trailing: Text(
            "${GlobalHelpers.doubleDigits(endDate.day)}/${GlobalHelpers.doubleDigits(endDate.month)}",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: ConstantColors.grey,
              fontSize: 12,
            ),
          ),
        ),
        const Divider(
          color: ConstantColors.grey,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
