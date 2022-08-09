import 'package:dreamlist/api/global_helpers.dart';
import 'package:dreamlist/constants/colors.dart';
import 'package:dreamlist/models/todo.dart';
import 'package:dreamlist/providers/todo_provider.dart';
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
        Divider(
          color: ConstantColors.grey,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
