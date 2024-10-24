import 'package:flutter/material.dart';
import 'package:virtual_aquarium/models/fish.dart';

class FishWidget extends StatelessWidget {
  final Fish fish;

  const FishWidget({super.key, required this.fish});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fish.color,
        shape: BoxShape.circle, // Makes it a circular fish
      ),
      width: 20, // Example width for the fish
      height: 20, // Example height for the fish
      // You can add animations or other widgets here to enhance the fish movement
    );
  }
}
