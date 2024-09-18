import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:flutter_application_1/models/parent%20models/choose_son_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GetChildrenProvider with ChangeNotifier {
  ChildrenResponse? _childrenResponse;
  bool _isLoading = false;
  String? _errorMessage;

  ChildrenResponse? get childrenResponse => _childrenResponse;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchChildren(BuildContext context) async {
    const url = 'https://bdev.elmanhag.shop/parent/childreen';
    final tokenProvider = Provider.of<TokenModel>(context, listen: false);
    final token = tokenProvider.token;

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        _childrenResponse = ChildrenResponse.fromJson(jsonResponse);
        log('Children data loaded successfully');
      } else {
        _errorMessage = 'Failed to load children data';
        log('${response.statusCode}');
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
