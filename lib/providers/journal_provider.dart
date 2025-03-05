import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:plant_spotter_lab2/services/auth_service.dart';
import '../model/plant_entry.dart';

class JournalProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<PlantEntry> entries = [];

  JournalProvider() {
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    // fetch from Firebase
    try {
      final snapshot = await _firestore.collection('entries').get();
      entries.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();

        LatLng? location;
        if (data['location'] != null) {
          final geoPoint = data['location'] as GeoPoint;
          location = LatLng(geoPoint.latitude, geoPoint.longitude);
        }

        entries.add(
          PlantEntry(
            image: data['image'] ?? '',
            name: data['name'] ?? 'Unknown',
            date: (data['date'] as Timestamp).toDate(),
            location: location ?? LatLng(0.0, 0.0),
            description: data['description'] ?? '',
            isPublic: data['isPublic'] ?? false,
            user: data['user'] ?? '',
          ),
        );
      }
    } catch (e) {
      print('Error fetching entries: $e');
    }
    // isLoading = false;
    // notifyListeners();
  }

  Future<List<PlantEntry>> getJournalEntries() async {
    await fetchEntries();

    String? currentUser = await AuthService().getUsername();

    if (currentUser == null) return [];

    return entries
        .where((e) => e.user == currentUser)
        .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<List<PlantEntry>> getCommunityEntries() async {
    await fetchEntries();

    String? currentUser = await AuthService().getUsername();

    if (currentUser == null) {
      return entries
          .where((e) => e.isPublic)
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    }

    return entries
        .where((e) => e.user != currentUser && e.isPublic)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> addEntry (String image, String name, DateTime date, LatLng location, String description, bool isPublic) async {
    String? currentUser = await AuthService().getUsername();

    if (currentUser == null) {
      return;
    }

    PlantEntry newEntry = PlantEntry(
      image: image,
      name: name,
      date: date,
      location: location,
      description: description,
      isPublic: isPublic,
      user: currentUser,
    );

    try {
      await _firestore.collection('entries').add(newEntry.toJson());
    } catch (e) {
      print('Error adding new entry to Firebase: $e');
    }

    entries.add(newEntry);

    notifyListeners();
  }

  Future<void> toggleEntryPrivacy(PlantEntry entry, bool value) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('entries')
          .where('name', isEqualTo: entry.name)
          .where('user', isEqualTo: entry.user)
          .get();

      if (query.docs.isNotEmpty) {
        String docId = query.docs.first.id;
        await _firestore.collection('entries').doc(docId).update(
            {'isPublic': value});

        int index = entries.indexWhere((e) =>
        e.name == entry.name && e.user == entry.user);
        if (index != -1) {
          PlantEntry updatedEntry = PlantEntry(
            image: entries[index].image,
            name: entries[index].name,
            date: entries[index].date,
            location: entries[index].location,
            description: entries[index].description,
            isPublic: value,
            user: entries[index].user,
          );

          entries[index] = updatedEntry;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error updating entry privacy: $e');
    }
  }

}

