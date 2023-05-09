import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnValidation = dynamic Function(String? text);

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final String hint;
  final Widget? suffixIcon;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  const InputField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.hint = "",
    this.onChange,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.greenAccent,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      maxLines: maxLine,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 10.0),
        isDense: true,
        hintText: hint,
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
            color: Colors.greenAccent,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      textInputAction: textInputAction ?? TextInputAction.done,
      keyboardType: keyboardType ?? TextInputType.name,
      onChanged: (val) {
        if (onChange != null) {
          onChange!(val);
        }
      },
      validator: (val) {
        if (validator != null) {
          return validator!(val);
        } else {
          return null;
        }
      },
    );
  }
}
