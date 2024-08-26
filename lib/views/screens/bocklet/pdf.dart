import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewScreen extends StatefulWidget {
  final String filePath;

  const PDFViewScreen({super.key, required this.filePath});

  @override
  // ignore: library_private_types_in_public_api
  _PDFViewScreenState createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  int totalPages = 0;
  int currentPage = 0;
  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'View PDF',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.filePath,
            onRender: (pages) {
              setState(() {
                totalPages = pages ?? 0;
                isReady = true;
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              // Initialize controller if needed
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page ?? 0;
              });
            },
          ),
          if (!isReady) const Center(child: CircularProgressIndicator()),
          if (isReady)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Page ${currentPage + 1} of $totalPages',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
