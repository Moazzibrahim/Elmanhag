import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/home_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeGrid(text: 'واجبات', image: 'assets/images/Frame.png'),
    );
  }
}