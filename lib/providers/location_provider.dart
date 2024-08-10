import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newtok_technologies_mt/models/location_model.dart';
import 'package:newtok_technologies_mt/services/location_service.dart';
import 'package:newtok_technologies_mt/ui/admin/admin_dashboard/admin_dashboard_screen.dart';

class LocationProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final LocationService _locationService = LocationService();
  List<LocationModel> _locations = [];
  List<LocationModel> get locations => _locations;

  final TextEditingController _country = TextEditingController();
  TextEditingController get country => _country;
  final TextEditingController _state = TextEditingController();
  TextEditingController get state => _state;
  final TextEditingController _district = TextEditingController();
  TextEditingController get district => _district;
  final TextEditingController _city = TextEditingController();
  TextEditingController get city => _city;

  Future<void> addLocation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final success = await _locationService.addLocation(
      country: _country.text,
      state: _state.text,
      district: _district.text,
      city: _city.text,
    );

    if (success) {
      Fluttertoast.showToast(msg: "Location Data Added Successfully");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDashboardScreen(),
        ),
        (route) => false,
      );
    } else {
      return;
    }

    _locations.add(LocationModel(
        country: _country.text,
        state: _state.text,
        district: _district.text,
        city: _city.text));
    notifyListeners();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLocations() async {
    _locations = await _locationService.getLocations();
    notifyListeners();
  }
}
