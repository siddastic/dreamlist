import 'package:dreamlist/api/global_helpers.dart';
import 'package:dreamlist/api/master_validator.dart';
import 'package:dreamlist/constants/db.dart';
import 'package:dreamlist/models/todo.dart';
import 'package:dreamlist/providers/todo_provider.dart';
import 'package:dreamlist/widgets/fade_animation.dart';
import 'package:dreamlist/widgets/input.dart';
import 'package:dreamlist/widgets/primary_button.dart';
import 'package:dreamlist/widgets/touchable_opacity.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  final Todo? editModeTodo;
  final Function()? onEditSave;
  const AddTodoScreen({Key? key, this.editModeTodo, this.onEditSave})
      : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _thingController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notificationController = TextEditingController();
  DateTime? selectedEndTime;

  void selectEndTime() async {
    selectedEndTime = await showDatePicker(
      context: context,
      initialDate: selectedEndTime ?? DateTime.now(),
      firstDate: DateTime(1995),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      currentDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (selectedEndTime == null) return;
    setState(() {
      _timeController.text =
          "${selectedEndTime!.day} - ${selectedEndTime!.month} - ${selectedEndTime!.year}";
    });
  }

  Todo constructTodo() {
    return Todo(
      id: DBRefs.todosCollection.doc().id,
      title: _thingController.text,
      place: _placeController.text,
      createdAt: DateTime.now(),
      endDate: selectedEndTime!,
      description: _notificationController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: false);
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
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text("Not implemented"),
                ),
              );
            },
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
                FadeAnimation(
                  delay: 1,
                  child: Input(
                    placeholder: "Thing",
                    nextInputAvailable: true,
                    controller: _thingController,
                    validator: MasterValidator.attach(
                      msgPrefix: "Title",
                      flags: [
                        ValidatorFlags.NonEmpty,
                      ],
                    ),
                  ),
                ),
                const VSpace(),
                FadeAnimation(
                  delay: 2,
                  child: Input(
                    placeholder: "Place",
                    controller: _placeController,
                    validator: MasterValidator.attach(
                      msgPrefix: "Place",
                      flags: [
                        ValidatorFlags.NonEmpty,
                      ],
                    ),
                  ),
                ),
                const VSpace(),
                FadeAnimation(
                  delay: 3,
                  child: TouchableOpacity(
                    onTap: selectEndTime,
                    child: IgnorePointer(
                      ignoring: true,
                      child: Input(
                        readonly: true,
                        placeholder: "End date",
                        controller: _timeController,
                        validator: MasterValidator.attach(
                          msgPrefix: "Time",
                          flags: [
                            ValidatorFlags.NonEmpty,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const VSpace(),
                FadeAnimation(
                  delay: 4,
                  child: Input(
                    placeholder: "Description (optional)",
                    controller: _notificationController,
                  ),
                ),
              ],
            ),
          ),
          const VSpace(h: 25),
          FadeAnimation(
            delay: 4,
            child: PrimaryButton(
              label: "ADD YOUR THING",
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  GlobalHelpers.hideKeyboard();
                  todoProvider.addTodo(constructTodo());
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
