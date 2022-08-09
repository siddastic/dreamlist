import 'package:dreamlist/api/global_helpers.dart';
import 'package:dreamlist/constants/colors.dart';
import 'package:dreamlist/constants/months.dart';
import 'package:dreamlist/providers/todo_provider.dart';
import 'package:dreamlist/widgets/touchable_opacity.dart';
import 'package:dreamlist/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageHeader extends StatefulWidget {
  const HomePageHeader({Key? key}) : super(key: key);

  @override
  State<HomePageHeader> createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    final view = MediaQuery.of(context).size;
    var completedPercent = todoProvider.todos.where((element) => element.isDone).length / todoProvider.todos.length;
    var today = DateTime.now();
    return SizedBox(
      height: 270,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 270,
            child: Image.network(
              "https://www.creativefabrica.com/wp-content/uploads/2021/02/07/mountain-ridge-vector-illustration-Graphics-8396821-1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SizedBox(
              width: view.width,
              child: Row(
                children: [
                  SizedBox(
                    width: view.width * .6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: AppBar(
                            toolbarHeight: 0,
                          ),
                        ),
                        TouchableOpacity(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 30,
                                  height: 3,
                                  color: Colors.white,
                                ),
                                const VSpace(h: 5),
                                Container(
                                  width: 22,
                                  height: 3,
                                  color: Colors.white,
                                ),
                                const VSpace(h: 5),
                                Container(
                                  width: 30,
                                  height: 3,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const VSpace(h: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Your\nThings",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const VSpace(h: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "${Months.short[today.month - 1]} ${today.day}, ${today.year}",
                            style: GoogleFonts.roboto(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black26,
                    width: view.width * .4,
                    padding: const EdgeInsets.only(right: 16, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Transform.scale(
                              scale: .5,
                              child: CircularProgressIndicator(
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.25),
                                value: completedPercent,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${GlobalHelpers.doubleDigits((completedPercent * 100).round())}% done",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              width: view.width * completedPercent,
              height: 4,
              color: completedPercent == 1 ? Colors.green.shade300 : Theme.of(context).primaryColor,
              duration: Duration(milliseconds: 150),
            ),
          ),
        ],
      ),
    );
  }
}
