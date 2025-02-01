import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hasadak/location/model/locationmodel.dart';

class AddLandModel {
  String address;
  String description;
  String price;
  String investmentType;
  LocationModel? locationModel;
  String? image;
  String OwnerName;
  String OwnerPhone;
  String landSpace;
  String userId;
  Timestamp createdAt;

  AddLandModel({
    required this.address,
    required this.description,
    required this.price,
    required this.investmentType,
    this.image,
    this.locationModel,
    required this.OwnerName,
    required this.OwnerPhone,
    required this.landSpace,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'description': description,
      'price': price,
      'investmentType': investmentType,
      'image': image,
      'locationModel': locationModel?.toMap(),
      'ownerName': OwnerName,
      'ownerPhone': OwnerPhone,
      'landSpace': landSpace,
      'userId': userId,
      'createdAt': createdAt
    };
  }

  static AddLandModel fromJson(Map<String, dynamic> json) {
    return AddLandModel(
      address: json['address'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      investmentType: json['investmentType'],
      locationModel: LocationModel.fromMap(json['locationModel']),
      OwnerName: json['ownerName'],
      OwnerPhone: json['ownerPhone'],
      landSpace: json['landSpace'],
      userId: json['userId'],
      createdAt: json['createdAt'],
    );
  }
}
