import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      required this.label,
      required this.hintText,
      this.onTap,
      this.readOnly = false,
      this.textStyle})
      : super(key: key);

  final TextEditingController? controller;
  final String label;
  final String hintText;
  final VoidCallback? onTap;
  final bool? readOnly;
  final TextStyle? textStyle;

  Icon? _getRightIcon() {
    if (label == 'Time') {
      return Icon(
        Icons.access_time_rounded,
        color: Colors.grey.withOpacity(0.5),
      );
    }
    if (label == 'Date') {
      return Icon(
        Icons.date_range,
        color: Colors.grey.withOpacity(0.5),
      );
    }
    if (label == 'Name') {
      return Icon(
        Icons.account_circle,
        color: Colors.grey.withOpacity(0.5),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle),
        TextField(
          readOnly: readOnly as bool,
          maxLines: label == 'Description' ? 5 : 1,
          controller: controller,
          style: textStyle,
          onTap: onTap,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(14),
            hintText: hintText,
            hintStyle: textStyle,
            suffixIcon: _getRightIcon(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: Colors.black,
              ),
            ),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(color: Colors.red)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
