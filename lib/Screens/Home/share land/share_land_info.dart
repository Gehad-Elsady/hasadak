import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Add%20land/model/add_land_model.dart';
import 'package:hasadak/Screens/Home/share%20land/land_location.dart';

class LandInfoScreen extends StatelessWidget {
  static const String routeName = 'land-info-screen';

  const LandInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as AddLandModel?;

    if (model == null) {
      return Scaffold(
       appBar: AppBar(
          title: Text('land_details'.tr()),
        ),
        body: Center(
          child: Text('no_land_details'.tr()),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'investment_details'.tr(),
          style: GoogleFonts.domine(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF56ab91),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Implement add to cart functionality
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add_shopping_cart_rounded,
          color: Colors.green,
          size: 35,
        ),
        elevation: 8,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: model.image ?? '',
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error,
                            color: Colors.redAccent, size: 40),
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 280,
                    ),
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        model.address ?? 'no_address_available'.tr(),
                        style: GoogleFonts.domine(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                                                textAlign: context.locale.languageCode == 'ar' ? TextAlign.right : TextAlign.left,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Details Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailText('land_overview'.tr(), model.description),
                  const SizedBox(height: 12),
                  _buildPriceText(model.price),
                  const SizedBox(height: 12),
                  _buildDetailText('types_of_investment'.tr(), model.investmentType),
                  _buildDetailText('land_owner_name'.tr(), model.OwnerName),
                  _buildDetailText('land_owner_phone'.tr(), model.OwnerPhone),
                  _buildDetailText('land_space'.tr(), model.landSpace),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShareLandLocation(
                              longitude: model.locationModel!.longitude,
                              latitude: model.locationModel!.latitude,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.map, color: Colors.white),
                      label: Text(
                        'view_land_location'.tr(),
                        style: GoogleFonts.domine(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailText(String title, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: GoogleFonts.lato(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(
          value ?? 'no_data_available'.tr(),
          style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700]),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

 Widget _buildPriceText(String? price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${'price'.tr()}:',
          style: GoogleFonts.lato(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        const SizedBox(height: 5),
        Text(
          price != null ? '${'egp'.tr()} $price' : 'not_available'.tr(),
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.green[700],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
