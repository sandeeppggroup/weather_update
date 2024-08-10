import '/imports.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        height: 900,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 182, 153, 233),
              Color.fromARGB(255, 222, 208, 248)
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Consumer<LocationProvider>(
                builder: (context, locationProvider, child) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeaderCard(),
                            const SizedBox(height: 20),
                            _buildInputField(
                              icon: Icons.public,
                              hintText: "Enter Country",
                              labelText: "Country",
                              controller: locationProvider.country,
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              icon: Icons.location_city,
                              hintText: "Enter State",
                              labelText: "State",
                              controller: locationProvider.state,
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              icon: Icons.landscape,
                              hintText: "Enter District",
                              labelText: "District",
                              controller: locationProvider.district,
                            ),
                            const SizedBox(height: 20),
                            _buildInputField(
                              icon: Icons.location_on,
                              hintText: "Enter City",
                              labelText: "City",
                              controller: locationProvider.city,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: locationProvider.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        await context
                                            .read<LocationProvider>()
                                            .addLocation(context);
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shadowColor: Colors.deepPurple,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: locationProvider.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.deepPurple),
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Add Location',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      if (locationProvider.isLoading)
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.deepPurple),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Location',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please fill in the details below',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String hintText,
    required String labelText,
    required TextEditingController controller,
  }) {
    return TextFormFieldWidget(
      hintText: hintText,
      labelText: labelText,
      controller: controller,
      icon: icon,
    );
  }
}
