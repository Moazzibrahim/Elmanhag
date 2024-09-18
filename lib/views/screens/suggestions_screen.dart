import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert'; // For JSON encoding/decoding
import '../../constants/colors.dart';
import '../../controller/Auth/login_provider.dart';

class ComplaintsSuggestionsScreen extends StatefulWidget {
  const ComplaintsSuggestionsScreen({super.key});

  @override
  _ComplaintsSuggestionsScreenState createState() =>
      _ComplaintsSuggestionsScreenState();
}

class _ComplaintsSuggestionsScreenState
    extends State<ComplaintsSuggestionsScreen> {
  final TextEditingController _complaintController = TextEditingController();
  bool _isLoading = false;
  Future<void> submitComplaint() async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    final String complaint = _complaintController.text.trim();

    if (complaint.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء كتابة اقتراحك أو شكواك')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://bdev.elmanhag.shop/student/complaint/store'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'complaint': complaint,
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('تم الإرسال'),
              content: const Text('تم إرسال طلبكuoi بنجاح. شكرًا لملاحظاتك.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('موافق'),
                ),
              ],
            );
          },
        );
        _complaintController.clear(); // Clear the text field
      } else {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('حدث خطأ. حاول مرة أخرى')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل في الاتصال بالخادم')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الاقتراحات والشكاوى',
          style: TextStyle(
            color: redcolor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: redcolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'نحن نقدر ملاحظاتك واسمحوا لنا أن نعرف شكواك أو اقتراحات',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _complaintController,
              decoration: InputDecoration(
                hintText: 'اكتب اقتراحك او شكوكك هنا',
                hintStyle: TextStyle(color: Colors.grey[400]),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: redcolor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : submitComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: redcolor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'ارسال',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
