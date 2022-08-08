import 'package:flutter/material.dart';

class AddTodoScreen extends StatelessWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        leading: Icon(Icons.arrow_back_sharp,),
      ),
    );
  }
}