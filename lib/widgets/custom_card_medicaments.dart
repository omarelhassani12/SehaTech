import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomCardDisplay extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String time;
  final String date;
  final bool isDone;

  const CustomCardDisplay({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.date,
    this.isDone = false,
  });

  DateTime? _parseDateTime(String date, String time) {
    try {
      final parsedDate = DateFormat('yyyy-MM-dd').parse(date);

      final cleanTime = time.trim().toLowerCase();
      final sanitizedTime = cleanTime.replaceAll(RegExp(r'\s+'), ' ');
      final RegExp timeRegex = RegExp(r'(\d{1,2}):(\d{2})\s*(am|pm)');
      final match = timeRegex.firstMatch(sanitizedTime);

      if (match == null) {
        throw FormatException('Invalid time format');
      }

      var hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      final period = match.group(3);
      if (period == 'pm' && hours < 12) {
        hours += 12;
      } else if (period == 'am' && hours == 12) {
        hours = 0;
      }
      return DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        hours,
        minutes,
      );
    } catch (e) {
      print('Error parsing date/time: $e');
      print('Input date: "$date", time: "$time"');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sanitizedDate = date.trim().replaceAll(RegExp(r'\s+'), '');
    final sanitizedTime = time.trim().replaceAll(RegExp(r'\s+'), ' ');

    print('Sanitized Date: "$sanitizedDate", Sanitized Time: "$sanitizedTime"');

    final itemDateTime = _parseDateTime(sanitizedDate, sanitizedTime) ?? now;
    final isPast = itemDateTime.isBefore(now);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(width: 1, color: AppColors.greyClr),
        ),
        elevation: 3,
        child: ListTile(
          leading: Image.asset(
            imagePath,
            width: 40,
            fit: BoxFit.cover,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 14, color: AppColors.greyClr),
          ),
          trailing: isPast
              ? (isDone
                  ? Image.asset('assets/img/done_icon.png')
                  : Image.asset('assets/img/miss_icon.png'))
              : Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: AppColors.secondrayBlue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 20,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
