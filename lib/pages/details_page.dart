import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/plant_entry.dart';

class DetailsPage extends StatelessWidget {
  final PlantEntry entry;

  const DetailsPage({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.pop();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF6B8E58),
          ),
        ),
        title: const Text('Details', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                entry.image,
                width: 350,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(entry.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6B8E58))),
            const SizedBox(height: 8),
            Card(
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
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () => context.push('/see_location', extra: entry.location),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('See Location'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () => context.push('/learn_more', extra: entry.name),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text('Learn More'),
              ),
            ),
            // TextButton(
            //   onPressed: () => context.push('/see_location', extra: entry.location),
            //   child: const Text('See Location'),
            // ),
            // const SizedBox(height: 8),
            // TextButton(
            //   onPressed: () => context.push('/learn_more', extra: entry.name),
            //   child: const Text('Learn More'),
            // ),
          ],
        ),
      ),
    );
  }
}
