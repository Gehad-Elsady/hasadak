import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Add%20land/model/add_land_model.dart';
import 'package:hasadak/Screens/Profile/model/profilemodel.dart';
import 'package:hasadak/location/model/land_location.dart';
import 'package:hasadak/widget/Drawer/mydrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddLandPage extends StatefulWidget {
  static const String routeName = 'AddLandPage';

  @override
  _AddLandPageState createState() => _AddLandPageState();
}

class _AddLandPageState extends State<AddLandPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _spaceController = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  // Dropdown variables
  String? _selectedServiceType;
  final List<String> _serviceTypes = [
    'Full Investment',
    'Half Investment',
    "Hasadak Investment"
  ];
  String? _selectedLandSpeciesType;
  final List<String> _landSpeciesTypes = [
    'carat',
    'acre',
  ];

  // Pick an image
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Upload image to Firebase Storage and get URL
  Future<String?> _uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('land_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(image);
      return await storageRef.getDownloadURL(); // Fix here
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Land',
          style: GoogleFonts.domine(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF56ab91),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 24),

                  // Land Location
                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Land Location',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      // Define the border
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color when enabled
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black, // Border color when focused
                          width: 2.0, // Border width
                        ),
                      ),
                    ),
                    validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Please enter a name' : null,
                  ),
                  SizedBox(height: 16),

                  // Description
                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      // Define the border
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color when enabled
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black, // Border color when focused
                          width: 2.0, // Border width
                        ),
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) => (value?.isEmpty ?? true)
                        ? 'Please enter a description'
                        : null,
                  ),
                  SizedBox(height: 16),

                  // Price
                  TextFormField(
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      // Define the border
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color when enabled
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.green, // Border color when focused
                          width: 2.0, // Border width
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => (value?.isEmpty ?? true)
                        ? 'Please enter a price'
                        : null,
                  ),
                  SizedBox(height: 16),
                  // Investment Type Dropdown
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),

                          decoration: InputDecoration(
                            labelText: 'Space Type',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            // Define the border
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                              borderSide: const BorderSide(
                                color: Colors.white, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color:
                                    Colors.white, // Border color when enabled
                                width: 2.0, // Border width
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color:
                                    Colors.black, // Border color when focused
                                width: 2.0, // Border width
                              ),
                            ),
                          ),
                          value: _selectedLandSpeciesType,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.white), // White dropdown icon
                          dropdownColor: Color.fromARGB(255, 13, 56, 43),
                          // Optional: Background color of the dropdown menu

                          isExpanded:
                              true, // Ensures dropdown does not overflow
                          items: _landSpeciesTypes
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedLandSpeciesType = value;
                            });
                          },
                          validator: (value) => value == null
                              ? 'Please select a space type'
                              : null,
                        ),
                      ),
                      SizedBox(width: 8), // Reduce spacing to avoid overflow
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          controller: _spaceController,
                          decoration: InputDecoration(
                            labelText: 'Land Space',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            // Define the border
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                              borderSide: const BorderSide(
                                color: Colors.white, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color:
                                    Colors.white, // Border color when enabled
                                width: 2.0, // Border width
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color:
                                    Colors.black, // Border color when focused
                                width: 2.0, // Border width
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) => (value?.isEmpty ?? true)
                              ? 'Please enter the land space'
                              : null,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  // Investment Type Dropdown
                  DropdownButtonFormField<String>(
                    style: const TextStyle(color: Colors.white, fontSize: 20),

                    decoration: InputDecoration(
                      labelText: 'Investment Type',
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      // Define the border
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.white, // Border color when enabled
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black, // Border color when focused
                          width: 2.0, // Border width
                        ),
                      ),
                    ),
                    value: _selectedServiceType,
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Colors.white), // White dropdown icon
                    dropdownColor: Color.fromARGB(255, 13, 56, 43),

                    items: _serviceTypes
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedServiceType = value;
                      });
                    },
                    validator: (value) => value == null
                        ? 'Please select an investment type'
                        : null,
                  ),
                  SizedBox(height: 16),

                  // Image Picker
                  _image == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'No image selected',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : Image.file(_image!, height: 150, fit: BoxFit.cover),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text(
                      'Pick Image',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Submit Button
                  _isUploading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Please select an image')),
                                );
                                return;
                              }

                              setState(() {
                                _isUploading = true;
                              });

                              final imageUrl = await _uploadImage(_image!);
                              if (imageUrl == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Image upload failed')),
                                );
                                setState(() {
                                  _isUploading = false;
                                });
                                return;
                              }
                              ProfileModel? user =
                                  await FirebaseFunctions.getUserProfile(
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .first;
                              if (user != null) {
                                AddLandModel addLandModel = AddLandModel(
                                    address: _nameController.text.trim(),
                                    description:
                                        _descriptionController.text.trim(),
                                    price: _priceController.text.trim(),
                                    investmentType: _selectedServiceType!,
                                    image: imageUrl,
                                    OwnerName:
                                        "${user?.firstName} ${user?.lastName}",
                                    OwnerPhone: "${user?.phoneNumber}",
                                    landSpace:
                                        "${_spaceController.text.trim()} ${_selectedLandSpeciesType}",
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    createdAt: Timestamp.now());

                                setState(() {
                                  _isUploading = false;
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LandLocation(landModel: addLandModel),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(
                                          "Please complete your profile before adding a land"),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          child: Text(
                            'Google Map & Confirm',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
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
          ),
        ),
      ),
    );
  }
}
