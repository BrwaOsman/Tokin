import 'package:fluttef/notification.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({ Key? key }) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Notification_Android _notification = Notification_Android();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notification.show_notification(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _notification.test_notification(2, "title", "body");
              
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Text('send Notification'),
              ),
            ),
            InkWell(
              onTap: () async{
               await Future.delayed(Duration(seconds: 5));
                _notification.test_notification(2, " after 5 minet", "show after 5 minet");
              },
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Text('send Notification after 5 mintues'),
              ),
            )
          ],
        )
      ),
    
      
    );
  }
}