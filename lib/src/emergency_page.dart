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
        title: const Text(
          'Emergency Contacts',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sans Serif',
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            'AVC Sheriff\'s Office',
            'Monday through Friday: 7:30 am to Midnight After midnight, the office is closed but officers are on patrol throughout the campus. You can contact them after midnight and up until 7:30 am the following morning from any payphone at *80 or from your cell phone at 661.722.6399.\n\nSaturday and Sunday The office is closed on Saturday and Sunday but officers are on patrol throughout the campus. You can contact them from any payphone at *80, or from your cell phone at 661.722.6399.\n\nLocation The Antelope Valley College safety and security department is located in the Student Services Center on the south side of the building in room T800.',
            '661-722-6399', // add emergency number here
            Icons.local_police, // add icon here
          ),
          _buildSection(
            context,
            'Campus Safety Escort',
            'The Antelope Valley College safety and security department has enacted a campus escort program on a 24-hour basis. If the event a student, employee or visitor wishes an escort to their car, office, classroom or any other location on campus, simply dial 6399 and request the escort. From any payphone, dialing *80. From any cell phone, dial 661.722.6399.\n\nAn officer will be dispatched to the requesting parties location and escort the requesting party to their destination. If the request is to your vehicle, our officer will stand by until you safely exit the parking lot.\n\nIn the event you are calling from home and wish an escort from your vehicle to a location on campus, simply contact us at 661.722.6399 and advise us of the following: \n   1. Location you will be arriving in \n   2. Type of vehicle \n   3. Location in which you wish to be escorted to \nThat\'s all it takes. An officer will meet you at the location requested and escort you to your destination.',
            '661-722-6399', // add emergency number here
            Icons.local_police, // add icon here
          ),
          _buildSection(
            context,
            'Criminal Prevention',
            'The Antelope Valley College safety and security department is a pro-active department. Our officers are constantly on alert to guard against criminal activity. High visibility and 24 hour patrols ensure all who come onto our campus a great learning environment.',
            '661-722-6399', // add emergency number here
            Icons.local_police, // add icon here
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String description,
    String emergencyNumber,
    IconData iconData,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(color: const Color(0xff8d1c40), iconData),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8d1c40),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _callEmergencyNumber(context, emergencyNumber),
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Color(0xff8d1c40),
              )),
              child: Text(
                'Call $emergencyNumber',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _callEmergencyNumber(BuildContext context, String number) {
    // Call the emergency number here
    // You can use the url_launcher package to launch the phone app with the number
  }
}
