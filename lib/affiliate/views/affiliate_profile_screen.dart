// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:flutter_application_1/affiliate/views/edit_profile.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/affiliate/models/affiliate_model.dart';
import 'package:flutter_application_1/localization/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart'; // For TokenModel

import '../../controller/Auth/login_provider.dart';
import '../../views/screens/login/login_screen.dart';
import '../controller/affiliate_provider.dart';

class AffiliateProfileScreen extends StatefulWidget {
  const AffiliateProfileScreen({super.key});

  @override
  _AffiliateProfileScreenState createState() => _AffiliateProfileScreenState();
}

class _AffiliateProfileScreenState extends State<AffiliateProfileScreen> {
  Future<void> _deleteAccount() async {
    final url = Uri.parse('https://bdev.elmanhag.shop/affilate/profile/delete');
    final token = Provider.of<TokenModel>(context, listen: false).token;

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)
                    .translate('account deleted successfully'))),
          );
          Future.delayed(
            const Duration(seconds: 1),
            () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)
                    .translate('Failed to delete account'))),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: redcolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الملف الشخصي',
            style: TextStyle(
              color: redcolor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: FutureBuilder<AffiliateData?>(
        future: ApiService().fetchUserProfile(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            final affiliateData = snapshot.data!;
            final user = affiliateData.user;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.imageLink),
                          radius: 30,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'اهلا بك ${user.name}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: redcolor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                user.role,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: redcolor),
                          onPressed: () {
                            // Navigate to the edit profile screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditAffiliateProfileScreen()), // Ensure you have this screen created
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileItem('الاسم: ${user.name}', true),
                  const SizedBox(height: 10),
                  _buildProfileItem('رقم الهاتف: ${user.phone}', true),
                  const SizedBox(height: 10),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: _buildProfileItemWithCopyIcon(
                        context,
                        ' كود التسويق: ${user.affilateCode ?? 'N/A'}',
                        user.affilateCode),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _deleteAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: redcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                    ),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileItem(String text, bool isBold) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItemWithCopyIcon(
      BuildContext context, String text, String? affiliateCode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (affiliateCode != null)
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.red),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: affiliateCode));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Affiliate code copied to clipboard!'),
                  ),
                );
              },
              tooltip: 'Copy Affiliate Code',
            ),
          const Spacer(),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
