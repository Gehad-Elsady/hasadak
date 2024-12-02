import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDivider extends StatelessWidget {
  String text;
  MyDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Color(0xffffffff),
            thickness: 3,
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(text,
                style: GoogleFonts.domine(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffffffff)))),
        Expanded(
          child: Divider(
            color: Color(0xffffffff),
            thickness: 3,
          ),
        ),
      ],
    );
  }
}
