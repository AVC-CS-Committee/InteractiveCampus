import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Emergency',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sans Serif',
            )),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'Call Emergency Services',
            'Call 911 or your local emergency number immediately if you are in a life-threatening or emergency situation.',
            '911', // add emergency number here
          ),
          _buildSection(
            context,
            'Emergency Contacts',
            'Add emergency contacts to your phone and keep them updated in case of an emergency.',
            '123-456-7890', // add emergency number here
          ),
          _buildSection(
            context,
            'Emergency Kit',
            'Prepare an emergency kit with essential items like food, water, first aid supplies, and important documents. Keep it in a safe and easily accessible place.',
            '999-999-9999', // add emergency number here
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String description,
      String emergencyNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _callEmergencyNumber(context, emergencyNumber),
            child: Text(
              'Call $emergencyNumber',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _callEmergencyNumber(BuildContext context, String number) {
    // Call the emergency number here
    // You can use the url_launcher package to launch the phone app with the number
  }
}
