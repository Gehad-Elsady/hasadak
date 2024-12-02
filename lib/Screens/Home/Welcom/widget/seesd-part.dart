import 'package:flutter/material.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/add-services/model/service-model.dart';
import 'package:hasadak/widget/services-item.dart';

class SeedsPart extends StatelessWidget {
  SeedsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215, // Adjust height as needed
      child: StreamBuilder<List<ServiceModel>>(
        stream: FirebaseFunctions.getSeeds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final services = snapshot.data;

          if (services == null || services.isEmpty) {
            return Center(child: Text('No services available'));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return SizedBox(
                width: 200, // Adjust width as needed
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ServicesItem(
                    service: service,
                    buttonTitle: "quick-order",
                    callBack: () {
                      // Add callback action here
                    },
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
