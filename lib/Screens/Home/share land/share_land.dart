import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Home/share%20land/share_land_info.dart';

class ShareLand extends StatelessWidget {
  const ShareLand({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: double.infinity,
      width: double.infinity,
      child: StreamBuilder(
        stream: FirebaseFunctions.getLandStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
                       return Center(child: Text('error'.tr()));

          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(child: Text('no_lands_found'.tr()));
          }

          final services = snapshot.data!;
          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LandInfoScreen.routeName,
                      arguments: service);
                },
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black
                          .withOpacity(0.7), // Subtle dark background
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Image Section
                        ClipRRect(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: service.image!,
                            height: 200,
                            width: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),

                        // Content Section
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${'investment_type'.tr()}:\n',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      TextSpan(
                                        text: service.investmentType,
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "${'description'.tr()}: ${service.description}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "${'location'.tr()}: 📍 ${service.address}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                ),
                                SizedBox(height: 6),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
