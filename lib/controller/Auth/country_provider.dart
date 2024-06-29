import 'dart:convert';
import 'package:flutter_application_1/model/login/sign_up_model.dart';
import 'package:http/http.dart' as http;

Future<DataModel> fetchData() async {
  final response =
      await http.get(Uri.parse('https://my.elmanhag.shop/api/sign_up'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final jsonData = json.decode(response.body);
    // ignore: avoid_print
    print(response.body);
    return DataModel.fromJson(jsonData);
  } else {
    // If the server returns an error, throw an exception
    throw Exception('Failed to load data');
  }
}
