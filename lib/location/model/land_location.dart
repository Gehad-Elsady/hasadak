import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hasadak/Backend/firebase_functions.dart';
import 'package:hasadak/Screens/Add%20land/model/add_land_model.dart';
import 'package:hasadak/Screens/Home/home-screen.dart';
import 'package:hasadak/Screens/Profile/model/profilemodel.dart';
import 'package:hasadak/location/model/locationmodel.dart';
import 'package:location/location.dart';

class LandLocation extends StatefulWidget {
  AddLandModel landModel;

  LandLocation({required this.landModel});

  @override
  State<LandLocation> createState() => _GpsState();
}

class _GpsState extends State<LandLocation> {
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  Location location = Location();
  LocationData? locationData;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.033333, 31.233334), // Default to Cairo, Egypt
    zoom: 18.0,
  );

  bool _serviceEnabled = false;
  Marker? _selectedMarker;

  @override
  void initState() {
    super.initState();
    canAccessLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Land Location"),
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.hybrid,
        zoomControlsEnabled: false,
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            northeast:
                LatLng(31.916667, 35.000000), // Top right corner of Egypt
            southwest:
                LatLng(22.000000, 25.000000), // Bottom left corner of Egypt
          ),
        ),
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _selectedMarker != null ? {_selectedMarker!} : {},
        onTap: (LatLng tappedPoint) {
          setState(() {
            _selectedMarker = Marker(
              markerId: MarkerId("selected_location"),
              position: tappedPoint,
            );
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _confirmLocation,
        label: Text('Confirm Location'),
        icon: const Icon(Icons.check),
      ),
    );
  }

  Future<void> canAccessLocation() async {
    bool permissionGranted = await isPermissionGranted();
    if (!permissionGranted) return;

    bool serviceEnabled = await isServicesEnabled();
    if (!serviceEnabled) return;

    locationData = await location.getLocation();
    if (locationData != null) {
      _initialPosition = CameraPosition(
        target: LatLng(locationData!.latitude!, locationData!.longitude!),
        zoom: 14.4746,
      );
      setState(() {});
      final GoogleMapController controller = await _controller.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
    }
  }

  Future<void> _confirmLocation() async {
    if (_selectedMarker == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please select a location by tapping on the map.")),
      );
      return;
    }

    LatLng selectedPosition = _selectedMarker!.position;
    AddLandModel data = AddLandModel(
        address: widget.landModel.address,
        description: widget.landModel.description,
        price: widget.landModel.price,
        investmentType: widget.landModel.investmentType,
        image: widget.landModel.image,
        locationModel: LocationModel(
          latitude: selectedPosition.latitude,
          longitude: selectedPosition.longitude,
        ),
        OwnerName: widget.landModel.OwnerName,
        OwnerPhone: widget.landModel.OwnerPhone,
        landSpace: widget.landModel.landSpace,
        userId: widget.landModel.userId,
        createdAt: widget.landModel.createdAt);
    await FirebaseFunctions.addLand(data);
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  Future<bool> isPermissionGranted() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    return _permissionGranted == PermissionStatus.granted;
  }

  Future<bool> isServicesEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    return _serviceEnabled;
  }
}
