import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class BockletScreen extends StatelessWidget {
  final List<dynamic> resources;

  const BockletScreen({super.key, required this.resources});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: resources.map((resource) {
            if (resource['type'] == 'pdf') {
              return _buildDownloadButton(resource['file'], context);
            }
            return Container(); // or other widget if needed
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDownloadButton(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("pdf downloaded")),
                );
              },
              backgroundColor: redcolor,
              icon: const Icon(
                Icons.download,
                size: 24,
                color: Colors.white,
              ),
              label: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
