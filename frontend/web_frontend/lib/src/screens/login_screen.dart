import 'package:flutter/material.dart';
import 'package:web_frontend/src/components/appbar.dart';
import "../controller/authentication.dart";

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool error = false;
  String errorMessage = '';
  // ignore: non_constant_identifier_names
  Future<void> handel_login(BuildContext context) async {
    bool response =
        await login({'username': username, 'password': password}, context);
    if (response) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(context,
          // index: 3,
          title: "Login"),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your username';
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
                        return 'Please enter your password';
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
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Form is valid, you can perform login logic here.
                        // Access the username and password using the variables you declared earlier.
                        // print('Username: $username');
                        // print('Password: $password');

                        // TODO
                        // send username and password to api , in file controller / authentication.dart
                        // if success
                        // save token in shared preferences
                        // Navigator.pushNamed(context, '/home');
                        // else
                        // show error message
                        handel_login(context);
                        // call login api
                        // cache token
                        // Navigator.pushNamed(context, '/home');

                        // You can add authentication logic here, such as checking credentials.
                      }
                    },
                    child: Text('Login'),
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
