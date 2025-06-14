import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Home/seeds/info-screen.dart';
import 'package:easy_localization/easy_localization.dart';


class CropsScreen extends StatelessWidget {
  const CropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
          child: Column(
            children: [
              // Title styling
              Text(
                'crops'.tr(),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 16),
              // StreamBuilder for fetching services
              StreamBuilder(
                stream: FirebaseFunctions.getCrops(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(child: Text('No services available'));
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
                        childAspectRatio: 0.65,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final service = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, InfoScreen.routeName,
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
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Image section with fixed height
                                  Container(
                                    height:
                                        150, // Set a fixed height for all images
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: service.image,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Text for name and price
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          service.name,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "${service.price} ${'egp'.tr()}",
                                            textAlign: context.locale.languageCode == 'ar' ? TextAlign.start : TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors
                                                .green[700], // Price in green
                                          ),
                                        ),
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
      ),
    );
  }
}
