import 'package:borrow/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'borrow_screeen.dart';
import 'package:http/http.dart' as http;
import 'register_screen.dart';
import 'dart:convert';

class fpassScreen extends StatelessWidget {
  TextEditingController _oldpasswordController = TextEditingController();
  TextEditingController _newpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/final.jpg',
                    width: 200.0,
                    height: 200.0,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'BORROW',
                    style: TextStyle(
                      fontFamily: 'EuphoriaScript',
                      color: Colors.white,
                      fontSize: 50.0,
                    ),
                  ),
                  const SizedBox(
                    height: 150.0,
                  ),
                  const Text(
                    'Change your Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  //two new text field
                  TextField(
                    controller: _oldpasswordController,
                    decoration: InputDecoration(
                        labelText: 'Old password',
                        labelStyle:
                        TextStyle(color: Colors.white, fontSize: 15.0),
                        filled: true,
                        fillColor: Color(0xFF0A2647),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xFF144272),
                            ))),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: _newpasswordController,
                    decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle:
                        TextStyle(color: Colors.white, fontSize: 15.0),
                        filled: true,
                        fillColor: Color(0xFF0A2647),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Color(0xFF144272),
                            ))),
                    style: TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Changepass changepass=Changepass(
                          oldPassword: _oldpasswordController.text,
                          newPassword: _newpasswordController.text
                      );
                      changepassfinal(changepass);
                    },
                    // onPressed: () async {
                    //   final user = await signInWithGoogle();
                    //   if (user != null) {
                    //     Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return BorrowScreen();
                    //         },
                    //       ),
                    //     );
                    //   } else {}
                    // },
                    child: Text('Change'),
                    //child: Text('Sign in with Google'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            RegisterScreen()),
                      );
                    },
                    child: Text("Register"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            LoginScreen()),
                      );
                    },
                    child: Text("Login"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//model
class Changepass {
  String? oldPassword;
  String? newPassword;

  Changepass({this.oldPassword, this.newPassword});

  Changepass.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['old_password'] = this.oldPassword;
    data['new_password'] = this.newPassword;
    return data;
  }
}

//view model
Future<void> changepassfinal(Changepass changepass) async {
  // Define the URL where you want to send the POST request
  String apiUrl = 'http://13.232.61.146/loggedin/resetpass'; // Replace with your API endpoint

  // Convert the login object to JSON
  Map<String, dynamic> jsonData = changepass.toJson();
  String jsonBody = jsonEncode(jsonData);

  try {
    // Send the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print(response.body); // This will contain the response from the server
    } else {
      print('POST request failed with status code: ${response.statusCode}');
      print(response.body); // This will contain the error message from the server
    }
  } catch (e) {
    print('Error sending POST request: $e');
  }
}
