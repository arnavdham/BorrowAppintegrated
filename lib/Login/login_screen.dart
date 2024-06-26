import 'package:borrow/screens/fpass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'borrow_screeen.dart';
import 'package:http/http.dart' as http;
import 'register_screen.dart';
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                    'Log in to your Account',
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
                    controller: _usernameController,
                    decoration: InputDecoration(
                        labelText: 'Username',
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
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
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
                      Login loginData=Login(
                        username: _usernameController.text,
                        password: _passwordController.text
                      );
                      sendLoginData(loginData);
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
                    child: Text('Login'),
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
                            fpassScreen()),
                      );
                    },
                    child: Text("Forgot Password"),
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



  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  //     if (gUser == null) {
  //       // User canceled the sign-in
  //       return null;
  //     }
  //
  //     final GoogleSignInAuthentication gAuth = await gUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: gAuth.accessToken,
  //       idToken: gAuth.idToken,
  //     );
  //
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     User? user = userCredential.user;
  //     if (user != null) {
  //       await addUserToFirestore(user);
  //     }
  //
  //     return user;
  //   } catch (error) {
  //     // Handle and log the error
  //     print("Error signing in with Google: $error");
  //     return null;
  //   }
  // }
  //
  // Future<void> addUserToFirestore(User user) async {
  //   try {
  //     String uid = user.uid;
  //     String email = user.email ?? "";
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  //     await firestore.collection('users').doc(uid).set({
  //       'email': email,
  //       'uid': uid,
  //     });
  //   } catch (error) {
  //     print("Error adding user to Firestore: $error");
  //   }
  // }

//   void login(String username, String password) async {
//     var request = http.Request('POST', Uri.parse('https://13.232.61.146/login'));
//     request.body = '''{"username":"$username","password":"$password"}''';
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(request.body);
//       print(response.reasonPhrase);
//     }
//   }
// }
//model
class Login {
  String? username;
  String? password;

  Login({this.username, this.password});

  Login.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

//view model
Future<void> sendLoginData(Login loginData) async {
  // Define the URL where you want to send the POST request
  String apiUrl = 'http://13.232.61.146/login'; // Replace with your API endpoint

  // Convert the login object to JSON
  Map<String, dynamic> jsonData = loginData.toJson();
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
