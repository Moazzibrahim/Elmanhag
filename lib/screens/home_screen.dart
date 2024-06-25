import 'package:flutter/material.dart';

import 'package:flutter_application_1/widgets/app_bar.dart';
import 'package:flutter_application_1/widgets/home_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: HomeGrid(),
      ),
    );
  }
}