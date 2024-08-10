import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newtok_technologies_mt/models/location_model.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _locationsCollectionName = 'locations';

  Future<bool> addLocation(
      {required String country,
      required String state,
      required String district,
      required String city}) async {
    try {
      await _firestore.collection(_locationsCollectionName).add({
        'country': country,
        'state': state,
        'district': district,
        'city': city,
      });

      return true;
    } catch (e) {
      log('Failed to add location: $e');

      // Show an error message to the user
      Fluttertoast.showToast(
        msg: "Failed to add location. Please try again.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      // Optionally handle specific error types
      if (e is FirebaseException) {
        log('Firebase error: ${e.message}');
      } else {
        // Handle other types of errors
        log('General error: $e');
      }
      // Optionally rethrow the error if needed
      return false;
    }
  }

  Future<List<LocationModel>> getLocations() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(_locationsCollectionName).get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return LocationModel(
          country: data['country'],
          state: data['state'],
          district: data['district'],
          city: data['city'],
        );
      }).toList();
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}
