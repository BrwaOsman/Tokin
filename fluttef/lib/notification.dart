// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification_Android {

AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// message handler for the default channel 
Future<void> mesngerss_notification() async {
  await flutterLocalNotificationsPlugin
     .resolvePlatformSpecificImplementation<
         AndroidFlutterLocalNotificationsPlugin>()
     ?.createNotificationChannel(channel);
  
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
   alert: true,
   badge: true,
   sound: true,
    );

    

}
  // show a notification with a custom layout
void show_notification(BuildContext context) async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        AndroidNotification android =
            message.notification?.android as AndroidNotification;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
              // show a showDialog with the notification details
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text(notification.title!),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(notification.body!)],
                    ),
                  ),
                );
              });
        }
      });



}
// test notification
void test_notification(int _count,String title,String body) async {
  flutterLocalNotificationsPlugin.show(
          0,
          "$title",
          "$body",
          NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  // channel.description,
                  importance: Importance.high,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher')));
}


}