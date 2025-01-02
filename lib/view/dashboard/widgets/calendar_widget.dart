import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({super.key});

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  final eventsController = EventsController();
  final calendarController = CalendarController();

  late final DateTime now = DateTime.now();
  late final DateTimeRange displayRange =
      DateTimeRange(start: now.subtract(Duration(days: 363)), end: now.add(Duration(days: 365)));
  late ViewConfiguration viewConfiguration = viewConfigurations[0];

  final List<ViewConfiguration> viewConfigurations = [
    MultiDayViewConfiguration.week(displayRange: DateTimeRange(start: DateTime.now(), end: DateTime.now().add(Duration(days: 365)))),
    MultiDayViewConfiguration.singleDay(),
    MonthViewConfiguration.singleMonth(),
  ];

  @override
  void initState() {
    super.initState();
    _addSampleEvents();
  }

  void _addSampleEvents() {
    eventsController.addEvents([
      CalendarEvent(
        dateTimeRange: DateTimeRange(start: now, end: now.add(const Duration(hours: 1))),
        data: "Sample Event 1",
      ),
      CalendarEvent(
        dateTimeRange: DateTimeRange(start: now.add(const Duration(days: 1)), end: now.add(const Duration(days: 1, hours: 1))),
        data: "Sample Event 2",
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return CalendarView(
      eventsController: eventsController,
      calendarController: calendarController,
      viewConfiguration: viewConfiguration,
      callbacks: CalendarCallbacks(
        onEventTapped: (event, renderBox) => _showEventDetails(event),
        onEventCreate: (event) => event.copyWith(data: "New Event"),
        onEventCreated: (event) => eventsController.addEvent(event),
      ),
      header: _buildCalendarHeader(),
      body: CalendarBody(
        multiDayTileComponents: _tileComponents(),
        monthTileComponents: _tileComponents(),
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Material(
      elevation: 2,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          _buildToolbar(),
          CalendarHeader(
            multiDayTileComponents: _tileComponents(),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.tonal(
              onPressed: () {},
              child: ValueListenableBuilder<DateTimeRange>(
                valueListenable: calendarController.visibleDateTimeRange,
                builder: (context, value, child) {
                  return Text('${value.start.monthNameEnglish} ${value.start.year}');
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () => calendarController.animateToPreviousPage(),
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            onPressed: () => calendarController.animateToNextPage(),
            icon: const Icon(Icons.chevron_right),
          ),
          IconButton(
            onPressed: () => calendarController.animateToDate(DateTime.now()),
            icon: const Icon(Icons.today),
          ),
          DropdownMenu(
            dropdownMenuEntries: viewConfigurations
                .map((config) => DropdownMenuEntry(value: config, label: config.name))
                .toList(),
            initialSelection: viewConfiguration,
            onSelected: (value) {
              if (value != null) setState(() => viewConfiguration = value);
            },
          ),
        ],
      ),
    );
  }

  TileComponents _tileComponents() {
    return TileComponents(
      tileBuilder: (event, tileRange) {
        return Card(
          margin: EdgeInsets.zero,
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              event.data.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void _showEventDetails(CalendarEvent event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Event Details"),
          content: Text("Event: ${event.data}\nStart: ${event.dateTimeRange.start}\nEnd: ${event.dateTimeRange.end}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
