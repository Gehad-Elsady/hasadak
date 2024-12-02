import 'package:flutter/material.dart';
import 'package:hasadak/Screens/Auth/login-screen.dart';
import 'package:hasadak/Screens/add-services/addservicescreen.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Home/home-screen.dart';
import 'package:hasadak/Screens/Profile/user-profile-screen.dart';

import 'social-media-icons.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF4AD66D),
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, HomeScreen.routeName); // Navigate to Home
            },
          ),
          // ListTile(
          //   title: const Text('Recycle'),
          //   leading: const Icon(Icons.recycling),
          //   onTap: () {
          //     // Handle navigation to Recycle
          //     Navigator.pop(context); // Close drawer
          //     Navigator.pushNamed(
          //         context, RecycleUser.routeName); // Navigate to Recycle
          //   },
          // ),
          ListTile(
            title: const Text('Product'),
            leading: const Icon(Icons.production_quantity_limits),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AddServicePage.routeName);
            },
          ),
          ListTile(
            title: const Text('Shop'),
            leading: const Icon(Icons.store),
            onTap: () {
              // Handle navigation to Shop
              // Navigator.pop(context);
              // Navigator.pushNamed(context, '/shop');
            },
          ),
          ListTile(
            title: const Text('Contact'),
            leading: const Icon(Icons.contact_page),
            onTap: () {
              // Handle navigation to Contact
              // Navigator.pop(context);
              // Navigator.pushNamed(context, '/contact');
            },
          ),
          const Divider(), // Adds a horizontal line
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              // // Handle navigation to Profile
              // Navigator.pop(context);
              Navigator.pushNamed(context, UserProfile.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              FirebaseFunctions.signOut();
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
          ),
          Spacer(),
          SocialMediaIcons(),
        ],
      ),
    );
  }
}
