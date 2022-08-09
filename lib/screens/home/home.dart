import 'package:animations/animations.dart';
import 'package:dreamlist/constants/colors.dart';
import 'package:dreamlist/providers/todo_provider.dart';
import 'package:dreamlist/screens/auth/login.dart';
import 'package:dreamlist/screens/home/add_todo.dart';
import 'package:dreamlist/widgets/home_page_header.dart';
import 'package:dreamlist/widgets/todo_list_tile.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
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
    var todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoProvider.loadTodos();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadComposition().then((value) {
        setState(() {
          todoProvider.attachHomeScreenVariables(context, value);
        });
      });
    });
    super.initState();
  }

  Future<LottieComposition> _loadComposition() async {
    var assetData =
        await rootBundle.load('assets/anim/confetti-animation.json');
    return await LottieComposition.fromByteData(assetData);
  }

  void showMenu() {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return Material(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Column(
                children: [
                  AppBar(
                    leading: IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: Icon(
                        Icons.close_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ListTile(
                    leading: firebaseUser.photoURL != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(firebaseUser.photoURL!),
                              ),
                            ],
                          )
                        : null,
                    title: Text(
                      firebaseUser.displayName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    subtitle: const Text(
                      "Logged in as",
                      style: TextStyle(
                        color: ConstantColors.grey,
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  const Divider(
                    color: ConstantColors.grey,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    leading: const Icon(
                      Ionicons.power,
                      color: Colors.red,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName, (route) => false);
                    },
                  ),
                  const VSpace(h: 20),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    if (!todoProvider.isTodosLoaded) {
      return Scaffold(
        body: Center(
          child: Transform.scale(
            scale: .5,
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          HomePageHeader(onMenuClick: showMenu),
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
          ListTile(
            title: Row(
              children: [
                const Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: ConstantColors.grey,
                  ),
                ),
                if (todoProvider.todos
                    .where((element) => element.isDone)
                    .isNotEmpty) ...[
                  const SizedBox(width: 5),
                  Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: ConstantColors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${todoProvider.todos.where((element) => element.isDone).length}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
