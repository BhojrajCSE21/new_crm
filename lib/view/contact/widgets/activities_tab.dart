import 'package:flutter/material.dart';


class ActivitiesTab extends StatelessWidget {
  const ActivitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.task),
          label: const Text('Task'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.meeting_room),
          label: const Text('Meeting'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.call),
          label: const Text('Call'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.attachment),
          label: const Text('Attachment'),
        ),
      ],
    );
  }
}
