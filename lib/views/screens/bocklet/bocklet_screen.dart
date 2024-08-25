import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
              return _buildDownloadButton(resource['file_link'], context);
            }
            return Container(); // or other widget if needed
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDownloadButton(String url, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: FloatingActionButton.extended(
              onPressed: () async {
                try {
                  // Get the download directory
                  Directory? downloadsDirectory =
                      await getExternalStorageDirectory();
                  String newPath = "";
                  List<String> paths = downloadsDirectory!.path.split("/");
                  for (int x = 1; x < paths.length; x++) {
                    String folder = paths[x];
                    if (folder != "Android") {
                      newPath += "/" + folder;
                    } else {
                      break;
                    }
                  }
                  newPath = newPath + "/Download";
                  downloadsDirectory = Directory(newPath);

                  if (!downloadsDirectory.existsSync()) {
                    downloadsDirectory.createSync();
                  }

                  String fileName = url.split('/').last;
                  String savePath = "${downloadsDirectory.path}/$fileName";

                  // Download the file
                  Dio dio = Dio();
                  await dio.download(url, savePath);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("PDF downloaded to $savePath")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to download PDF: $e")),
                  );
                }
              },
              backgroundColor: redcolor,
              icon: const Icon(
                Icons.download,
                size: 24,
                color: Colors.white,
              ),
              label: const Text(
                "Download PDF",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
