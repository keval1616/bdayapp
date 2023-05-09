import 'package:flutter/material.dart';

class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;

  const CommonAppButton({
    Key? key,
    this.onTap,
    this.text,
    this.color,
    this.icon,
    this.textColor,
    this.style,
    this.borderRadius,
    this.width,
    this.boxShadow,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: width ?? 145,
        decoration: BoxDecoration(
            border: border,
            color: color ?? Colors.amber,
            borderRadius: BorderRadius.circular(borderRadius!),
            boxShadow: boxShadow),
        child: Center(
          child: Text(text!, style: style),
        ),
      ),
    );
  }
}
