import '../../../../../imports.dart';

class LocationListView extends StatelessWidget {
  const LocationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    return locationProvider.locations.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            itemCount: locationProvider.locations.length,
            itemBuilder: (context, index) {
              final location = locationProvider.locations[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Icon(Icons.location_on, color: Colors.blue.shade700),
                  ),
                  title: Text(
                    location.city,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    '${location.state}, ${location.country}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: Colors.blue.shade300),
                  onTap: () => _showLocationDetails(context, location),
                ),
              );
            },
          );
  }

  void _showLocationDetails(BuildContext context, LocationModel location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: ContentBox(location: location),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off, size: 80, color: Colors.blue.shade200),
          const SizedBox(height: 16),
          Text(
            'No locations found',
            style: TextStyle(fontSize: 20, color: Colors.blue.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            'Try uploading an Excel file with location data',
            style: TextStyle(fontSize: 16, color: Colors.blue.shade300),
          ),
        ],
      ),
    );
  }
}
