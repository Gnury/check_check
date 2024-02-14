import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController detailsController;
  const TextInputField({
    super.key,
    required this.detailsController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: TextField(
            controller: detailsController,
            maxLines: null,
            maxLength: 500,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFF2F2F7),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFF6229EE),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "คุณอยากจะ Check อะไรมั้ย...",
              hintStyle: const TextStyle(
                color: Color(0xFFC7C7CC),
                fontSize: 14,
                fontFamily: 'Mitr',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }
}
