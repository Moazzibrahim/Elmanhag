// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controller/Auth/sign_up_provider.dart';
// import 'package:flutter_application_1/models/sign_up_model.dart';
// import 'package:flutter_application_1/views/widgets/progress_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/constants/colors.dart';
// import 'package:flutter_application_1/controller/Auth/country_provider.dart';
// import 'package:flutter_application_1/views/widgets/text_field.dart';

// class ThirdSignUp extends StatefulWidget {
//   final String name;
//   final String email;
//   final String phone;
//   final String countryId;
//   final String cityId;
//   final String categoryId;
//   final String educationId;
//   final String jobId; // Add this

//   const ThirdSignUp({
//     super.key,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.countryId,
//     required this.cityId,
//     required this.categoryId,
//     required this.educationId,
//     required this.jobId, // Add this
//   });

//   @override
//   _ThirdSignUpState createState() => _ThirdSignUpState();
// }

// class _ThirdSignUpState extends State<ThirdSignUp> {
//   final TextEditingController _parentNameController = TextEditingController();
//   final TextEditingController _parentPhoneController = TextEditingController();
//   final TextEditingController _parentEmailController = TextEditingController();
//   final TextEditingController _parentPasswordController =
//       TextEditingController();
//   final TextEditingController _parentConfirmPasswordController =
//       TextEditingController();
//   final TextEditingController _affilateController = TextEditingController();

//   String? selectedParentRelation;
//   List<ParentRelation> parentRelations = [];
//   final _formKey =
//       GlobalKey<FormState>(); // Add a global key for the Form widget

//   // Create a FocusNode for the parent phone text field
//   final FocusNode _parentPhoneFocusNode = FocusNode();
//   final FocusNode _parentEmailFocusNode = FocusNode();

//   bool _showPhoneHint = false; // State variable to toggle hint display
//   bool _showEmailHint = false; // State variable to toggle email hint display

//   @override
//   void initState() {
//     super.initState();

//     final dataProvider = Provider.of<DataProvider>(context, listen: false);
//     dataProvider.fetchData(context).then((_) {
//       setState(() {
//         parentRelations = dataProvider.dataModel?.parentRelations ?? [];
//       });
//     });

//     // Add listener to update parent email when parent phone changes
//     _parentPhoneController.addListener(() {
//       final parentPhone = _parentPhoneController.text;
//       if (parentPhone.isNotEmpty && parentPhone.length == 11) {
//         _parentEmailController.text = "$parentPhone@elmanhag.com";
//       }
//     });

//     _parentPhoneFocusNode.addListener(() {
//       setState(() {
//         _showPhoneHint = _parentPhoneFocusNode.hasFocus;
//       });
//     });

//     _parentEmailFocusNode.addListener(() {
//       setState(() {
//         _showEmailHint = _parentEmailFocusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _parentPhoneController.dispose();
//     _parentEmailController.dispose();
//     _parentNameController.dispose();
//     _parentPasswordController.dispose();
//     _parentConfirmPasswordController.dispose();
//     _affilateController.dispose();
//     _parentPhoneFocusNode.dispose(); // Don't forget to dispose the FocusNode
//     _parentEmailFocusNode.dispose(); // Dispose the FocusNode

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'انشاء حساب',
//           style: TextStyle(fontWeight: FontWeight.bold, color: redcolor),
//         ),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: redcolor),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const ProgressCircles(currentScreen: 3),
//               const SizedBox(height: 15),
//               const Text(
//                 'أهلا بك معنا',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               buildTextFormField(
//                 controller: _parentNameController,
//                 labelText: 'اسم ولي الامر',
//                 prefixIcon: const Icon(Icons.person, color: redcolor),
//               ),
//               const SizedBox(height: 15),

