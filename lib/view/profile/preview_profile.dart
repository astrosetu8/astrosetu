import 'dart:convert';
import 'dart:io';

import 'package:astrosetu/provider/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../component/custom_button.dart';
import '../../component/myTextForm.dart';
import '../../component/zodiac_sign.dart';
import '../../route/pageroute.dart';
import '../../utils/utils.dart';

class PreviewScreen extends StatefulWidget {
  final String name;
  final String gender;
  final String dateOfBirth;

  const PreviewScreen({
    required this.name,
    required this.gender,
    required this.dateOfBirth,
  });

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? zodiacSignName;
  var isLoading = false;
  File? _image;
  final imagePicker = ImagePicker();
  String? userImage = '';
  var isRemarkEnabled = true;
  var selfiImgBase64 = '';
  var selfiImg = '';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _genderController.text = widget.gender;
    _dobController.text = widget.dateOfBirth;
    zodiacSign(name: widget.name);
  }
   zodiacSign({required String name}){
     zodiacSignName = getZodiacSign(name);
     print("Your zodiac sign is: $zodiacSign");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leadingWidth: 70,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Make the entire body scrollable
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoading) {
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ProfileLoaded) {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePath.bottomNavigation,
                    );
              } else if (state is ProfileError) {
                Navigator.pop(context);
                print("error message ${state.message}");
                Utils.snackbarToast(state.message);
              }
            },
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _image == null
                        ? GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    // top: 10.h,
                                    right: 20.w,
                                    left: 20.w,
                                    bottom: 10.h), // Using ScreenUtil
                                child: CircleAvatar(
                                    radius: 0.20.sw, // 25% of screen width
                                    backgroundColor: Colors.grey.shade800,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: 0.15.sw,
                                    ))))
                        : GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20.h,
                                    right: 20.w,
                                    left: 20.w,
                                    bottom: 10.h), // Using ScreenUtil
                                child: CircleAvatar(
                                    radius: 0.25.sw, // 25% of screen width
                                    backgroundColor: Colors.grey.shade800,
                                    backgroundImage: FileImage(
                                      _image!,
                                    ))),
                          ),
                    Text(
                      "HELLO ${widget.name}!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp),
                    ),
                    Text(
                      "Your zodic sign is ${zodiacSignName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp),
                    )
                  ],
                ),
                SizedBox(height: 20.h),

                // Editable Name TextField
                _buildNameField(),
                SizedBox(height: 10.h),

                // Editable Gender TextField
                _buildGenderField(),

                SizedBox(height: 10.h),

                // Editable Date of Birth TextField
                _buildDateOfBirthField(),

                SizedBox(height: 20.h),

                // Continue Button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    text: "Continue",
                    onPressed: () {
                      // Handle the continue action here
                      String name = _nameController.text;
                      String gender = _genderController.text;
                      String dateOfBirth = _dobController.text;
                      BlocProvider.of<ProfileBloc>(context).add(
                          UpdateProfileEvent(
                           //   filePath: _image.toString(),
                              name: name,
                              gender: gender,
                              dob: dateOfBirth));
                      // You can process the data or navigate to the next screen
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return MyTextForm(
      label: "Name",
      controller: _nameController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
            30), // Limit input to 10 digits for phone number
        FilteringTextInputFormatter.singleLineFormatter, // Allow only digits
      ],
      keyboardType: TextInputType.text, // Phone keyboard for easier input
      validator: true, // Enable validation
      validatorFunc: Utils.validateUserName(),
      onChanged: (value) {},
    );
  }

  Widget _buildGenderField() {
    return MyTextForm(
      label: "Gender",
      controller: _genderController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
            30), // Limit input to 10 digits for phone number
        FilteringTextInputFormatter.singleLineFormatter, // Allow only digits
      ],
      keyboardType: TextInputType.text, // Phone keyboard for easier input
      validator: true, // Enable validation
      validatorLabel: "gender",
      // validatorFunc: Utils.validateUserName(),
      onChanged: (value) {},
    );
  }

  Widget _buildDateOfBirthField() {
    return MyTextForm(
      label: "Date of Birth",
      controller: _dobController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
            15), // Limit input to 10 digits for phone number
        FilteringTextInputFormatter.singleLineFormatter, // Allow only digits
      ],
      keyboardType: TextInputType.phone, // Phone keyboard for easier input
      validator: true, // Enable validation
      validatorLabel: "gender",
      // validatorFunc: Utils.validateUserName(),
      onChanged: (value) {},
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (BuildContext) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w), // Using ScreenUtil for padding
              child: Wrap(children: [
                const Text('Upload Selfie',
                    textScaleFactor: 1.0, textAlign: TextAlign.start),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: <Widget>[
                    // Camera option icon
                    InkWell(
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 60.w,
                        child: Wrap(
                          children: [
                            Icon(Icons.camera_alt_outlined, size: 50.sp),
                            const Text('Camera')
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w), // Using ScreenUtil for spacing
                    // Gallery option icon
                    InkWell(
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 60.w,
                        child: Wrap(
                          children: [
                            Icon(Icons.image_outlined, size: 50.sp),
                            const Text('Gallery')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          );
        });
  }

  // Get image from camera
  _imgFromCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);

        final bytes = _image?.readAsBytesSync();
        selfiImgBase64 = base64Encode(bytes!);
      });
    }
  }

  // Get image from gallery
  _imgFromGallery() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);

        final bytes = _image?.readAsBytesSync();
        selfiImgBase64 = base64Encode(bytes!);
      });
    }
  }
}
