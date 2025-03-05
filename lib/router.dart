import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:plant_spotter_lab2/pages/camera_page.dart';
import 'package:plant_spotter_lab2/pages/community_page.dart';
import 'package:plant_spotter_lab2/pages/details_page.dart';
import 'package:plant_spotter_lab2/pages/gallery_page.dart';
import 'package:plant_spotter_lab2/pages/home_page.dart';
import 'package:plant_spotter_lab2/pages/learn_more_page.dart';
import 'package:plant_spotter_lab2/pages/login_page.dart';
import 'package:plant_spotter_lab2/pages/my_journal_page.dart';
import 'package:plant_spotter_lab2/pages/new_entry_page.dart';
import 'package:plant_spotter_lab2/pages/register_page.dart';
import 'package:plant_spotter_lab2/pages/see_location_page.dart';
import 'package:plant_spotter_lab2/pages/set_location_page.dart';

import 'model/plant_entry.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/journal', builder: (context, state) => MyJournalPage()),
    GoRoute(path: '/new_entry', builder: (context, state) => NewEntryPage()),
    GoRoute(path: '/camera', builder: (context, state) => CameraPage()),
    // GoRoute(path: '/gallery', builder: (context, state) => GalleryPage()),
    GoRoute(path: '/set_location', builder: (context, state) => SetLocationPage()),
    // GoRoute(path: '/details', builder: (context, state) => DetailsPage(entry: state.extra)),
    // GoRoute(path: '/see_location', builder: (context, state) => SeeLocationPage(location: state.extra)),
    // GoRoute(path: '/learn_more', builder: (context, state) => LearnMorePage(plantName: state.extra)),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        final entry = state.extra as PlantEntry;
        return DetailsPage(entry: entry);
      },
    ),
    GoRoute(
      path: '/see_location',
      builder: (context, state) {
        final location = state.extra as LatLng;
        return SeeLocationPage(location: location);
      },
    ),
    GoRoute(
      path: '/learn_more',
      builder: (context, state) {
        final plantName = state.extra as String;
        return LearnMorePage(plantName: plantName);
      },
    ),
    GoRoute(path: '/community', builder: (context, state) => CommunityPage()),
  ],
);
