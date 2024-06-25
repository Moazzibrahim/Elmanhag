import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class SignScreen extends StatelessWidget {
  const SignScreen({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'انشاء حساب',
          style: TextStyle(fontWeight: FontWeight.bold, color: redcolor),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أهلا بك معنا',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: 'الاسم',
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'الإيميل',
                border: UnderlineInputBorder(),
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'الرقم السري',
                border: UnderlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('إنشاء حساب'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'أو',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.red, size: 30),
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.camera_alt,
                      color: Colors.red, size: 30), // Assuming Instagram icon
                  onPressed: () {},
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.clear,
                      color: Colors.red, size: 30), // Assuming X icon
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'لديك حساب؟ تسجيل الدخول',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
