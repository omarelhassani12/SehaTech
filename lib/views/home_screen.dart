import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/medication_schedule.dart';
import '../routes/routes.dart';
import '../utils/colors.dart';
import '../widgets/custom_card_medicaments.dart';
import '../widgets/custom_filter.dart';

class CustomCardExample extends StatelessWidget {
  const CustomCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      color: Colors.black87,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Health Articles",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Why do pills only need water?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ...List.generate(
                        8,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(
                            Icons.circle,
                            size: 4,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Image.asset(
                        'assets/img/person_drinking.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All day", "selected": false},
    {"label": "Morning", "selected": true},
    {"label": "Afternoon", "selected": false},
    {"label": "Evening", "selected": false},
  ];

  void handleFilterSelection(String label, bool isSelected) {
    setState(() {
      for (var option in filterOptions) {
        if (option['label'] == label) {
          option['selected'] = isSelected;
        } else {
          option['selected'] = false;
        }
      }
    });
  }

  List<Map<String, dynamic>> getFilteredItems() {
    final selectedFilter = filterOptions.firstWhere(
      (option) => option['selected'] == true,
      orElse: () => filterOptions.first,
    )['label'];

    if (selectedFilter == "All day") {
      return medicationSchedule;
    }

    return medicationSchedule.where((item) {
      final time = item['time'].toLowerCase();
      final hour = int.parse(time.split(':')[0].trim());

      if (selectedFilter == "Morning") {
        return time.contains("am") && hour < 12;
      } else if (selectedFilter == "Afternoon") {
        return time.contains("pm") && hour >= 12 && hour < 6;
      } else if (selectedFilter == "Evening") {
        return time.contains("pm") && hour >= 6;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = getFilteredItems();

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (index) {
                        final days = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"];
                        final today = DateTime.now();
                        final currentDay = today.weekday;

                        final startOfWeek = today.subtract(
                          Duration(days: today.weekday - 1),
                        );
                        final dayOfMonth = startOfWeek
                            .add(
                              Duration(days: index),
                            )
                            .day;

                        final isToday = (index + 1) == currentDay;
                        final isPastDate = startOfWeek
                            .add(Duration(days: index))
                            .isBefore(today);
                        final isMedicationTaken = index % 2 == 0;

                        return Container(
                          decoration: isToday
                              ? BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(35),
                                )
                              : null,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              if (isPastDate)
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isMedicationTaken
                                          ? AppColors.green
                                          : AppColors.red,
                                      width: 4,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "$dayOfMonth",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              if (!isPastDate)
                                CircleAvatar(
                                  backgroundColor: isToday
                                      ? AppColors.primaryBlue
                                      : AppColors.white,
                                  radius: 18,
                                  child: Text(
                                    "$dayOfMonth",
                                    style: TextStyle(
                                      color:
                                          isToday ? Colors.white : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              SizedBox(height: 5),
                              Text(
                                days[index],
                                style: TextStyle(
                                  color: isToday ? Colors.white : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      DateFormat('EEEE, MMM d').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomFilter(
                    filterOptions: filterOptions,
                    onFilterSelected: handleFilterSelection,
                  ),
                  SizedBox(height: 20),
                  if (filteredItems.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: CustomCardDisplay(
                            imagePath: item['imagePath'],
                            title: item['title'],
                            subtitle: item['subtitle'],
                            time: item['time'],
                            date: item['date'],
                            isDone: item['isDone'],
                          ),
                        );
                      },
                    )
                  else
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/no-medicament-img.png',
                            height: 150,
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            "Add medicament",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.greyClr,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addMedicine);
        },
        backgroundColor: AppColors.primaryBlue,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomAppBar(
                color: Colors.transparent,
                shape: CircularNotchedRectangle(),
                notchMargin: 8.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBottomNavItem(context, Routes.journal,
                          'assets/img/journal_icon.png', 'Journal'),
                      _buildBottomNavItem(context, Routes.health,
                          'assets/img/health_icon.png', 'Health'),
                      SizedBox(width: 40),
                      _buildBottomNavItem(context, Routes.statistics,
                          'assets/img/statistics_icon.png', 'Statistics'),
                      _buildBottomNavItem(context, Routes.rating,
                          'assets/img/rating_icon.png', 'Rating'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(
      BuildContext context, String route, String assetPath, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            assetPath,
            width: 32,
            height: 32,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
