import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/style.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  final int? maxLines;
  final TextAlign? align;
  final TextStyle? style;

  const SimpleText(
    this.text, {
    Key? key,
    this.color,
    this.weight,
    this.size,
    this.maxLines,
    this.align,
    this.style,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      softWrap: true,
      textAlign: align ?? TextAlign.start,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: style ??
          GoogleFonts.montserrat(
            fontSize: size ?? 16,
            fontWeight: weight ?? FontWeight.w400,
            color: color ?? textBlackColor,
          ),
    );
  }
}
