import 'dart:async';
import 'package:flutter/material.dart';
import 'package:virtual_aquarium/models/fish.dart'; // Ensure Fish class is public
import 'package:virtual_aquarium/widgets/fish_widget.dart';
import 'package:virtual_aquarium/database/aquarium_db.dart'; // Ensure AquariumDatabase is public

class AquariumScreen extends StatefulWidget {
  const AquariumScreen({super.key});

  @override
  AquariumScreenState createState() => AquariumScreenState();
}

class AquariumScreenState extends State<AquariumScreen> with SingleTickerProviderStateMixin {
  List<Fish> fishList = [];
  int fishCount = 0;
  double speed = 2.0;
  Color selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await AquariumDatabase.getFishSettings();
    if (settings.isNotEmpty) {
      setState(() {
        fishCount = settings[0]['fishCount'] as int;
        speed = settings[0]['speed'] as double;
        selectedColor = Color(int.parse(settings[0]['color'] as String));
        for (int i = 0; i < fishCount; i++) {
          fishList.add(Fish(color: selectedColor, speed: speed));
        }
      });
    }
  }

  void _addFish() {
    if (fishList.length < 10) {
      setState(() {
        fishList.add(Fish(color: selectedColor, speed: speed));
        fishCount++;
      });
      AquariumDatabase.insertFishSettings(fishCount, speed, selectedColor.value.toString());
    }
  }

  void _saveSettings() {
    AquariumDatabase.insertFishSettings(fishCount, speed, selectedColor.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Aquarium'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: Stack(
        children: fishList.map((fish) => FishWidget(fish: fish)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFish,
        child: const Icon(Icons.add),
      ),
    );
  }
}
