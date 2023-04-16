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
        title: const Text('FAQs'),
      ),
      body: faqs.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text(
                    faqs[index]['question'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      child: Text(
                        faqs[index]['answer'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
