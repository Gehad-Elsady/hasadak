import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/Screens/Add%20land/add_land.dart';
import 'package:hasadak/Screens/Auth/login-screen.dart';
import 'package:hasadak/Screens/Auth/signup-screen.dart';
import 'package:hasadak/Screens/Home/seeds/info-screen.dart';
import 'package:hasadak/Screens/Home/share%20land/share_land_info.dart';
import 'package:hasadak/Screens/My%20services/my_services_screen.dart';
import 'package:hasadak/Screens/My%20services/update_services.dart';
import 'package:hasadak/Screens/OnBoarding/boarding-screen.dart';
import 'package:hasadak/Screens/SplashScreen/splash-screen.dart';
import 'package:hasadak/Screens/add-services/addservicescreen.dart';
import 'package:hasadak/Backend/firebase_options.dart';
import 'package:hasadak/Screens/Home/home-screen.dart';
import 'package:hasadak/Screens/Admin/engineers/add_eng.dart';
import 'package:hasadak/Screens/cart/cart-screen.dart';
import 'package:hasadak/Screens/contact/contact-screen.dart';
import 'package:hasadak/Screens/history/historyscreen.dart';
import 'package:hasadak/Screens/my%20Requests/my_requests_screen.dart';
import 'package:hasadak/notifications/notification.dart';
import 'package:hasadak/provider/check-user.dart';
import 'package:hasadak/provider/finish-onboarding.dart';
import 'package:hasadak/Screens/Profile/user-profile-screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Optionally, initialize Firebase Analytics
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // Initialize Firebase Messaging with error handling
  MyNotification.initialize();
  //   await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  //   appleProvider: AppleProvider.deviceCheck,
  // );
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
        InfoScreen.routeName: (context) => InfoScreen(),
        AddEng.routeName: (context) => AddEng(),
        ContactScreen.routeName: (context) => ContactScreen(),
        CartScreen.routeName: (context) => CartScreen(),
        HistoryScreen.routeName: (context) => HistoryScreen(),
        AddLandPage.routeName: (context) => AddLandPage(),
        LandInfoScreen.routeName: (context) => LandInfoScreen(),
        MySecrvicesScreen.routeName: (context) => MySecrvicesScreen(),
        UpdateServices.routeName: (context) => UpdateServices(),
        MyRequestsScreen.routeName: (context) => MyRequestsScreen(),
      },
    );
  }
}
