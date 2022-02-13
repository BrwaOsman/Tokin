// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttef/server/server_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/User_model.dart';
import '../notification.dart';

class Login_system extends StatefulWidget {
  const Login_system({Key? key}) : super(key: key);

  @override
  _Login_systemState createState() => _Login_systemState();
}

class _Login_systemState extends State<Login_system> {
  Server_auth _server_auth = Server_auth();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isChecked = false;
  String email = "";
  String password = "";
Notification_Android _notification_android = Notification_Android();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  String? _token;
  @override
  void initState() {
    super.initState();
    _fcm.getToken().then((token) {
      print(token);
      _token = token;
    });
     _notification_android.show_notification( context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
                  "LOGIN ",
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              testField(
                "Email",
                _email,
                false,
                RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]"),
                "email",
              ),
              testField("Password", _password, true, RegExp(r'^.{6,}$'),
                  "Password(Min. 6 Character)"),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        password = _password.value.text;
                        email = _email.value.text;
                      });
                      email = email.trim(); //remove spaces
                      email = email.toLowerCase();
                      // await Provider.of<Server_auth>(context, listen: false)
                      //     .login_sytelm(email, password);
                      login_sytelm(email, password);
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 65, right: 65),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" if you don't have an account"),
                  TextButton(
                      onPressed: () {
                        addUser();
                        Navigator.pushNamed(context, '/users');
                      },
                      child: Text(
                        "Anonymously",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding testField(String name, TextEditingController _controller, bool _obs,
      RegExp regex, String validate) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _controller,
        obscureText: _obs,
        decoration: InputDecoration(
          hintText: 'Enter your $name.',
          label: Text("Enter you $name"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your $name");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid $validate");
          }

          return null;
        },
      ),
    );
  }

  Future addUser() async {
    await _auth.signInAnonymously();

    User_model user = User_model(
      id: _auth.currentUser!.uid,
      token: _token,
    );

    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set(user.toMap());
  }
  
  Future<UserCredential> login_sytelm(String email, String password) async {
    UserCredential login = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    // setTheUser(login.user);

    return login;
  }
}
