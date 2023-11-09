import 'package:flutter/material.dart';

class LocationDescriptions extends StatelessWidget {
  final String title;
  final String description;
  final List<String> images;

  const LocationDescriptions({
    super.key, 
    required this.title, 
    required this.description, 
    required this.images, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(title, style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Sans Serif',
          ),
        ),
        centerTitle:  true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset('assets/images/default-image.png');
                  },
                );
              }
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(description),
            )
          ),
          SizedBox(
            width: 350.0,
            child: ElevatedButton(
              child: Text("Directions", style: TextStyle(color: Colors.white)),
              onPressed: () {
                                                                  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Button in Progress'),
            content: Text('This feature is still in development.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the alert dialog
                },
              ),
            ],
          );
        },
      );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF8B1C3F)
              )
              )
          )
        ],
      )
    );
  }
}
