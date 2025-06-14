import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Auth/model/usermodel.dart';
import 'package:hasadak/photos/images.dart';
import 'package:lottie/lottie.dart';

class WelcomePart extends StatelessWidget {
  const WelcomePart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
        Locale currentLocale = context.locale;
    return FutureBuilder(
      future: FirebaseFunctions.readUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('${'error'.tr()}: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('no_user_data'.tr()));
        }

        var userData = snapshot.data;
        String userName = userData?.name ?? 'user'.tr();

        return SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 25),
                  Padding(
                    padding:  currentLocale.languageCode  == 'ar'? EdgeInsets.only(right: 20.0):EdgeInsets.only(left: 20),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(                          
                          'welcome_title'.tr(),
                            textStyle: GoogleFonts.domine(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                      isRepeatingAnimation: true,
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: currentLocale.languageCode == 'ar'? EdgeInsets.only(right: 20.0):EdgeInsets.only(left: 20),
                    child: Text(
                      userName,
                      style: GoogleFonts.domine(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding:  currentLocale.languageCode  == 'ar'? EdgeInsets.only(right: 20.0):EdgeInsets.only(left: 20),
                    child: Text(
                      'discover_text'.tr(),
                      style: GoogleFonts.domine(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: 30.0),
                child: Align(
                  alignment:  currentLocale.languageCode  == 'ar'? Alignment.topLeft: Alignment.topRight,
                  child: Lottie.asset(
                    "assets/lottie/Animation - 1733168275104.json",
                    width: MediaQuery.of(context).size.width * 0.55,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
