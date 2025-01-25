import 'package:flutter/material.dart';

class Step3 extends StatefulWidget {
  final Function(bool) onRemindMeChanged;
  final Function(String) onDoctorEmailChanged;
  final bool remindMe;
  final String doctorEmail;
  final DateTime courseEndDate;
  final int totalCapsules;

  const Step3({
    super.key,
    required this.onRemindMeChanged,
    required this.onDoctorEmailChanged,
    required this.remindMe,
    required this.doctorEmail,
    required this.courseEndDate,
    required this.totalCapsules,
  });

  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  late bool remindMe;
  late String doctorEmail;
  String notesText = 'Sip plenty of water.';
  String selectedReminder = 'In that moment';

  @override
  void initState() {
    super.initState();
    remindMe = widget.remindMe;
    doctorEmail = widget.doctorEmail;
    notesText = 'Sip plenty of water.';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            'Remind me',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedReminder,
            decoration: const InputDecoration(
              hintText: 'Select reminder',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: [
              'In that moment',
              '5 minutes before',
              '15 minutes before',
              '30 minutes before'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedReminder = newValue;
                });
                widget.onRemindMeChanged(newValue == 'In that moment');
              }
            },
          ),
          const SizedBox(height: 24),

          const Text(
            'Number of intakes per day',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: notesText),
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Notes here...',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(16),
            ),
            onChanged: (value) {
              setState(() {
                notesText = value;
              });
            },
          ),
          const SizedBox(height: 24),

          const Text(
            'Doctor email',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: doctorEmail),
            decoration: const InputDecoration(
              hintText: 'doctor@example.com',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              setState(() {
                doctorEmail = value;
              });
              widget.onDoctorEmailChanged(value);
            },
          ),
          const SizedBox(height: 24),

          Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseEndDate.toString().split(' ')[0],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Last day of course',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.calendar_today, color: Colors.blue),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.totalCapsules} capsules',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Will be taken',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.medication, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
