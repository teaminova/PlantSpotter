import 'package:flutter/material.dart';
import '../model/plant_entry.dart';

class PlantDetailsCard extends StatelessWidget {
  final PlantEntry entry;

  const PlantDetailsCard({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.date.toLocal().toString().split(' ')[0],
              style: const TextStyle(
                color: Color(0xFF6B8E58),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              entry.description,
              style: const TextStyle(
                color: Color(0xFF6B8E58),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                entry.user,
                style: const TextStyle(
                  color: Color(0xFF6B8E58),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
