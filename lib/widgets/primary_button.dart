import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const PrimaryButton({Key? key, required this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        primary: Theme.of(context).primaryColor,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
