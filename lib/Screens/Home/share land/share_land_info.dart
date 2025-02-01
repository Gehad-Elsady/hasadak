import 'package:cached_network_image/cached_network_image.dart';
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
          title: const Text('Land Details'),
        ),
        body: const Center(
          child: Text('No land details available.'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Investment Details',
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
                        model.address ?? 'No Address Available',
                        style: GoogleFonts.domine(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
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
                  _buildDetailText('Land Overview', model.description),
                  const SizedBox(height: 12),
                  _buildPriceText(model.price),
                  const SizedBox(height: 12),
                  _buildDetailText('Types Of Investment', model.investmentType),
                  _buildDetailText('Land Owner Name', model.OwnerName),
                  _buildDetailText('Land Owner Phone', model.OwnerPhone),
                  _buildDetailText('Land Space', model.landSpace),
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
                        'View Land Location',
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
          value ?? 'No Data Available',
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
    return RichText(
      text: TextSpan(
        style: GoogleFonts.lato(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
        children: [
          const TextSpan(text: 'Price: '),
          TextSpan(
            text: price != null ? '\$$price' : 'Not Available',
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: price != null ? Colors.green : Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
