import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';
import "../controller/authentication.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String birthDate = '';
  String gender = '';
  String city = '';
  String address = '';
  String email = '';
  String role = '';

  DateTime? selectedDate;
  TextEditingController birthdayController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdayController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format the date as needed
      });
    }
  }

  // }
  // call the api and if success go to the home
  // ignore: non_constant_identifier_names
  Future<void> handel_signUp(BuildContext context) async {
    // send all data to the api
    bool response = await signUp({
      'username': username,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'birth_of_date': birthDate,
      'gender': gender,
      'city': city,
      'address': address,
      'email': email,
      'role': role,
    }, context);
    // if (response) {
    //   Navigator.pushNamed(context, '/home');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context, title: "Sign Up"),
      body: Center(
        child: SingleChildScrollView(
          // physics: ,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.4,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a username';
                      }
                      // Add more validation logic here if needed.
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a password';
                      }
                      // Add more validation logic here if needed.
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(labelText: 'Birth Date'),
                  //   validator: (value) {
                  //     if (value?.isEmpty ?? true) {
                  //       return 'Please enter your birth date';
                  //     }
                  //     // Add more validation logic here if needed.
                  //     return null;
                  //   },
                  //   onChanged: (value) {
                  //     setState(() {
                  //       birthDate = value;
                  //     });
                  //   },
                  // ),

                  // ListTile(
                  //   title: Text('Birthday'),
                  //   subtitle: Text(
                  //       birthDate.isEmpty ? 'Select your birthday' : birthDate),
                  //   onTap: () {
                  //     _selectDate(context);
                  //   },
                  // ),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Birthday',
                      hintText: 'Select your birthday',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                    controller: birthdayController,
                    readOnly: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please select your birthday';
                      }
                      birthDate = value!;
                      return null;
                    },
                  ),

                  TextFormField(
                    decoration: InputDecoration(labelText: 'Gender'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your gender';
                      }

                      // Add more validation logic here if needed.
                      // Check if the entered value is either 'Male' or 'Female'
                      if (value != 'male' && value != 'female') {
                        return 'Please enter either "Male" or "Female"';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'City'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Address (Optional)'),
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email Address'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email address';
                      }
                      // Add email validation logic here if needed.
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Role: manager/ fan'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your role';
                      }
                      // Check if the entered value is either 'Male' or 'Female'
                      if (value != 'manager' && value != 'fan') {
                        return 'Please enter either "manager" or "fan"';
                      }
                      // Add role validation logic here if needed.
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        role = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, you can process the data here.
                        // For example, send it to an API or save it locally.
                        // You can access the form values using the variables you declared earlier.
                        print('Username: $username');
                        print('Password: $password');
                        print('First Name: $firstName');
                        print('Last Name: $lastName');
                        print('Birth Date: $birthDate');
                        print('Gender: $gender');
                        print('City: $city');
                        print('Address: $address');
                        print('Email Address: $email');
                        print('Role: $role');
                        handel_signUp(context);
                        // TODO Call SIGN UP API
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
