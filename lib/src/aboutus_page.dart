import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  List<dynamic> _contributors = [];

  @override
  void initState() {
    super.initState();
    _loadContributors();
  }

  Future<void> _loadContributors() async {
    String jsonString = await rootBundle.loadString('assets/json/contributors.json');

    setState(() {
      _contributors = json.decode(jsonString);
    });
  }

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
                color: Color(0xff8a1c40),
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
                color: Color(0xff8a1c40),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
            child : SingleChildScrollView(
                child: Column(
                  children: [
                    for (var contributor in _contributors)
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            contributor['picture'],
                          ),
                        ),
                        title: GestureDetector(
                          child: Text(
                            contributor['name'],
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onTap: () => launchUrlString(contributor['url'])
                        ),
                        subtitle: Text(contributor['title']),
                      )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
