import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Step2 extends StatefulWidget {
  final Function(String) onReceptionFrequencyChanged;
  final Function(String) onIntakesPerDayChanged;
  final Function(DateTime) onCourseStartDateChanged;
  final Function(DateTime) onCourseEndDateChanged;
  final DateTime courseStartDate;
  final DateTime courseEndDate;

  const Step2({
    super.key,
    required this.onReceptionFrequencyChanged,
    required this.onIntakesPerDayChanged,
    required this.onCourseStartDateChanged,
    required this.onCourseEndDateChanged,
    required this.courseStartDate,
    required this.courseEndDate,
  });

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  String receptionFrequency = 'Every day';
  String intakesPerDay = 'Once a day';
  String dose = '1 caps';
  TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);

  int totalCapsules = 0;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _calculateTotalCapsules() {
    int daysInCourse =
        widget.courseEndDate.difference(widget.courseStartDate).inDays + 1;

    Map<String, int> intakeMapping = {
      'Once a day': 1,
      'Twice a day': 2,
      'Three times a day': 3,
    };

    int intakes = intakeMapping[intakesPerDay] ?? 1;
    totalCapsules = intakes * daysInCourse;
  }

  @override
  Widget build(BuildContext context) {
    _calculateTotalCapsules();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reception frequency',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: receptionFrequency.isNotEmpty ? receptionFrequency : null,
              items: <String>['Every day', 'Every other day', 'Weekly']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  receptionFrequency = newValue ?? '';
                });
                widget.onReceptionFrequencyChanged(receptionFrequency);
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Number of intakes per day',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: intakesPerDay,
              items: <String>['Once a day', 'Twice a day', 'Three times a day']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  intakesPerDay = newValue!;
                });
                widget.onIntakesPerDayChanged(intakesPerDay);
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Set time and dose',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(
                      'Time: ${selectedTime.format(context)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: dose,
                    items: <String>['1 caps', '2 caps', '3 caps']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dose = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Course duration',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: widget.courseStartDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        widget.onCourseStartDateChanged(selectedDate);
                      }
                    },
                    child: Text(
                      'Beginning: ${DateFormat('d MMM').format(widget.courseStartDate)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            widget.courseEndDate.isAfter(widget.courseStartDate)
                                ? widget.courseEndDate
                                : widget.courseStartDate,
                        firstDate: widget.courseStartDate,
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        widget.onCourseEndDateChanged(selectedDate);
                        _calculateTotalCapsules();
                      }
                    },
                    child: Text(
                      'Ending: ${DateFormat('d MMM').format(widget.courseEndDate)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
