// ignore_for_file: prefer_const_constructors

import 'package:fluttef/homw.dart';
import 'package:fluttef/notification.dart';
import 'package:fluttef/page/loging.dart';
import 'package:fluttef/page/test.dart';
import 'package:fluttef/page/users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




Future<void> _onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Notification_Android _notification_android = Notification_Android();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   FirebaseMessaging.onBackgroundMessage( _onBackgroundMessage);
  await _notification_android.mesngerss_notification();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
     
   initialRoute: '/',
      routes: {
        '/login': (context) => Login_system(),
        '/home': (context) => Home(),
        '/users': (context) => Users(),
        '/': (context) => Test(),
        
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _notification_android.show_notification( context);
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    _notification_android.test_notification(_counter,"hello","show notification");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
