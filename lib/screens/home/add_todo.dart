import 'package:dreamlist/api/master_validator.dart';
import 'package:dreamlist/widgets/input.dart';
import 'package:dreamlist/widgets/primary_button.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _thingController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notificationController = TextEditingController();

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
          Form(
            key: _formKey,
            child: Column(
              children: [
                Input(
                  placeholder: "Thing",
                  controller: _thingController,
                  validator: MasterValidator.attach(
                    msgPrefix: "Title",
                    flags: [
                      ValidatorFlags.NonEmpty,
                    ],
                  ),
                ),
                const VSpace(),
                Input(
                  placeholder: "Place",
                  controller: _placeController,
                  validator: MasterValidator.attach(
                    msgPrefix: "Place",
                    flags: [
                      ValidatorFlags.NonEmpty,
                    ],
                  ),
                ),
                const VSpace(),
                Input(
                  placeholder: "Time",
                  controller: _timeController,
                  validator: MasterValidator.attach(
                    msgPrefix: "Time",
                    flags: [
                      ValidatorFlags.NonEmpty,
                    ],
                  ),
                ),
                const VSpace(),
                Input(
                  placeholder: "Notification",
                  controller: _notificationController,
                ),
              ],
            ),
          ),
          const VSpace(h: 25),
          PrimaryButton(
            label: "ADD YOUR THING",
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {}
            },
          ),
        ],
      ),
    );
  }
}
