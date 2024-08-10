import 'dart:developer';
import '../../imports.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

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
      preferences.setBool('admin', true);
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
      preferences.setBool('user', true);
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
