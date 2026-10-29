import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_event_screen.dart';
import 'screens/event_list_screen.dart';

void main() {
  runApp(const EventManagementApp());
}

class EventManagementApp extends StatelessWidget {
  const EventManagementApp({super.key});

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
        '/': (context) => const HomeScreen(),
        '/add-event': (context) => const AddEventScreen(),
        '/event-list': (context) => const EventListScreen(),
      },
      home: const HomeScreen(),
    );
  }
}