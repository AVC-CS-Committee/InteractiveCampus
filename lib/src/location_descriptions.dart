import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  final String title;
  final String description;
  final List<String> images;

  const SecondRoute({
    super.key, 
    required this.title, 
    required this.description, 
    required this.images, 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
          )
        ],
      )
    );
  }
}
