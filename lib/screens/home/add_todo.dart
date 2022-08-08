import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(
            Ionicons.arrow_back_outline,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Ionicons.options_outline))
        ],
      ),
    );
  }
}
