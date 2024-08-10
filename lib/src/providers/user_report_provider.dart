import '../../imports.dart';

class UserReportProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCurrentUserDetails() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = _auth.currentUser;
      if (_currentUser == null) {
        _error = 'No user is currently logged in.';
      }
    } catch (e) {
      _error = e.toString();
      // print('Error fetching current user: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
