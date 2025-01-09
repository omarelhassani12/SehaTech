import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../utils/colors.dart';

class ActivationCodeScreen extends StatelessWidget {
  final TextEditingController _activationCodeController =
      TextEditingController();

  ActivationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/img/sign_in_img.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Scrollable Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50), // Add space at the top
                  Image.asset(
                    'assets/img/sahatk.png',
                    width: 300,
                    // height: 100,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Activate Your Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Enter the code provided by your pharmacy to unlock all features of Sihatech.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _activationCodeController,
                    decoration: InputDecoration(
                      labelText: 'Enter your code here',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                      // String code = _codeController.text;
                      String activationCode =
                          _activationCodeController.text.trim();
                      print('Activation Code: $activationCode');

                      if (activationCode.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter the activation code',
                              style: TextStyle(color: AppColors.primaryBlue),
                            ),
                            backgroundColor: Colors.white,
                          ),
                        );
                        return;
                      }
                      if (activationCode == 'sehatech') {
                        Navigator.pushNamed(context, Routes.home);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Account activated successfully. Welcome to SehaTech!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Invalid activation code. Please try again.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Activate Now',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.primaryBlue),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      print('Learn more clicked');
                    },
                    child: const Text(
                      "Don't have a code? Learn more",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:sehatech/utils/colors.dart';

// class ActivationCodeScreen extends StatelessWidget {
//   final TextEditingController _codeController = TextEditingController();

//   ActivationCodeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.5,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/img/sign_in_img.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Activate Your SehaTech Account',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'Enter the code provided by your pharmacy to unlock all features of SehaTech.',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 100),
//                   TextField(
//                     controller: _codeController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter your code here',
//                       labelStyle: const TextStyle(color: AppColors.primaryBlue),
//                       filled: true,
//                       fillColor: AppColors.white.withValues(alpha: 0.3),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: AppColors.primaryBlue,
//                         ),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 14),
//                     ),
//                     style: const TextStyle(color: AppColors.primaryBlue),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       String code = _codeController.text;
//                       print('Activation Code: $code');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primaryBlue,
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 50, vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: const Text(
//                       'Activate Now',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                   const SizedBox(height: 80),
//                   RichText(
//                     text: TextSpan(
//                       children: [
//                         const TextSpan(
//                           text: "Don't have a code? ",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         TextSpan(
//                           text: "Learn more",
//                           style: const TextStyle(
//                             color: AppColors.primaryBlue,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               print('Learn more clicked');
//                             },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
