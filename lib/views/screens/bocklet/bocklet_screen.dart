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
            _buildDownloadButton('Pdf 1', context),
            _buildDownloadButton('Pdf 2', context),
            _buildDownloadButton('Pdf 3', context),
            _buildDownloadButton('Pdf 4', context),
          ],
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
