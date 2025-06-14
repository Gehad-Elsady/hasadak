import 'package:easy_localization/easy_localization.dart';
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
            MyDivider(text: 'seeds_section'.tr()),
            SeedsPart(),

            const SizedBox(height: 20), // Spacing between sections

            // Equipment section
            MyDivider(text: 'equipment_section'.tr()),
            EquipmentPart(),

            const SizedBox(height: 20), // Spacing between sections

            // Partners section
            MyDivider(text: 'partners_section'.tr()),
            const SizedBox(height: 10), // Spacing between sections

            PartnersPart(),
            const SizedBox(height: 20), // Spacing between sections
          ],
        ),
      ),
    );
  }
}
