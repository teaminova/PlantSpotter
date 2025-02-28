import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../services/auth_service.dart';
import '../widgets/plant_card.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final allEntries = context.watch<JournalProvider>().entries;
    // final entries = allEntries.where((e) => e.user != AuthService.getCurrentUser() && e.isPublic).toList();
    final entries = context.watch<JournalProvider>().getCommunityEntries();

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
        title: const Text('Community', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: entries.length, // Placeholder for community entries
        itemBuilder: (context, index) {
          final entry = entries[index];
          return PlantCard(
            entry: entry,
            onTap: () => context.push('/details', extra: entry),
          );
        },
      ),
    );
  }
}
