import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Screens/Add%20land/add_land.dart';
import 'package:hasadak/Screens/Auth/login-screen.dart';
import 'package:hasadak/Screens/My%20services/my_services_screen.dart';
import 'package:hasadak/Screens/add-services/addservicescreen.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Home/home-screen.dart';
import 'package:hasadak/Screens/Profile/user-profile-screen.dart';
import 'package:hasadak/Screens/Admin/engineers/add_eng.dart';
import 'package:hasadak/Screens/cart/cart-screen.dart';
import 'package:hasadak/Screens/contact/contact-screen.dart';
import 'package:hasadak/Screens/history/historyscreen.dart';
import 'package:hasadak/Screens/my%20Requests/my_requests_screen.dart';

import 'social-media-icons.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
                stream: FirebaseFunctions.getUserProfile(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color(0xFF14746f),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              snapshot.data!.profileImage,
                            ),
                          ),
                          Text(
                            snapshot.data!.email,
                            style: GoogleFonts.domine(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFF14746f),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFF2e6f95),
                      ),
                      child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/thumbnails/005/720/408/small_2x/crossed-image-icon-picture-not-available-delete-picture-symbol-free-vector.jpg',
                          )),
                    );
                  }
                }),
            ListTile(
              title: Text(
                'Home',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.home, color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, HomeScreen.routeName); // Navigate to Home
              },
            ),
            ListTile(
              title: Text(
                'Cart',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.shopping_cart_outlined,
                  color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),

            ListTile(
              title: Text(
                'Sell Service',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.store, color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AddServicePage.routeName);
              },
            ),
            ListTile(
              title: Text(
                'Shared Land',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: ImageIcon(
                  AssetImage(
                      "assets/images/environmental-stewardship_18455514.png"),
                  color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AddLandPage.routeName);
              },
            ),
            ListTile(
              title: Text(
                'My Services',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.miscellaneous_services_rounded,
                  color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MySecrvicesScreen.routeName);
              },
            ),
            ListTile(
              title: Text(
                'My Requests',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.shopping_bag, color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, MyRequestsScreen.routeName);
              },
            ),
            ListTile(
              title: Text(
                'History',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.history_toggle_off_outlined,
                  color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, HistoryScreen.routeName);
              },
            ),

            ListTile(
              title: Text(
                'Contact Us',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(Icons.contact_page, color: Color(0xFF56ab91)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ContactScreen.routeName);
              },
            ),
            const Divider(), // Adds a horizontal line
            ListTile(
              leading:
                  const Icon(Icons.account_circle, color: Color(0xFF56ab91)),
              title: Text(
                'Profile',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // // Handle navigation to Profile
                // Navigator.pop(context);
                Navigator.pushNamed(context, UserProfile.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF56ab91)),
              title: Text(
                'Logout',
                style: GoogleFonts.domine(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                FirebaseFunctions.signOut();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
            ),
            // Spacer(),
            SocialMediaIcons(),
          ],
        ),
      ),
    );
  }
}
