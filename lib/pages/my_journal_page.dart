import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../model/plant_entry.dart';
import '../providers/journal_provider.dart';
import '../widgets/plant_card.dart';

class MyJournalPage extends StatelessWidget {
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('+ New Entry'),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<PlantEntry>>(
              future: context.watch<JournalProvider>().getJournalEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final entries = snapshot.data ?? [];

                if (entries.isEmpty) {
                  return const Center(child: Text('No journal entries found.'));
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
          ),
        ],
      ),
    );
  }
}
