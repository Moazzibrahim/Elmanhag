import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/bocklet/hh';
import 'package:path_provider/path_provider.dart';

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
              return _buildDownloadAndViewContainer(
                  resource['type'], resource['file_link'], context);
            }
            return Container(); // or other widget if needed
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDownloadAndViewContainer(
      String pdfName, String url, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pdfName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        Directory? downloadsDirectory =
                            await getExternalStorageDirectory();
                        String newPath = "";
                        List<String> paths =
                            downloadsDirectory!.path.split("/");
                        for (int x = 1; x < paths.length; x++) {
                          String folder = paths[x];
                          if (folder != "Android") {
                            newPath += "/$folder";
                          } else {
                            break;
                          }
                        }
                        newPath = "$newPath/Download";
                        downloadsDirectory = Directory(newPath);
                        if (!downloadsDirectory.existsSync()) {
                          downloadsDirectory.createSync();
                        }
                        String fileName = url.split('/').last;
                        String savePath =
                            "${downloadsDirectory.path}/$fileName";

                        Dio dio = Dio();
                        await dio.download(url, savePath);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("PDF downloaded")),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to download PDF: $e")),
                        );
                      }
                    },
                    icon: Icon(Icons.download, color: Colors.white),
                    label: const Text(
                      "Download",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8), // Space between buttons
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        Directory? downloadsDirectory =
                            await getExternalStorageDirectory();
                        String newPath = "";
                        List<String> paths =
                            downloadsDirectory!.path.split("/");
                        for (int x = 1; x < paths.length; x++) {
                          String folder = paths[x];
                          if (folder != "Android") {
                            newPath += "/$folder";
                          } else {
                            break;
                          }
                        }
                        newPath = "$newPath/Download";
                        downloadsDirectory = Directory(newPath);
                        if (!downloadsDirectory.existsSync()) {
                          downloadsDirectory.createSync();
                        }
                        String fileName = url.split('/').last;
                        String savePath =
                            "${downloadsDirectory.path}/$fileName";

                        File pdfFile = File(savePath);
                        if (!pdfFile.existsSync()) {
                          Dio dio = Dio();
                          await dio.download(url, savePath);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PDFViewScreen(filePath: savePath),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Failed to view PDF: $e")),
                        );
                      }
                    },
                    icon: Icon(Icons.visibility, color: Colors.white),
                    label: const Text(
                      "View",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
