import 'package:flutter/material.dart';
import 'package:hasadak/Screens/Home/Welcom/widget/equipment-part.dart';
import 'package:hasadak/Screens/Home/Welcom/widget/partners-part.dart';
import 'package:hasadak/Screens/Home/Welcom/widget/seesd-part.dart';
import 'package:hasadak/Screens/Home/Welcom/widget/welcome-part.dart';
import 'package:hasadak/widget/Divider/mydevider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF56ab91),
              Color(0xFF14746f),
            ],
          ),
        ),
        child: Column(
          children: [
            // Welcome part
            WelcomePart(),

            const SizedBox(height: 20), // Spacing between sections

            // Seeds section
            MyDivider(text: "Seeds"),
            SeedsPart(),

            const SizedBox(height: 20), // Spacing between sections

            // Equipment section
            MyDivider(text: "Equipment"),
            EquipmentPart(),

            const SizedBox(height: 20), // Spacing between sections

            // Partners section
            MyDivider(text: "Partners"),
            const SizedBox(height: 10), // Spacing between sections

            PartnersPart(),
            const SizedBox(height: 20), // Spacing between sections
          ],
        ),
      ),
    );
  }
}
