import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String info;

  const InfoCard({required this.info, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF6B8E58)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                info,
                style: TextStyle(
                  color: Color(0xFF6B8E58),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
