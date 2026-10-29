import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/event.dart';

class EventService {
  static const String _keyEvents = 'eventos';
  final SharedPreferences? _prefs;

  EventService({SharedPreferences? prefs}) : _prefs = prefs {
    _loadEvents();
  }

  final List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> _loadEvents() async {
    if (_prefs == null) return;
    final jsonString = _prefs!.getStringList(_keyEvents);
    if (jsonString != null) {
      _events = jsonString
          .map((json) => Event.fromMap(jsonDecode(json) as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> _saveEvents() async {
    if (_prefs == null) return;
    final jsonStrings =
        _events.map((event) => jsonEncode(event.toMap())).toList();
    await _prefs!.setStringList(_keyEvents, jsonStrings);
  }

  void addEvent(Event event) {
    _events.add(event);
    _saveEvents();
  }

  void removeEvent(String id) {
    _events.removeWhere((event) => event.id == id);
    _saveEvents();
  }

  Event? getEvent(String id) {
    return _events.firstWhere(
      (event) => event.id == id,
      orElse: () => throw Exception('Event not found'),
    );
  }

  List<Event> getEventsByDateRange(DateTime start, DateTime end) {
    return _events.where((event) {
      return event.date.isAfter(start) && event.date.isBefore(end);
    }).toList();
  }

  List<Event> search(String query) {
    if (query.isEmpty) return _events;
    return _events.where((event) {
      return event.title.toLowerCase().contains(query.toLowerCase()) ||
          event.location.toLowerCase().contains(query.toLowerCase()) ||
          event.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}