//               // Parent Phone TextField with hint functionality
//               buildTextFormField(
//                 controller: _parentPhoneController,
//                 labelText: 'رقم هاتف ولي الامر',
//                 prefixIcon: const Icon(Icons.phone, color: redcolor),
//                 focusNode: _parentPhoneFocusNode, // Attach the FocusNode
//                 hintText: _showPhoneHint
//                     ? 'الرجاء إدخال رقم هاتف مختلف عن رقم الطالب'
//                     : null, // Conditionally show hint
//                 validator: (value) {
//                   final RegExp phoneRegExp = RegExp(r'^[0-9]{11}$');
//                   if (value == null || value.isEmpty) {
//                     return 'رقم الهاتف مطلوب';
//                   } else if (!phoneRegExp.hasMatch(value)) {
//                     return 'رقم الهاتف يجب أن يتكون من 11 رقماً';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 15),
//               buildTextFormField(
//                 controller: _parentEmailController,
//                 labelText: 'ايميل ولي الامر',
//                 prefixIcon: const Icon(Icons.email, color: redcolor),
//                 focusNode: _parentEmailFocusNode, // Attach the FocusNode
//                 hintText: _showEmailHint
//                     ? 'الرجاء إدخال ايميل مختلف عن ايميل الطالب'
//                     : null, // Conditionally show hint
//                 textdirection: TextDirection.ltr, // Make the email LTR
//                 validator: (value) {
//                   final RegExp emailRegExp =
//                       RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[cC][oO][mM]$");
//                   if (value == null || value.isEmpty) {
//                     return 'البريد الإلكتروني مطلوب';
//                   } else if (!emailRegExp.hasMatch(value)) {
//                     return 'البريد الإلكتروني غير صحيح';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 15),
//               PasswordField(
//                 controller: _parentPasswordController,
//                 labelText: "الرقم السري",
//               ),
//               const SizedBox(height: 15),
//               PasswordField(
//                 controller: _parentConfirmPasswordController,
//                 labelText: "تاكيد الرقم السري",
//               ),
//               const SizedBox(height: 15),
//               DropdownButtonFormField<String>(
//                 value: selectedParentRelation,
//                 items: parentRelations.map((ParentRelation relation) {
//                   return DropdownMenuItem<String>(
//                     value: relation.id.toString(),
//                     child: Text(relation.name),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'قرابة ولي الامر',
//                   prefixIcon: const Icon(Icons.person, color: redcolor),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: redcolor),
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: redcolor),
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                 ),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedParentRelation = newValue;
//                   });
//                 },
//                 validator: (value) =>
//                     value == null ? 'Please select a parent relation' : null,
//               ),
//               const SizedBox(height: 15),
//               buildTextFormField(
//                 controller: _affilateController,
//                 labelText: ' كود التسويق التابع له',
//                 prefixIcon: const Icon(Icons.code, color: redcolor),
//               ),
//               const SizedBox(height: 30),
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pop(); // Go back to the previous screen
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             redcolor, // Set a different color for the back button
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 50, vertical: 15),
//                         textStyle: const TextStyle(fontSize: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'رجوع',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState?.validate() ?? false) {
//                           if (_parentPasswordController.text !=
//                               _parentConfirmPasswordController.text) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('كلمتا السر غير متطابقتين'),
//                                 backgroundColor: redcolor,
//                               ),
//                             );
//                           } else if (_parentPhoneController.text ==
//                               widget.phone) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                     'رقم هاتف ولي الامر يجب أن يكون مختلفاً عن رقم الطالب'),
//                                 backgroundColor: redcolor,
//                               ),
//                             );
//                           } else if (_parentEmailController.text ==
//                               widget.email) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                     'ايميل ولي الامر يجب أن يكون مختلفاً عن ايميل الطالب'),
//                                 backgroundColor: redcolor,
//                               ),
//                             );
//                           } else {
//                             await ApiService.signUp(
//                               name: widget.name,
//                               email: widget.email,
//                               phone: widget.phone,
//                               selectedCountryId: widget.countryId,
//                               selectedCityId: widget.cityId,
//                               selectedCategoryId: widget.categoryId,
//                               selectedEducationId: widget.educationId,
//                               parentname: _parentNameController.text,
//                               parentemail: _parentEmailController.text,
//                               parentpassword: _parentPasswordController.text,
//                               parentphone: _parentPhoneController.text,
//                               selectedparentrealtionId: selectedParentRelation,
//                               jobId: widget.jobId, // Pass jobId
//                               affilateCode:
//                                   _affilateController.text, // Pass affilateCode
//                               context: context,
//                             );
//                           }
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: redcolor,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 50, vertical: 15),
//                         textStyle: const TextStyle(fontSize: 18),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Text(
//                         'التالي',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildTextFormField({
//     required TextEditingController controller,
//     required String labelText,
//     String? hintText,
//     required Icon prefixIcon,
//     FocusNode? focusNode,
//     TextDirection? textdirection,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       focusNode: focusNode,
//       textDirection: textdirection,
//       decoration: InputDecoration(
//         labelText: labelText,
//         hintText: hintText, // Hint text will show when available
//         prefixIcon: prefixIcon,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: redcolor),
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: redcolor),
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//       ),
//       validator: validator,
//     );
//   }
// }
