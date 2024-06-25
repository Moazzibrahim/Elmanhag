import 'package:flutter/material.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key, required this.text, required this.image});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        ),
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              const SizedBox(height: 5,),
              Image.asset(image),
            ],
          ),
        );
      },
    );
  }
}