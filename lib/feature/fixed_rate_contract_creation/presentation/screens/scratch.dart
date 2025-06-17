// import 'package:flutter/material.dart';

// // Import your step widgets (we'll create them below)
// // import 'steps/step_1_select_type.dart';
// // import 'steps/step_2_details.dart';

// class CreateContractScreen extends StatefulWidget {
//   const CreateContractScreen({super.key});

//   @override
//   State<CreateContractScreen> createState() => _CreateContractScreenState();
// }

// class _CreateContractScreenState extends State<CreateContractScreen> {
//   // --- STATE MANAGEMENT ---
//   late final PageController _pageController;
//   int _currentStepIndex = 0;
//   final List<CreateContractStep> _steps = CreateContractStep.values;

//   // --- FORM DATA ---
//   // All the data collected from the forms lives here
//   String? selectedContractType;
//   String? contractTitle;
//   // ... add all other form fields here

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   // --- UI HELPER GETTERS ---
//   String get _appBarTitle {
//     switch (_steps[_currentStepIndex]) {
//       case CreateContractStep.selectType:
//         return 'Create a contract';
//       case CreateContractStep.details:
//         return 'Contract Details';
//       case CreateContractStep.workScope:
//         return 'Work Scope';
//       // ... add cases for all other steps
//       default:
//         return 'Create a contract';
//     }
//   }

//   String get _progressText => '${_currentStepIndex + 1}/${_steps.length}';

//   // --- LOGIC / ACTIONS ---
//   void _nextStep() {
//     // Basic validation could go here before proceeding
//     if (_currentStepIndex < _steps.length - 1) {
//       // Use setState to rebuild the AppBar with the new title and progress
//       setState(() {
//         _currentStepIndex++;
//       });
//       // Animate the PageView to the next page
//       _pageController.animateToPage(
//         _currentStepIndex,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } else {
//       // Logic for the final step
//       _submitContract();
//     }
//   }

//   void _previousStep() {
//     if (_currentStepIndex > 0) {
//       setState(() {
//         _currentStepIndex--;
//       });
//       _pageController.animateToPage(
//         _currentStepIndex,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     } else {
//       // If on the first step, pop the screen
//       Navigator.of(context).pop();
//     }
//   }

//   void _submitContract() {
//     // Use the collected data: selectedContractType, contractTitle, etc.
//     print('Submitting contract...');
//     print('Type: $selectedContractType');
//     print('Title: $contractTitle');
//   }

//   // --- THE UI ---
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: _previousStep,
//         ),
//         title: Text(
//           _appBarTitle,
//           style: const TextStyle(color: Colors.black),
//         ),
//         actions: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Text(
//                 _progressText,
//                 style: const TextStyle(
//                     color: Colors.purple, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: PageView(
//         controller: _pageController,
//         // Disable direct swiping by the user
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           // Pass callbacks to the step widgets to update the state
//           Step1SelectType(
//             onTypeSelected: (type) {
//               setState(() {
//                 selectedContractType = type;
//               });
//             },
//           ),
//           Step2Details(
//             onTitleChanged: (title) {
//               setState(() {
//                 contractTitle = title;
//               });
//             },
//           ),
//           // Step3WorkScope(...),
//           // ... etc. for all 7 steps
//         ],
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: ElevatedButton(
//           onPressed: _nextStep,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.purple,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//           ),
//           child: const Text('Continue'),
//         ),
//       ),
//     );
//   }
// }
