import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? email;
  final String? password; // Add the password field
  final bool isAdmin;

  UserModel({
    required this.uid,
    this.email,
    this.password, // Initialize the password field
    required this.isAdmin,
  });

  // Factory constructor to create a UserModel from a Firestore document
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      email: data['email'] as String?,
      password:
          data['password'] as String?, // Add this line to extract password
      isAdmin: data['isAdmin'] as bool? ?? false,
    );
  }
}
