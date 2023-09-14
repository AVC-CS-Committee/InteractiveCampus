import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interactivemap/src/aboutus_page.dart';
import 'package:interactivemap/src/emergency_page.dart';
import 'package:interactivemap/src/faq_page.dart';

class ClassPage extends StatelessWidget {
   const ClassPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('AVC Interactive Map',
            style: TextStyle(
              //color: Colors.white,
              fontFamily: 'Sans Serif',
            )),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Text('Please Enter your Classes here!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),

            ),
            const Divider(),
            Text('Class 1: ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Info',
              ),
            ),

            const Divider(),
            Text('Class 2: ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Info',
              ),
            ),
            const Divider(),
            Text('Class 3: ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Info',
              ),
            ),
            const Divider(),
            Text('Class 4: ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Info',
              ),
            ),
            const Divider(),
            Text('Class 5: ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff8a1c40)
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Class Info',
              ),
            ),
          ],
        ),
      ),
    );
  }
}