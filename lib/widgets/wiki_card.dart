import 'package:flutter/material.dart';
import '../model/plant_entry.dart';

class WikiCard extends StatelessWidget {
  final String info;

  const WikiCard({required this.info, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'From Wikipedia',
              style: const TextStyle(
                color: Color(0xFF6B8E58),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                info,
                style: const TextStyle(
                  color: Color(0xFF6B8E58),
                  fontSize: 14,
                ),
              ),
            ),
            if (info.isEmpty)
              Align(
                alignment: Alignment.center,
                child: Text(
                  'No information available.',
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
