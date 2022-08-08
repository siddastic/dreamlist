import 'package:dreamlist/widgets/input.dart';
import 'package:dreamlist/widgets/primary_button.dart';
import 'package:dreamlist/widgets/v_space.dart';
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
          icon: const Icon(
            Ionicons.arrow_back_outline,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Add new thing",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.options_outline),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Ionicons.pencil,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Input(
            placeholder: "Thing",
          ),
          VSpace(),
          Input(
            placeholder: "Place",
          ),
          VSpace(),
          Input(
            placeholder: "Time",
          ),
          VSpace(),
          Input(
            placeholder: "Notification",
          ),
          VSpace(h: 25),
          PrimaryButton(
            label: "ADD YOUR THING",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
