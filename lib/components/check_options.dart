import 'package:check_check_app/components/options_button.dart';
import 'package:flutter/material.dart';

class CheckOptions extends StatelessWidget {
  final Function() onAddOption;
  final bool isTap;
  const CheckOptions({
    super.key,
    required this.onAddOption,
    required this.isTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            OptionsButton(
              onTap: () => onAddOption(),
              isTap: isTap,
            ),
          ],
        ),
      ],
    );
  }
}
