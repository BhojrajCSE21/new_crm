import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
      appBar: AppBar(
        title: const Text('Activities Tab'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ElevatedButton.icon(
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
            icon: const Icon(Icons.task),
            label: const Text('Task'),
          ),
          ElevatedButton.icon(
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
            icon: const Icon(Icons.meeting_room),
            label: const Text('Meeting'),
          ),
          ElevatedButton.icon(
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
            icon: const Icon(Icons.call),
            label: const Text('Call'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              _showDialog(
                context,
                'Upload Attachment',
                [
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                          if (result != null) {
                            setState(() {
                              _attachmentFileName = result.files.single.name;
                            });
                          }
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload File / Image'),
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
            icon: const Icon(Icons.attachment),
            label: const Text('Attachment'),
          ),
        ],
      ),
    );
  }
}
