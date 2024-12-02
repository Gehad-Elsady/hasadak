import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/Screens/Profile/model/profilemodel.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
// import 'package:hasadak/theme/app-colors.dart';
import 'package:hasadak/validation/validation.dart';
import 'package:hasadak/widget/Drawer/mydrawer.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  static const String routeName = "user-profile";
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  String? _downloadURL;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final picker = ImagePicker();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contactNumber = TextEditingController();

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    address.dispose();
    contactNumber.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      try {
        String fileName = _imageFile!.path.split('/').last;
        Reference storageRef = _storage.ref().child('profile/$fileName');
        await storageRef.putFile(_imageFile!);

        String downloadURL = await storageRef.getDownloadURL();
        setState(() {
          _downloadURL = downloadURL;
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: const Color(0xFF6EDE8A),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6EDE8A),
              Color(0xFF4AD66D),
              Color(0xFF155D27),
            ],
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFunctions.getUserProfile(
              FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            // If the snapshot doesn't have data, show empty fields
            if (!snapshot.hasData || snapshot.data == null) {
              return _buildForm();
            }

            // If we have data, show the form with prefilled data
            ProfileModel userProfile = snapshot.data!;
            firstName.text = userProfile.firstName ?? "";
            lastName.text = userProfile.lastName ?? "";
            email.text = userProfile.email ?? "";
            address.text = userProfile.address ?? "";
            contactNumber.text = userProfile.phoneNumber ?? "";
            _downloadURL = userProfile.profileImage ?? "";

            return _buildForm();
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!) as ImageProvider
                      : _downloadURL != null && _downloadURL!.isNotEmpty
                          ? CachedNetworkImageProvider(_downloadURL!)
                          : const NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/005/720/408/small_2x/crossed-image-icon-picture-not-available-delete-picture-symbol-free-vector.jpg',
                            ),
                  child: _downloadURL == null && _imageFile == null
                      ? Center(child: CircularProgressIndicator())
                      : null, // Optionally show a loading indicator if no image is present
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: firstName,
                    decoration: InputDecoration(
                        labelText: 'first-name',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    validator: (value) =>
                        value!.isEmpty ? 'first-name-error' : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: lastName,
                    decoration: InputDecoration(
                        labelText: 'last-name',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    validator: (value) =>
                        value!.isEmpty ? 'last-name-error' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: email,
              decoration: InputDecoration(
                  labelText: 'email',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              validator: Validation.validateEmail(email.text),
            ),
            const SizedBox(height: 30),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: address,
              decoration: InputDecoration(
                  labelText: 'address',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              validator: (value) => value!.isEmpty ? 'address-error' : null,
            ),
            const SizedBox(height: 30),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: contactNumber,
              decoration: InputDecoration(
                  labelText: 'phone-number',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              validator: (value) =>
                  value!.isEmpty ? 'phone-number-error' : null,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _uploadImage(); // Upload the image before saving
                    if (_formKey.currentState!.validate()) {
                      ProfileModel data = ProfileModel(
                        firstName: firstName.text,
                        lastName: lastName.text,
                        address: address.text,
                        phoneNumber: contactNumber.text,

                        email: email.text,
                        profileImage: _downloadURL ??
                            "", // Use existing URL if no image selected
                        id: FirebaseAuth.instance.currentUser!.uid,
                      );
                      FirebaseFunctions.addUserProfile(data);
                      firstName.clear();
                      lastName.clear();
                      address.clear();
                      contactNumber.clear();

                      email.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('profile-saved')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Colors.green,
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  child: Text('save',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
