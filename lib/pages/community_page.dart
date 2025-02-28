import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../model/plant_entry.dart';
import '../providers/journal_provider.dart';
import '../services/auth_service.dart';
import '../widgets/plant_card.dart';

class CommunityPage extends StatelessWidget {
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
        title: const Text('Community', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<List<PlantEntry>>(
        future: context.watch<JournalProvider>().getCommunityEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final entries = snapshot.data ?? [];

          if (entries.isEmpty) {
            return const Center(child: Text('No community entries found.'));
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return PlantCard(
                entry: entry,
                onTap: () => context.push('/details', extra: entry),
              );
            },
          );
        },
      ),
    );
  }
}
