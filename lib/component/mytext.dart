import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String label;
  double? fontSize;
  Color? fontColor;
  bool alignment;
  FontWeight? fontWeight;

  MyText({
    super.key,
    required this.label,
    this.fontSize,
    this.fontColor,
    this.alignment = false,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: fontSize ?? 14,
        color: fontColor ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: alignment ? TextAlign.center : TextAlign.start,
    );
  }
}
