// ignore_for_file: prefer_const_constructors

import 'package:fluttef/notification.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({ Key? key }) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}


class _UsersState extends State<Users> {

  Notification_Android notification_Android = new Notification_Android();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    notification_Android.show_notification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Users'),
      ),
    
    );
  }
}