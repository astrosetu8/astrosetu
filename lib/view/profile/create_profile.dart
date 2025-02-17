import 'package:astrosetu/view/profile/preview_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // For Date format

import '../../component/custom_button.dart';
import '../../component/myTextForm.dart';
import '../../utils/utils.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  final TextEditingController nameController = TextEditingController(); // For managing the name input
  String selectedGender = "";
  String name = "";
  String dateOfBirth = "";
  int currentIndex = 0;  // Track current page index

  // Select gender
  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  // Open date picker to choose date of birth
  Future<void> _selectDateOfBirth() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        dateOfBirth = DateFormat.yMd().format(selectedDate);  // Format the date
      });
    }
  }

  // Handle the submit action
  void handleSubmit() {
    if (name.isNotEmpty && selectedGender.isNotEmpty && dateOfBirth.isNotEmpty) {
      // Add your logic for form submission
      print("Name: $name");
      print("Gender: $selectedGender");
      print("Date of Birth: $dateOfBirth");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PreviewScreen(
                  name: name.toString(),
                  gender: selectedGender.toString(),
                  dateOfBirth: dateOfBirth)));

      // Navigate to the next screen or perform some action
    } else {
      // Show a message or handle invalid state
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please complete all fields")),
      );
    }
  }

  // Handle page change
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    // Dispose controllers and close the keyboard
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w), // ScreenUtil usage
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70.h),
              Text(
                "Step ${currentIndex + 1} of 3",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 30.h),

              // PageView for switching between questions
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  onPageChanged: onPageChanged, // Track page index change
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return _buildNameInput();
                      case 1:
                        return _buildGenderSelection();
                      case 2:
                        return _buildDateOfBirthSelection();
                      default:
                        return SizedBox();
                    }
                  },
                ),
              ),

              // Continue / Submit Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: currentIndex == 2 ? "Submit" : "Next", // Last page shows "Submit"
                  onPressed: () {
                    if (currentIndex == 2) {
                      handleSubmit();
                    } else {
                      if (_formKey.currentState!.validate()) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }

                    }
                  },
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }



  // Page 1: Name Input
  Widget _buildNameInput() {
    return Column(
      children: [
        const Text(
          "What’s your name?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        _buildNameField(),
        // TextFormField(
        //   controller: nameController,  // Using controller for text input
        //   onChanged: (value) {
        //     setState(() {
        //       name = value;
        //     });
        //   },
        //   decoration: InputDecoration(
        //     labelText: "What's your name?",
        //     border: OutlineInputBorder(),
        //     hintText: "Enter your name",
        //   ),
        //   textInputAction: TextInputAction.next, // Move to next field
        //   onFieldSubmitted: (_) {
        //     FocusScope.of(context).unfocus(); // Close the keyboard when submitting
        //     _pageController.nextPage(
        //       duration: Duration(milliseconds: 300),
        //       curve: Curves.ease,
        //     );
        //   },
        // ),
      ],
    );
  }

  // Page 2: Gender Selection
  Widget _buildGenderSelection() {
    return Column(
      children: [
        const Text(
          "What's your gender?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Male Circle
              Container(
                height: 0.4.sh,
                width: 0.9.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  border: Border.all(color: Color(0xff26283F), width: 2),
                ),
              ),
              // Female Circle
              Positioned(
                bottom: 5.h,
                right: 10.w,
                child: GestureDetector(
                  onTap: () => selectGender("Female"),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Color(0xff26283F), width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: selectedGender == "Female"
                          ? Color(0xff26283F)
                          : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female,
                            color: selectedGender == "Female"
                                ? Colors.white
                                : Colors.black,
                          ),
                          Text(
                            "Female",
                            style: TextStyle(
                              color: selectedGender == "Female"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Male Circle
              Positioned(
                top: 5.h,
                left: 10.w,
                child: GestureDetector(
                  onTap: () => selectGender("Male"),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Color(0xff26283F), width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: selectedGender == "Male"
                          ? Colors.black
                          : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.male,
                            color: selectedGender == "Male"
                                ? Colors.white
                                : Colors.black,
                          ),
                          Text(
                            "Male",
                            style: TextStyle(
                              color: selectedGender == "Male"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Page 3: Date of Birth Selection
  Widget _buildDateOfBirthSelection() {
    return Column(
      children: [
        Text(
          "What's your date of birth?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: _selectDateOfBirth,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xff26283F)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.calendar_today),
                SizedBox(width: 10.w),
                Text(
                  dateOfBirth.isEmpty ? "Select Date of Birth" : dateOfBirth,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildNameField() {
    return MyTextForm(
      label: "Name",
      controller: nameController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
            30), // Limit input to 10 digits for phone number
        FilteringTextInputFormatter.singleLineFormatter, // Allow only digits
      ],
      keyboardType: TextInputType.text, // Phone keyboard for easier input
      validator: true, // Enable validation
      validatorFunc: Utils.validateUserName(),
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
    );
  }
}
