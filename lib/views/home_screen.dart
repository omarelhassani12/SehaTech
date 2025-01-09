import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../routes/routes.dart';
import '../utils/colors.dart';

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
                      left: 10, // Adjust as needed
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (index) {
                            // Days from Monday to Sunday
                            final days = [
                              "Mo",
                              "Tu",
                              "We",
                              "Th",
                              "Fr",
                              "Sa",
                              "Su"
                            ];
                            final today = DateTime.now();
                            final currentDay =
                                today.weekday; // 1 (Monday) to 7 (Sunday)

                            // Calculate the date for the current day in the week
                            final startOfWeek = today.subtract(Duration(
                                days: today.weekday - 1)); // Start from Monday
                            final dayOfMonth =
                                startOfWeek.add(Duration(days: index)).day;

                            // Check if the current day is today
                            final isToday = (index + 1) == currentDay;

                            // Check if the date is before today
                            final isPastDate = startOfWeek
                                .add(Duration(days: index))
                                .isBefore(today);

                            // Mock data: Replace this with your actual logic to check if medication was taken
                            final isMedicationTaken =
                                index % 2 == 0; // Example: Alternating days

                            return Container(
                              decoration: isToday
                                  ? BoxDecoration(
                                      color: AppColors
                                          .black, // Background color for today
                                      borderRadius: BorderRadius.circular(
                                          35), // Rounded corners
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
                                          color: isToday
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 5),
                                  Text(
                                    days[index],
                                    style: TextStyle(
                                      color:
                                          isToday ? Colors.white : Colors.black,
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
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomCardExample(),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilterChip(
                              label: Text("All day"),
                              onSelected: (bool value) {},
                            ),
                            FilterChip(
                              label: Text("Morning"),
                              selected: true,
                              onSelected: (bool value) {},
                            ),
                            FilterChip(
                              label: Text("Afternoon"),
                              onSelected: (bool value) {},
                            ),
                            FilterChip(
                              label: Text("Evening"),
                              onSelected: (bool value) {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Spacer(), // Ensures remaining space is used, preventing overflow.
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        Navigator.pushNamed(context, route); // Navigate to the specified route
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
