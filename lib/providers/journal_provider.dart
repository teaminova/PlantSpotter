import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../model/plant_entry.dart';

class JournalProvider extends ChangeNotifier {
  List<PlantEntry> entries = [
    PlantEntry(
        image: "assets/rose.png",
        name: "Rose",
        date: DateTime(2024, 6, 23),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning rose during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        user: "jane.doe"
    ),
    PlantEntry(
        image: "assets/tulip.png",
        name: "Tulip",
        date: DateTime(2024, 6, 20),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning tulip during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        user: "jane.doe"
    ),
    PlantEntry(
        image: "assets/sunflower.png",
        name: "Sunflower",
        date: DateTime(2024, 6, 19),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning sunflower during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        user: "james.dean"
    ),
    PlantEntry(
        image: "assets/dahlia.png",
        name: "Dahlia",
        date: DateTime(2024, 5, 28),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning dahlia during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        user: "ellie.williams"
    ),
    PlantEntry(
        image: "assets/oak.png",
        name: "Oak",
        date: DateTime(2024, 5, 17),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning oak tree during my morning walk in Central Park. The soft leaves glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        user: "chris.peters"
    ),
    PlantEntry(
        image: "assets/holly.png",
        name: "Holly",
        date: DateTime(2024, 5, 15),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning holly during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        user: "jane.doe"
    ),
    PlantEntry(
        image: "assets/orchid.png",
        name: "Orchid",
        date: DateTime(2024, 4, 16),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning orchid during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
        user: "chris.peters"
    ),
    PlantEntry(
        image: "assets/daffodil.png",
        name: "Daffodil",
        date: DateTime(2024, 4, 12),
        location: LatLng(42.004971, 21.408303),
        description: "Spotted this stunning daffodil during my morning walk in Central Park. The soft petals glistened with dew, capturing the beauty of a peaceful sunrise. It reminded me to pause and appreciate the simple moments of life.",
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

  void addEntry(PlantEntry entry) {
    entries.add(entry);
    notifyListeners();
  }
}

