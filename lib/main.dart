import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/Screens/Auth/login-screen.dart';
import 'package:hasadak/Screens/Auth/signup-screen.dart';
import 'package:hasadak/Screens/Home/seeds/seeds-info-screen.dart';
import 'package:hasadak/Screens/OnBoarding/boarding-screen.dart';
import 'package:hasadak/Screens/SplashScreen/splash-screen.dart';
import 'package:hasadak/Screens/add-services/addservicescreen.dart';
import 'package:hasadak/Backend/firebase_options.dart';
import 'package:hasadak/Screens/Home/home-screen.dart';
import 'package:hasadak/provider/check-user.dart';
import 'package:hasadak/provider/finish-onboarding.dart';
import 'package:hasadak/Screens/Profile/user-profile-screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FinishOnboarding()),
    ChangeNotifierProvider(create: (_) => CheckUser()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        UserProfile.routeName: (context) => UserProfile(),
        AddServicePage.routeName: (context) => AddServicePage(),
        SeedsInfoScreen.routeName: (context) => SeedsInfoScreen(),
      },
    );
  }
}
