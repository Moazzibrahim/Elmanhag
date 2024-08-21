import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class BockletScreen extends StatelessWidget {
  const BockletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildDownloadButton('Pdf 1'),
            _buildDownloadButton('Pdf 2'),
            _buildDownloadButton('Pdf 3'),
            _buildDownloadButton('Pdf 4'),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          const Icon(Icons.download, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Add download logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: redcolor,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
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
