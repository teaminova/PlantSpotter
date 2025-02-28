import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_spotter_lab2/providers/journal_provider.dart';
import 'package:plant_spotter_lab2/router.dart';
import 'package:plant_spotter_lab2/providers/images_provider.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(PlantSpotterApp());
}

class PlantSpotterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JournalProvider()),
        ChangeNotifierProvider(create: (_) => ImagesProvider()),
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
