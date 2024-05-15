import 'package:flutter/material.dart';
import 'package:web_frontend/src/controller/user.dart';
import 'package:web_frontend/src/models/user.dart';
import '../controller/authentication.dart';
import '../components/appbar.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late User user;
  late bool isLogged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  Future<void> check_login() async {
    user = await get_user();
    if (user.userId == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      setState(() {
        isLogged = true;
      });
    }
  }

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

  Future<void> updateUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Add your update user logic here
      await updateUserData(user.toJson(), context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_login();
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged == false)
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Text('Please Login'),
        ),
      );
    else
      return Scaffold(
        appBar: AppBarComponent(
          context,
          index: 5,
          title: "Profile",
        ),
        // appBar: AppBar(
        //   title: Text('Profile'),
        // ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Username: " + user.username!),
                  Text('Email: ' + user.email!),
                  // Text("first Nmae: " + user.firstName!),
                  TextFormField(
                    initialValue: user.firstName,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    onSaved: (value) => user.firstName = value,
                  ),
                  // Text("last Name: " + user.lastName!),
                  TextFormField(
                    initialValue: user.lastName,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    onSaved: (value) => user.lastName = value,
                  ),
                  TextFormField(
                    initialValue: user.birthOfDate,
                    decoration: const InputDecoration(labelText: 'Birth Date'),
                    onSaved: (value) => user.birthOfDate = value,
                  ),
                  TextFormField(
                    initialValue: user.city,
                    decoration: const InputDecoration(labelText: 'City'),
                    onSaved: (value) => user.city = value,
                  ),
                  TextFormField(
                    initialValue: user.address,
                    decoration: const InputDecoration(labelText: 'Address'),
                    onSaved: (value) => user.address = value,
                  ),
                  // Text("Gender: " + user.gender!),
                  TextFormField(
                    initialValue: user.gender,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    onSaved: (value) => user.gender = value,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await updateUser(context);
                    },
                    child: const Text('Update Profile'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/tickets');
                    },
                    child: const Text('My tickets'),
                  ),
                  TextButton(
                      onPressed: () async {
                        // logout(),
                        // declare token and user from the shared preferences
                        await logout();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text('Logout'))
                ],
              ),
            ),
          ),
        ),
      );
  }
}
