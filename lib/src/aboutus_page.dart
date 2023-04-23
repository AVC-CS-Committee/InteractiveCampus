import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Sans Serif',
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to the AVC Interactive Map! We are a team of passionate developers and designers dedicated to creating an interactive and informative experience for students, staff, and visitors of Antelope Valley College. Our goal is to make it easy for you to navigate the campus, find your classrooms, and discover all the amazing resources available to you. We are committed to continuously improving the AVC Interactive Map and welcome your feedback and suggestions. Thank you for using the AVC Interactive Map!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),
            const Text(
              'Contributors',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://example.com/images/user2.jpg',
                ),
              ),
              title: GestureDetector(
                child: const Text(
                  'Peter Kallos',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => launchUrlString('https://www.avc.edu'),
              ),
              subtitle: const Text('pkallos19@avc.edu'),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://example.com/images/user2.jpg',
                ),
              ),
              title: GestureDetector(
                child: const Text(
                  'Jane Smith',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () => launchUrlString('https://www.example.com/jane'),
              ),
              subtitle: const Text('Graphic Designer'),
            ),
          ],
        ),
      ),
    );
  }
}
