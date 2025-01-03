import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class ActivitiesTab extends StatefulWidget {
  const ActivitiesTab({super.key});

  @override
  _ActivitiesTabState createState() => _ActivitiesTabState();
}

class _ActivitiesTabState extends State<ActivitiesTab> {
  // Controllers for date fields
  final TextEditingController _taskDueDateController = TextEditingController();
  final TextEditingController _meetingDateTimeController =
      TextEditingController();
  final TextEditingController _callDateTimeController = TextEditingController();

  // State for attachment file name
  String _attachmentFileName = 'No file chosen';

  // Calendar state
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Helper function to show the dialog
  void _showDialog(BuildContext context, String title, List<Widget> fields) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: fields,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(29, 78, 216, 1),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Add save logic here
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color.fromRGBO(28, 78, 216, 1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            onPressed: () {
              _showDialog(
                context,
                'Add a Task',
                [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      hintText: 'Enter task name',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _taskDueDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Due Date',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _taskDueDateController.text =
                                  '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.task, color: Color.fromRGBO(28, 78, 216, 1)),
            label: const Text('Task', style: TextStyle(color: Color.fromRGBO(28, 78, 216, 1))),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color.fromRGBO(28, 78, 216, 1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            onPressed: () {
              _showDialog(
                context,
                'Meeting Title',
                [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Meeting Title',
                      hintText: 'Enter meeting title',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _meetingDateTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date & Time',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _meetingDateTimeController.text =
                                  '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Participants',
                      hintText: 'Enter participants',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Agenda',
                      hintText: 'Enter agenda',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.meeting_room, color: Color.fromRGBO(28, 78, 216, 1)),
            label: const Text('Meeting', style: TextStyle(color: Color.fromRGBO(28, 78, 216, 1))),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color.fromRGBO(28, 78, 216, 1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            onPressed: () {
              _showDialog(
                context,
                'Log a Call',
                [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Call Subject',
                      hintText: 'Enter call subject',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _callDateTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Call Date & Time',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _callDateTimeController.text =
                                  '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Enter notes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.call, color: Color.fromRGBO(28, 78, 216, 1)),
            label: const Text('Call', style: TextStyle(color: Color.fromRGBO(28, 78, 216, 1))),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color.fromRGBO(28, 78, 216, 1)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            onPressed: () async {
              _showDialog(
                context,
                'Upload Attachment',
                [
                  Row(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Color.fromRGBO(28, 78, 216, 1)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            setState(() {
                              _attachmentFileName = result.files.single.name;
                            });
                          }
                        },
                        icon: const Icon(Icons.upload_file, color: Color.fromRGBO(28, 78, 216, 1)),
                        label: const Text('Upload File / Image', style: TextStyle(color: Color.fromRGBO(28, 78, 216, 1))),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          _attachmentFileName,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              );
            },
            icon: const Icon(Icons.attachment, color: Color.fromRGBO(28, 78, 216, 1)),
            label: const Text('Attachment', style: TextStyle(color: Color.fromRGBO(28, 78, 216, 1))),
          ),
          // Calendar Container
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Color.fromRGBO(29, 78, 216, 1),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              rowHeight: 40, // Reduced row height
            ),
          ),
        ],
      ),
    );
  }
}
