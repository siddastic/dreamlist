import 'package:flutter/material.dart';

class VSpace extends StatelessWidget {
  final double h;
  const VSpace({Key? key, this.h = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
    );
  }
}
