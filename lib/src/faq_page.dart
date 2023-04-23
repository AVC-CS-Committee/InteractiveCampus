import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<dynamic> faqs = [];

  @override
  void initState() {
    super.initState();
    _loadFAQs();
  }

  Future<void> _loadFAQs() async {
    String jsonString =
        await rootBundle.loadString('assets/json/faq_questions.json');
    setState(() {
      faqs = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('FAQs',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sans Serif',
            )),
        centerTitle: true,
        elevation: 2,
      ),
      body: faqs.isEmpty
          ? Container() // removed CircularProgressIndicator and added an empty container
          : ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(9.0, 5.0, 9.0, 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff8d1c40),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        faqs[index]['question'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sans Serif',
                        ),
                      ),
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                          child: Text(
                            faqs[index]['answer'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sans Serif',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
