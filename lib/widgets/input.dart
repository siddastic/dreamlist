import 'package:dreamlist/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Input extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? placeholder;
  final bool readonly;
  final bool nextInputAvailable;
  const Input({
    Key? key,
    this.controller,
    this.validator,
    this.placeholder,
    this.readonly = false,
    this.nextInputAvailable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      readOnly: readonly,
      textInputAction:
          nextInputAvailable ? TextInputAction.next : TextInputAction.done,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(
          color: ConstantColors.grey.withOpacity(.5),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: ConstantColors.grey,
            width: .25,
          ),
        ),
        // suffixIcon: Transform.scale(
        //   scale: .5,
        //   child: Container(
        //     padding: EdgeInsets.all(2),
        //     decoration: BoxDecoration(
        //       color: ConstantColors.grey.withOpacity(.25),
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     child: Icon(
        //       Ionicons.close,
        //       color: ConstantColors.grey,
        //       size: 30,
        //     ),
        //   ),
        // ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: .5,
          ),
        ),
      ),
    );
  }
}
