import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SideBarViewModel extends ChangeNotifier {
  SideBarViewModel();
  String userEmail=FirebaseAuth.instance.currentUser!.email.toString();

  Future<String?> getUserPhoto() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signInSilently();
    if (user != null) {
      final GoogleSignInAuthentication googleAuth = await user.authentication;
      final String photoUrl = user.photoUrl ?? '';
      return photoUrl;
    }
  }

  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
    // Notify listeners about the change in state after sign out
    notifyListeners();
  }
}
