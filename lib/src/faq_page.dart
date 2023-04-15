import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('Frequently Asked Questions',
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
          children: const [
            ExpansionTile(
              title: Text('Question 1'),
              children: [
                ListTile(
                  title: Text('Answer 1'),
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              title: Text('Question 2'),
              children: [
                ListTile(
                  title: Text('Answer 2'),
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              title: Text('Question 3'),
              children: [
                ListTile(
                  title: Text('Answer 3'),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
