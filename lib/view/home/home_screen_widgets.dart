import 'package:flutter/material.dart';
import 'package:slivers/constants.dart';

todotile(
    {required String title,
    required String description,
    required int pickedColor,
    required int index,
    required time}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colorconstants.colorsreal[pickedColor],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
        Text(
          overflow: TextOverflow.visible,
          description,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            time,
            style: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
