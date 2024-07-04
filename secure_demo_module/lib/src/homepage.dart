// home_module/lib/src/home_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:home_module/enum/system_enum.dart';
import 'package:home_module/rsc/colors_manager.dart';
import 'package:main_app/global_state.dart';
import 'package:provider/provider.dart'; // Import the global state from the main app

class HomePage extends StatefulWidget {
  Widget? child = Container();

  HomePage({super.key, this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: SystemEnum.values.map((e) {
            return Column(
              children: [
                CircleAvatar(
                  backgroundColor: getColorFromHex('#39d2c0'),
                  radius: 50,
                  child: Image.network(
                    e.imageSystem,
                    height: 50,
                  ),
                ),
                Text(
                  e.systemName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: getColorFromHex('#003459'),
                      decoration: TextDecoration.none),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Text('Restart'),
                )
              ],
            );
          }).toList(),
        ),
        Row()
      ],
    );
  }
}
