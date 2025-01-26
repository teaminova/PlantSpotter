import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_spotter_lab2/providers/journal_provider.dart';
import 'package:plant_spotter_lab2/router.dart';
import 'package:plant_spotter_lab2/services/image_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PlantSpotterApp());
}

class PlantSpotterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JournalProvider()),
        ChangeNotifierProvider(create: (_) => ImageService()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFDFF2D4),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF6B8E58),
            foregroundColor: Colors.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF6B8E58),
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
