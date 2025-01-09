import 'package:flutter/material.dart';

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
      backgroundColor: Colors.blue[50],
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
                            final days = [
                              "Tu",
                              "We",
                              "Th",
                              "Fr",
                              "Sa",
                              "Su",
                              "Mo"
                            ];
                            return Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: index == 3
                                      ? AppColors.primaryBlue
                                      : Colors.grey[200],
                                  radius: 18,
                                  child: Text(
                                    "${index + 2}",
                                    style: TextStyle(
                                        color: index == 3
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(days[index]),
                              ],
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Friday, Nov 20",
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
                      buildBottomNavItem(
                          'assets/img/journal_icon.png', 'Journal'),
                      buildBottomNavItem(
                          'assets/img/health_icon.png', 'Health'),
                      SizedBox(width: 40),
                      buildBottomNavItem(
                          'assets/img/statistics_icon.png', 'Statistics'),
                      buildBottomNavItem(
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

  Widget buildBottomNavItem(String assetPath, String label) {
    return Flexible(
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
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
