import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String label;
  final double? fontSize;
  final Color? fontColor;
  final bool alignment;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;

  MyText({
    super.key,
    required this.label,
    this.fontSize,
    this.fontColor,
    this.alignment = false,
    this.fontWeight,
    this.maxLines,
    this.overflow,
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
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.visible,
      textAlign: alignment ? TextAlign.center : TextAlign.start,
    );
  }
}
