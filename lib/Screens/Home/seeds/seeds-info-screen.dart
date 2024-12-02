import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/Screens/add-services/model/service-model.dart';

class SeedsInfoScreen extends StatelessWidget {
  static const String routeName = 'seeds-info-screen';
  const SeedsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as ServiceModel?;

    // Check if the model is null to prevent errors in case of missing arguments
    if (model == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Seed Details'),
        ),
        body: const Center(
          child: Text('No service details available.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${model.name} Seeds'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: model.image,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          const SizedBox(height: 16),
          Text(
            'Name: ${model.name}',
          ),
          const SizedBox(height: 8),
          Text(
            'Description: ${model.description}',
          ),
          // Add more fields from the model as needed
        ],
      ),
    );
  }
}
