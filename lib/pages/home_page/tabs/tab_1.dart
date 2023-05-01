import 'package:flutter/material.dart';

class Tab1 extends StatelessWidget {
  const Tab1({super.key});

  final int _itemsAmount = 160;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            _itemsAmount,
            (index) => Text(
              index.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
