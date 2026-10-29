import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/add_event_screen.dart';
import 'screens/event_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(EventManagementApp(prefs: prefs));
}

class EventManagementApp extends StatelessWidget {
  const EventManagementApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            HomeScreen(eventService: EventService(prefs: prefs)),
        '/add-event': (context) =>
            AddEventScreen(eventService: EventService(prefs: prefs)),
        '/event-list': (context) =>
            EventListScreen(eventService: EventService(prefs: prefs)),
      },
      home: const HomeScreen(),
    );
  }
}