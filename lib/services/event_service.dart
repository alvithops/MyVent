class EventService {
  final List<Event> _events = [];

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
  }

  void removeEvent(String id) {
    _events.removeWhere((event) => event.id == id);
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