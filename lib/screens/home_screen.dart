class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late EventService _eventService;

  @override
  void initState() {
    super.initState();
    _eventService = EventService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Management'),
        centerTitle: true,
      ),
      body: _eventService.events.isEmpty
          ? const Center(child: Text('No events yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _eventService.events.length,
              itemBuilder: (context, index) {
                final event = _eventService.events[index];
                return EventCard(
                  event: event,
                  onDelete: () {
                    _eventService.removeEvent(event.id);
                    setState(() {});
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-event').then((_) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}