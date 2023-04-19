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
        title: const Text('Emergency Contacts',
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
            'AVC Sheriff\'s Office',
            'Monday through Friday: 7:30 am to Midnight After midnight, the office is closed but officers are on patrol throughout the campus. You can contact them after midnight and up until 7:30 am the following morning from any payphone at *80 or from your cell phone at 661.722.6399.\n\nSaturday and Sunday The office is closed on Saturday and Sunday but officers are on patrol throughout the campus. You can contact them from any payphone at *80, or from your cell phone at 661.722.6399.\n\nLocation The Antelope Valley College safety and security department is located in the Student Services Center on the south side of the building in room T800.',
            '911', // add emergency number here
          ),
          _buildSection(
            context,
            'Campus Safety Escort Program',
            'Add emergency contacts to your phone and keep them updated in case of an emergency.',
            '123-456-7890', // add emergency number here
          ),
          _buildSection(
            context,
            'Criminal Prevention and',
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
              color: Color(0xff8d1c40),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
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
