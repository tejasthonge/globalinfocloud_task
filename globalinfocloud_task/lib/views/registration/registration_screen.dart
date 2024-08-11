import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:globalinfocloud_task/models/customer.dart';
import 'package:globalinfocloud_task/providers/registration_provider.dart';
import 'package:globalinfocloud_task/utils/widget_comman.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _countryCode = "91";
  String _contryLogo = "🇮🇳";
  File? _addressProofImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _addressProofImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _extractTextFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    // ignore: deprecated_member_use
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    log("--------------------------------");
    log("Recognized text: ${recognizedText.text}");
    log("--------------------------------");
    return recognizedText.text;
  }

  Future<bool> _validateCityAndPinCode(
      String city, String pinCode, File image) async {
    log("validate city and pin code");
    final extractedText = await _extractTextFromImage(image);
    return extractedText.toLowerCase().contains(city.toLowerCase()) ||
        extractedText.contains(pinCode);
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (_addressProofImage == null) {

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select an address proof document.')));
        return;
      }

      final isValid = await _validateCityAndPinCode(
          _cityController.text, _pinCodeController.text, _addressProofImage!);
      if (isValid) {
        log("Address proof document is valid");
       
        final registrationController =
            Provider.of<RegistrationProvider>(context, listen: false);
        await registrationController.registerCustomer(
            context,
            Customer(
                name: _nameController.text.trim(),
                contactNumber: "+$_countryCode${_contactController.text.trim()}",
                email: _emailController.text.trim(),
                pinCode: _pinCodeController.text.trim(),
                state: _stateController.text.trim(),
                city: _cityController.text.trim(),
                address: _addressController.text.trim(),
                password: _passwordController.text.trim(),
                addressProofPath: _addressProofImage!.path));
        // Proceed with registration
        // Call registration logic here
      } else {
        // Show error: City and pin code do not match the image
          getMySnakBar(context: context, masage: "City and Pin Code do not match the address proof document.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.number,
                scrollPadding: const EdgeInsets.only(left: 10, top: 1, bottom: 1),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 15.0,right: 10),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true, // Display the phone code
                            countryListTheme:const CountryListThemeData(
                              flagSize: 25, 
                              backgroundColor:
                                  Colors.white, 
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black),
                              bottomSheetHeight: 500, 

                              padding: EdgeInsets.only(top: 10),

                              searchTextStyle: TextStyle(fontSize: 18),
                            ),
                            onSelect: (Country country) {
                              // Print selected country information
                              setState(() {
                                _countryCode = country.phoneCode;
                                _contryLogo = country.flagEmoji;
                              });
                              print(
                                  'Selected country: ${country.displayName} (${country.phoneCode})');
                              print('Country Code: ${country.countryCode}');
                              // You can use country.countryCode, country.phoneCode, country.flagEmoji, etc.
                            },
                          );
                        },
                        child: Text(
                          "+$_countryCode $_contryLogo",
                        ),
                      ),
                    ),
                    labelText: 'Enter Phone Number',
                    // border: OutlineInputBorder()
                    
                    ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your contact number' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email ID'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                controller: _pinCodeController,
                decoration: const InputDecoration(labelText: 'Pin Code'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your pin code' : null,
              ),
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(labelText: 'State'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your state' : null,
              ),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your city' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your address' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a password' : null,
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _pickImage,
                child: const Text('Upload Address Proof'),
              ),
              _addressProofImage == null
                  ? const Text('No image selected.')
                  : Image.file(_addressProofImage!),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
