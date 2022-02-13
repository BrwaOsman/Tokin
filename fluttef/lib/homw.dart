// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_final_fields, avoid_print, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttef/model/User_model.dart';
import 'package:fluttef/notification.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> saveTokenToDatabase(String token) async {
//   // Assume user is logged in for this example
//   String userId = FirebaseAuth.instance.currentUser!.uid;

//   await FirebaseFirestore.instance
//     .collection('users')
//     .doc(userId)
//     .update({
//       'tokens': FieldValue.arrayUnion([token]),
//     });
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  Notification_Android _notification = Notification_Android();
  String? _token;
  @override
  void initState() {
    super.initState();
    _fcm.getToken().then((token) {
      print(token);
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamed(context,'/');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _fcm.subscribeToTopic('all');
        
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> _docs = snapshot.data!.docs;
                List<User_model> _users = _docs
                    .map((e) =>
                        User_model.fromMap(e.data() as Map<String, dynamic>))
                    .toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                        send_notification(context, _users, index);
                      
                        
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "${_users[index].token}",
                              maxLines: 2,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Text('Loading...');
              }
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> send_notification(BuildContext context, List<User_model> _users, int index) {
    return showDialog(context: context, builder: (context) => AlertDialog(
                        title: Text('Send Notification'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _title,
                              decoration: InputDecoration(
                                labelText: 'Title',
                              ),
                              
                            ),
                            TextField(
                              controller: _body,
                              decoration: InputDecoration(
                                labelText: 'Body',
                              ),
                             
                            ),
                          ],
                        ),
                        

                        actions: [
                          FlatButton(
                            child: Text('send'),
                            onPressed: () {
                             _notification.test_notification(1, _title.text, _body.text);
                              Navigator.pop(context);
                            },
                          ),
                           FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ));
  }

 
}
