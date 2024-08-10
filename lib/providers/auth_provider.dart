import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newtok_technologies_mt/models/user_model.dart';
import 'package:newtok_technologies_mt/services/auth_service.dart';
import 'package:newtok_technologies_mt/ui/admin/admin_dashboard/admin_dashboard_screen.dart';
import 'package:newtok_technologies_mt/ui/user/user_dashboard/user_dashboard_screen.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    _currentUser = await _authService.signIn(email, password);

    if (_currentUser != null) {
      log(currentUser!.isAdmin.toString());
    }

    if (_currentUser == null) {
      Fluttertoast.showToast(
          msg: 'Something went wrong', toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (_currentUser!.isAdmin) {
      Fluttertoast.showToast(
          msg: "You have successfully logged in as admin",
          toastLength: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDashboardScreen(),
        ),
        (route) => false, // Remove previous routes
      );
    } else {
      Fluttertoast.showToast(
          msg: "You have successfully logged in as user",
          toastLength: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const UserDashboardScreen(),
        ),
        (route) => false, // Remove previous routes
      );
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }

  bool get isAdmin => _currentUser?.isAdmin ?? false;
}
