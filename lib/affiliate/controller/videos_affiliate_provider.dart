import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/Auth/login_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/videos_affiliate_model.dart'; // for accessing the TokenModel

Future<List<AffiliateGroupVideo>> fetchAffiliateGroupVideos(
    BuildContext context) async {
  const String url = 'https://bdev.elmanhag.shop/affilate/setting/video';

  final tokenProvider = Provider.of<TokenModel>(context, listen: false);
  final String? token = tokenProvider.token;

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);

    List<AffiliateGroupVideo> affiliateGroupVideos =
        (data['affiliate_group_video'] as List)
            .map((group) => AffiliateGroupVideo.fromJson(group))
            .toList();
    return affiliateGroupVideos;
  } else {
    log(response.statusCode.toString());
    print(response.body);
    throw Exception('Failed to load affiliate group videos');
  }
}
