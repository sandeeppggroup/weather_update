import '../../../../imports.dart';

class ViewReportsScreen extends StatefulWidget {
  const ViewReportsScreen({super.key});

  @override
  _ViewReportsScreenState createState() => _ViewReportsScreenState();
}

class _ViewReportsScreenState extends State<ViewReportsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserReportProvider>().fetchCurrentUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Consumer<UserReportProvider>(
        builder: (context, userReportProvider, child) {
          if (userReportProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userReportProvider.error != null) {
            return Center(child: Text('Error: ${userReportProvider.error}'));
          }

          final user = userReportProvider.currentUser;
          if (user == null) {
            return const Center(child: Text('No user logged in'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading:
                          const Icon(Icons.email, color: Colors.deepPurple),
                      title: const Text('Email'),
                      subtitle: Text(user.email ?? 'No email'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.fingerprint,
                          color: Colors.deepPurple),
                      title: const Text('UID'),
                      subtitle: Text(user.uid),
                    ),
                    ListTile(
                      leading: const Icon(Icons.access_time,
                          color: Colors.deepPurple),
                      title: const Text('Created'),
                      subtitle: Text(
                          user.metadata.creationTime?.toString() ?? 'Unknown'),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.login, color: Colors.deepPurple),
                      title: const Text('Last Sign In'),
                      subtitle: Text(user.metadata.lastSignInTime?.toString() ??
                          'Unknown'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
