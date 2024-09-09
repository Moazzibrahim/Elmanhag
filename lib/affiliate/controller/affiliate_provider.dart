// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/affiliate/models/affiliate_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';

class ApiService {
  final String apiUrl = 'https://bdev.elmanhag.shop/affilate/profile/view';

  Future<AffiliateData?> fetchUserProfile(BuildContext context) async {
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;
    try {
      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == "data Returned Successfully" &&
            data['user'] != null) {
          return AffiliateData.fromJson(data);
        } else {
          print('API returned an error: ${data['error'] ?? 'Unknown error'}');
          return null;
        }
      } else {
        print(
            'Failed to load profile data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('An exception occurred: $e');
      return null;
    }
  }
}
