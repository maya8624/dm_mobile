import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediumText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overFlow;
  FontWeight fontWeight;

  MediumText({
    super.key,
    this.color = Colors.white,
    required this.text,
    this.size = 18,
    this.height = 1.2,
    this.overFlow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontFamily: GoogleFonts.roboto().fontFamily,
        fontSize: size,
        height: height,
        fontWeight: fontWeight,
      ),
    );
  }
}
