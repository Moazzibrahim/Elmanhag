import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/Auth/login_provider.dart';
import '../models/bouns_model.dart';
import 'package:http/http.dart' as http;

class BonusService {
  final String apiUrl =
      "https://bdev.elmanhag.shop/affilate/bonus/view"; // Replace with your API URL

  Future<BonusResponse> fetchBonusData(BuildContext context) async {
    // Get the token from TokenModel
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final String? token = tokenProvider.token;

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return BonusResponse.fromJson(data);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error occurred: $e");
    }
  }
}
