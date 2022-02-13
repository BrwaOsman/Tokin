// ignore_for_file: camel_case_types, unused_field, non_constant_identifier_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Server_auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? theUser = FirebaseAuth.instance.currentUser;


  void setTheUser(User? user) {
    theUser = user;
    notifyListeners();
  }

  Future<UserCredential> register_sytelm(String email, String password) async {
    UserCredential register = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User? user = register.user;
    setTheUser(register.user);
    return register;
  }

  Future<UserCredential> login_sytelm(String email, String password) async {
    UserCredential login = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    setTheUser(login.user);

    return login;
  }

  // Future singinDemo() async {
  //   try {
  //     final UserCredential authResult = await _auth.signInAnonymously();
  //     final User? user = authResult.user;

  //     return User_id(userId: user!.uid);
  //   } catch (e) {
  //     print(e);
  //     print("object");
  //     return null;
  //   }
  // }

  Future logout_system() async {
    await FirebaseAuth.instance.signOut();
     setTheUser(null);

  }

  Stream<User?> get authStatusChanges => _auth.authStateChanges();
}
