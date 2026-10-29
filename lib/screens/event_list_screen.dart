class EventListScreen extends StatefulWidget {
  final EventService eventService;
  const EventListScreen({required this.eventService, super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
        centerTitle: true,
      ),
      body: widget.eventService.events.isEmpty
          ? const Center(child: Text('No events found'))
          : ListView.builder(
              itemCount: widget.eventService.events.length,
              itemBuilder: (context, index) {
                final event = widget.eventService.events[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.event),
                    title: Text(event.title),
                    subtitle: Text(
                      'Date: ${event.date.toLocal()}'.split(' ')[0] +
                          '\nLocation: ${event.location}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        widget.eventService.removeEvent(event.id);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-event');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}