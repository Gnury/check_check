import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  final Function() onTap;
  final bool isTap;

  const OptionsButton({
    super.key,
    required this.onTap,
    required this.isTap,
  });

  @override
  Widget build(BuildContext context) {
    final Icon displayedButton = isTap
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
        onTap();
      },
      icon: displayedButton,
    );
  }
}
