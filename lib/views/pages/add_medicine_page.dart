import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/add_medicine_step1.dart';
import '../../widgets/add_medicine_step2.dart';
import '../../widgets/add_medicine_step3.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentStep = 0;

  // Step 1 data
  String medicineName = '';
  String medicineType = '';
  int amount = 0;
  String connectionWithFood = '';

  // Step 2 data
  String receptionFrequency = 'Every day';
  int intakesPerDay = 1;
  List<Map<String, dynamic>> schedule = [];
  DateTime courseStartDate = DateTime.now();
  DateTime courseEndDate =
      DateTime.now().add(const Duration(days: 30)); // Default 30 days

  // Step 3 data
  bool remindMe = true;
  String doctorEmail = '';

  // Calculate total capsules based on course duration and intake frequency
  int calculateTotalCapsules() {
    final duration = courseEndDate.difference(courseStartDate).inDays + 1;
    int frequencyMultiplier = 1;

    switch (receptionFrequency) {
      case 'Every day':
        frequencyMultiplier = 1;
        break;
      case 'Every other day':
        frequencyMultiplier = 2;
        break;
      case 'Weekly':
        frequencyMultiplier = 7;
        break;
      default:
        frequencyMultiplier = 1;
    }

    return (duration ~/ frequencyMultiplier) * intakesPerDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildProgressBar(0),
                const SizedBox(width: 4),
                _buildProgressBar(1),
                const SizedBox(width: 4),
                _buildProgressBar(2),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Step1(
            onMedicineNameChanged: (value) =>
                setState(() => medicineName = value),
            onMedicineTypeChanged: (value) =>
                setState(() => medicineType = value),
            onAmountChanged: (value) => setState(() => amount = value),
            onConnectionWithFoodChanged: (value) =>
                setState(() => connectionWithFood = value),
          ),
          Step2(
            onReceptionFrequencyChanged: (value) =>
                setState(() => receptionFrequency = value),
            onIntakesPerDayChanged: (value) => setState(() =>
                intakesPerDay = int.tryParse(value.split(' ').first) ?? 1),
            onCourseStartDateChanged: (value) =>
                setState(() => courseStartDate = value),
            onCourseEndDateChanged: (value) =>
                setState(() => courseEndDate = value),
            courseStartDate: courseStartDate,
            courseEndDate: courseEndDate,
          ),
          Step3(
            onRemindMeChanged: (value) => setState(() => remindMe = value),
            onDoctorEmailChanged: (value) =>
                setState(() => doctorEmail = value),
            remindMe: remindMe,
            doctorEmail: doctorEmail,
            courseEndDate: courseEndDate,
            totalCapsules: calculateTotalCapsules(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_currentStep > 0)
              TextButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _currentStep--;
                  });
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: const Text(
                  'Back to previous step',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (_currentStep < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  _submitForm();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: Text(
                _currentStep == 2 ? 'Add' : 'Continue',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(int step) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color:
              _currentStep >= step ? AppColors.primaryBlue : Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  void _submitForm() {
    // Print form data for debugging
    print('Medicine Name: $medicineName');
    print('Medicine Type: $medicineType');
    print('Amount: $amount');
    print('Connection with Food: $connectionWithFood');
    print('Reception Frequency: $receptionFrequency');
    print('Intakes Per Day: $intakesPerDay');
    print('Course Start Date: $courseStartDate');
    print('Course End Date: $courseEndDate');
    print('Remind Me: $remindMe');
    print('Doctor Email: $doctorEmail');
    print('Total Capsules: ${calculateTotalCapsules()}');

    Navigator.pop(context);
  }
}

// import 'package:flutter/material.dart';
// import '../../utils/colors.dart';
// import '../../widgets/add_medicine_step1.dart';
// import '../../widgets/add_medicine_step2.dart';
// import '../../widgets/add_medicine_step3.dart';

// class AddMedicineScreen extends StatefulWidget {
//   const AddMedicineScreen({super.key});

//   @override
//   State<AddMedicineScreen> createState() => _AddMedicineScreenState();
// }

// class _AddMedicineScreenState extends State<AddMedicineScreen> {
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentStep = 0;

//   String medicineName = '';
//   String medicineType = '';
//   int amount = 0;
//   String connectionWithFood = '';
//   String receptionFrequency = '';
//   int intakesPerDay = 1;
//   List<Map<String, dynamic>> schedule = [];
//   DateTime courseStartDate = DateTime.now();
//   DateTime courseEndDate = DateTime.now();
//   bool remindMe = true;
//   String doctorEmail = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Medicine'),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(20),
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Row(
//               children: [
//                 _buildProgressBar(0),
//                 const SizedBox(width: 4),
//                 _buildProgressBar(1),
//                 const SizedBox(width: 4),
//                 _buildProgressBar(2),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           Step1(
//             onMedicineNameChanged: (value) =>
//                 setState(() => medicineName = value),
//             onMedicineTypeChanged: (value) =>
//                 setState(() => medicineType = value),
//             onAmountChanged: (value) => setState(() => amount = value),
//             onConnectionWithFoodChanged: (value) =>
//                 setState(() => connectionWithFood = value),
//           ),
//           Step2(
//             onReceptionFrequencyChanged: (value) =>
//                 setState(() => receptionFrequency = value),
//             onIntakesPerDayChanged: (value) =>
//                 setState(() => intakesPerDay = int.tryParse(value) ?? 1),
//             onCourseStartDateChanged: (value) =>
//                 setState(() => courseStartDate = value),
//             onCourseEndDateChanged: (value) =>
//                 setState(() => courseEndDate = value),
//             courseStartDate: courseStartDate,
//             courseEndDate: courseEndDate,
//           ),
//           Step3(
//             onRemindMeChanged: (value) => setState(() {
//               remindMe = value;
//             }),
//             onDoctorEmailChanged: (value) => setState(() {
//               doctorEmail = value;
//             }),
//             remindMe:
//                 remindMe,
//             doctorEmail:
//                 doctorEmail,
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (_currentStep > 0)
//               TextButton(
//                 onPressed: () {
//                   _pageController.previousPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                   setState(() {
//                     _currentStep--;
//                   });
//                 },
//                 style: TextButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   minimumSize: const Size(double.infinity, 0),
//                 ),
//                 child: const Text(
//                   'Back to previous step',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.primaryBlue,
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 if (_currentStep < 2) {
//                   _pageController.nextPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                   setState(() {
//                     _currentStep++;
//                   });
//                 } else {
//                   _submitForm();
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryBlue,
//                 foregroundColor: AppColors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 minimumSize: const Size(double.infinity, 0),
//               ),
//               child: Text(
//                 _currentStep == 2 ? 'Add' : 'Continue',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProgressBar(int step) {
//     return Expanded(
//       child: Container(
//         height: 4,
//         decoration: BoxDecoration(
//           color:
//               _currentStep >= step ? AppColors.primaryBlue : Colors.grey[300],
//           borderRadius: BorderRadius.circular(2),
//         ),
//       ),
//     );
//   }

//   void _submitForm() {
//     print('Medicine Name: $medicineName');
//     print('Medicine Type: $medicineType');
//     print('Amount: $amount');
//     print('Connection with Food: $connectionWithFood');
//     print('Reception Frequency: $receptionFrequency');
//     print('Intakes Per Day: $intakesPerDay');
//     print('Course Start Date: $courseStartDate');
//     print('Course End Date: $courseEndDate');
//     print('Remind Me: $remindMe');
//     print('Doctor Email: $doctorEmail');

//     Navigator.pop(context);
//   }
// }
