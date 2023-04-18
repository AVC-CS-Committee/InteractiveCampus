import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interactivemap/src/aboutus_page.dart';
import 'package:interactivemap/src/emergency_page.dart';
import 'package:interactivemap/src/faq_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('AVC Interactive Map',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sans Serif',
            )),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('FAQ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Emergency Contact'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergencyPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
