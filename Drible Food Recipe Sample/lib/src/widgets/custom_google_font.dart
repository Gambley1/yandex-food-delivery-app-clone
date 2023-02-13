import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomGoogleFontText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final TextAlign? textAlign;
  const CustomGoogleFontText({
    Key? key,
    required this.text,
    this.textStyle,
    this.textOverflow,
    this.maxLines,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Quicksand',
        textStyle: textStyle ??
            const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
      ),
      overflow: textOverflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.justify,
    );
  }
}
