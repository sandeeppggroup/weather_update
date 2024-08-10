import 'package:flutter/material.dart';
import 'package:newtok_technologies_mt/providers/location_provider.dart';
import 'package:newtok_technologies_mt/ui/user/upload_excel/upload_excel_screen.dart';
import 'package:newtok_technologies_mt/ui/user/user_dashboard/widgets/location_list_view_widget.dart';
import 'package:newtok_technologies_mt/widgets/show_logoutout_dialog_widget.dart';
import 'package:provider/provider.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationProvider>().fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: const Text(
          'User Dashboard',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => showLogoutDialog(context, false),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            color: Colors.white,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.blue.shade200],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildWelcomeCard(),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: LocationListView(),
              ),
            ),
            _buildUploadButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your locations and upload data',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadExcelScreen()),
          );
        },
        icon: const Icon(Icons.upload_file, size: 24),
        label: const Text('Upload Excel', style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
        ),
      ),
    );
  }
}
