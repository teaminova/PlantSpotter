import 'package:flutter/material.dart';
import '../model/plant_entry.dart';

class PlantCard extends StatelessWidget {
  final PlantEntry entry;
  final VoidCallback onTap;

  const PlantCard({required this.entry, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  entry.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.name,
                      style: const TextStyle(
                        color: Color(0xFF6B8E58),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.date.toLocal().toString().split(' ')[0],
                      style: const TextStyle(
                        color: Color(0xFF6B8E58),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 75,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    entry.user,
                    style: const TextStyle(
                      color: Color(0xFF6B8E58),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10)
            ],
          ),
        ),
      ),
    );
  }
}
