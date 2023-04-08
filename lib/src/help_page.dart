import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text('AVC Interactive Map', style: TextStyle(
          color: Colors.white,
          fontFamily: 'Sans Serif',
        )
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: ListView (
          padding: EdgeInsets.zero,

          children: [
            ListTile(
              title: const Text('FAQ'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
            ListTile(
              title: const Text('Emergency Contact'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
            ListTile(
              title: const Text('About Us'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}