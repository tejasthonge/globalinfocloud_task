import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactNumberController = TextEditingController();
  final _passwordController = TextEditingController();
    String _countryCode = "91";
  String _contryLogo = "🇮🇳";
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {


      final contactNumber = "+$_countryCode${_contactNumberController.text.trim()}";
      final password = _passwordController.text.trim();

      await Provider.of<LoginProvider>(context, listen: false)
          .loginCustomer(contactNumber, password ,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _contactNumberController,
                keyboardType: TextInputType.number,
                scrollPadding: EdgeInsets.only(left: 10, top: 1, bottom: 1),
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
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
