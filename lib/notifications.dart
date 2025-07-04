import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> scheduleNotification({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'hair_care_channel', // Unique channel ID for your hair care service
      'Hair Care Notifications', // Name of your notification channel
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    // Convert scheduledDate to local timezone
    tz.TZDateTime scheduledDateLocal = tz.TZDateTime.from(scheduledDate, tz.local);
   

    print(scheduledDateLocal);
    print(">>>>>>>>>>>>>>>>>>>>ffffffffffffffffffffsfgbgt");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      title,
      body,
      scheduledDateLocal,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   notificationId,
    //   title,
    //   body,
    //   scheduledDateLocal,
    //   platformChannelSpecifics,
      
    //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    // );
    print(scheduledDateLocal);
    print(">>>>>>>>>>>>>>>>>>@@@@@@@@>>ffffffffffffffffffffsfgbgt");
  }
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index]),
          );
        },
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotificationService.init();

//   // Example usage: Schedule a notification 1 day before the booked service time
//   DateTime bookedServiceTime = DateTime.now().add(Duration(days: 1));
//   await NotificationService.scheduleNotification(
//     notificationId: 0,
//     title: 'Service Reminder',
//     body: 'Your booked service is scheduled for tomorrow.',
//     scheduledDate: bookedServiceTime,
//   );

//   runApp(MaterialApp(
//     home: MessageScreen(),
//   ));
// }
