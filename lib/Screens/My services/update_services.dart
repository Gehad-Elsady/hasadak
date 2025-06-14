import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Screens/add-services/model/service-model.dart';
import 'package:image_picker/image_picker.dart';

class UpdateServices extends StatefulWidget {
  static const String routeName = 'update_services';
  const UpdateServices({super.key});

  @override
  State<UpdateServices> createState() => _UpdateServicesState();
}

class _UpdateServicesState extends State<UpdateServices> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  Timestamp? _createdAt;
  String? _selectedServiceType;
  final List<String> _serviceTypes = ['Seeds', 'Equipment', "crops"];

  File? _image;
  String? _imageUrl; // To hold network image URL
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve arguments passed to the page
    final data = ModalRoute.of(context)!.settings.arguments as ServiceModel?;

    // Initialize controllers and image
    if (data != null) {
      _nameController.text = data.name ?? '';
      _descriptionController.text = data.description ?? '';
      _priceController.text = data.price?.toString() ?? '';
      _createdAt = data.createdAt;
      _selectedServiceType = data.type;
      if (data.image != null && data.image!.isNotEmpty) {
        if (data.image!.startsWith('http')) {
          _imageUrl = data.image; // If the image URL is already a network image
        } else {
          _image = File(data.image!); // Otherwise, assume it's a local path
        }
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _imageUrl = null; // Reset network image URL
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('service_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(image);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _updateService() async {
    if (_formKey.currentState!.validate() &&
        (_image != null || _imageUrl != null)) {
      setState(() => _isUploading = true);
      String? imageUrl;

      // If the image is a new file, upload it, otherwise use the network URL
      if (_image != null) {
        imageUrl = await _uploadImage(_image!);
      } else {
        imageUrl = _imageUrl;
      }

      if (imageUrl != null) {
        // Query to find the document based on `id` and `createdAt`
        final querySnapshot = await FirebaseFirestore.instance
            .collection('services')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('createdAt', isEqualTo: _createdAt)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If the document exists, update it
          final docId = querySnapshot.docs.first.id;
          await FirebaseFirestore.instance
              .collection('services')
              .doc(docId)
              .update({
            'name': _nameController.text.trim(),
            'description': _descriptionController.text.trim(),
            'price': _priceController.text.trim(),
            'image': imageUrl,
            'updatedAt': Timestamp.now(),
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Service updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Service not found or already updated'),
              backgroundColor: Colors.red,
            ),
          );
        }
        setState(() => _isUploading = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload image'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'update_service'.tr(),
          style: GoogleFonts.domine(
            fontSize: 30,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'service_details'.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'service_name'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'enter_service_name'.tr() : null,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'service_description'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        maxLines: 3,
                        validator: (value) => value!.isEmpty
                            ? 'enter_service_description'.tr()
                            : null,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'service_price'.tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? 'enter_service_price'.tr() : null,
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'service_type'.tr(),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                        ),
                        value: _selectedServiceType,
                        items: _serviceTypes
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedServiceType = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'select_service_type'.tr()
                            : null,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'image'.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _image == null && _imageUrl == null
                          ? Text(
                              'image-error'.tr(),
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            )
                          : _imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    _imageUrl!,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(_image!, height: 150),
                                ),
                      SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: _pickImage,
                        icon: Icon(Icons.image),
                        label: Text('pick_image'.tr()),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            _isUploading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _updateService,
                    child: Text('update_service'.tr(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
