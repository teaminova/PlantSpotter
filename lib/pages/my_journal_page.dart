import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_spotter_lab2/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../widgets/plant_card.dart';

class MyJournalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allEntries = context.watch<JournalProvider>().entries;
    final entries = allEntries.where((e) => e.user == AuthService.getCurrentUser()).toList();

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
        title: const Text('My Journal', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () => context.push('/new_entry'),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // Set the border radius
                    ),
                  ),
                  child: const Text('+ New Entry'),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return PlantCard(
                  entry: entry,
                  onTap: () => context.push('/details', extra: entry),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
