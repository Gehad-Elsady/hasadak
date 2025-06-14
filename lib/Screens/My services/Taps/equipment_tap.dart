import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/My%20services/update_services.dart';

class EquipmentTap extends StatelessWidget {
  const EquipmentTap({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            StreamBuilder(
              stream: FirebaseFunctions.getMyServices(
                  "Equipment", FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('error_loading_services'.tr()));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Center(child: Text('no_services_available'.tr()));
                } else {
                  return GridView.builder(
                    shrinkWrap:
                        true, // Allows GridView to be scrollable within the SingleChildScrollView
                    physics:
                        NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final service = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, UpdateServices.routeName,
                              arguments: service);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16), // Rounded corners
                          ),
                          elevation: 5, // Shadow effect
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16), // Rounded corners for the image
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Image section
                                Expanded(
                                  child: CachedNetworkImage(
                                    imageUrl: service.image,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                // Text for name and price
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        service.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "${service.price} ${'egp'.tr()}",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors
                                              .green[700], // Price in green
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      // Button for adding to cart
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            // padding: EdgeInsets.all(16),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('delete_service'.tr()),
                                                  content: Text('confirm_delete_service'.tr()),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('cancel'.tr())),
                                                    TextButton(
                                                        onPressed: () {
                                                          FirebaseFunctions
                                                              .deleteMyService(
                                                                  service
                                                                      .createdAt,
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('delete'.tr())),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'delete'.tr(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
