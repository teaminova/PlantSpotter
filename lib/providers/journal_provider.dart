import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:plant_spotter_lab2/services/auth_service.dart';
import '../model/plant_entry.dart';

class JournalProvider extends ChangeNotifier {
  List<PlantEntry> entries = [
    PlantEntry(
        image: "assets/rose.png",
        name: "Rose",
        date: DateTime(2024, 6, 23),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning rose during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: false,
        user: "jane.doe"
    ),
    PlantEntry(
        image: "assets/tulip.png",
        name: "Tulip",
        date: DateTime(2024, 6, 20),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning tulip during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: true,
        user: "jane.doe"
    ),
    PlantEntry(
        image: "assets/sunflower.png",
        name: "Sunflower",
        date: DateTime(2024, 6, 19),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning sunflower during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: true,
        user: "james.dean"
    ),
    PlantEntry(
        image: "assets/dahlia.png",
        name: "Dahlia",
        date: DateTime(2024, 5, 28),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning dahlia during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: true,
        user: "ellie.williams"
    ),
    PlantEntry(
        image: "assets/oak.png",
        name: "Oak",
        date: DateTime(2024, 5, 17),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning oak tree during my morning walk in Central Park. The soft leaves glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: true,
        user: "chris.peters"
    ),
    PlantEntry(
        image: "assets/holly.png",
        name: "Holly",
        date: DateTime(2024, 5, 15),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning holly during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: true,
        user: "jane.doe"
    ),
    PlantEntry(
        image: "assets/orchid.png",
        name: "Orchid",
        date: DateTime(2024, 4, 16),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning orchid during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: true,
        user: "chris.peters"
    ),
    PlantEntry(
        image: "assets/daffodil.png",
        name: "Daffodil",
        date: DateTime(2024, 4, 12),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning daffodil during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        isPublic: true,
        user: "ellie.williams"
    ),
  ];

  // List.generate(
  //   10,
  //       (index) => PlantEntry(
  //     image: "assets/placeholder.png",
  //     name: "Plant $index",
  //     date: DateTime.now().subtract(Duration(days: index)),
  //     location: LatLng(0, 0),
  //     description: "Description for Plant $index",
  //     user: "User $index",
  //   ),
  // );

  Future<List<PlantEntry>> getJournalEntries() async {
    String? currentUser = await AuthService().getUsername();

    if (currentUser == null) return [];

    return entries
        .where((e) => e.user == currentUser)
        .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<List<PlantEntry>> getCommunityEntries() async {
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

    entries.add(newEntry);
    notifyListeners();
  }

  void toggleEntryPrivacy(PlantEntry entry, bool value) {
    int index = entries.indexWhere((e) => e.name == entry.name && e.user == entry.user);
    if (index != -1) {
      entries[index] = PlantEntry(
        image: entries[index].image,
        name: entries[index].name,
        date: entries[index].date,
        location: entries[index].location,
        description: entries[index].description,
        isPublic: value, // Update privacy
        user: entries[index].user,
      );
      notifyListeners();
    }
  }

}

