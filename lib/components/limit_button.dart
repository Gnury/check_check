import 'package:flutter/material.dart';

class LimitButton extends StatelessWidget {
  const LimitButton({
    super.key,
    required this.onPressButton,
    required this.isChecked,
  });

  final void Function(bool isPress) onPressButton;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final Icon displayedButton = isChecked
        ? const Icon(
            Icons.remove_circle,
            color: Color(0xFF6229EE),
            size: 22,
          )
        : const Icon(
            Icons.add_circle_outline,
            color: Color(0xFF6229EE),
            size: 22,
          );

    return IconButton(
      onPressed: () {
        onPressButton(!isChecked);
      },
      icon: displayedButton,
    );
  }
}
