import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:timezone/browser.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class NotificationApi{
static final _notification = FlutterLocalNotificationsPlugin();

static Future _notificationDetails() async {
  final sound = 'scificlick.wav';

  return NotificationDetails(
    android: AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      importance: Importance.max,
      //sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      playSound: true,

      priority: Priority.high,
    ),

  );



}

static Future showNotification({
  int id=3,
  String? title,
  String? body,
  String? payload,


}) async =>
    _notification.show(id, title, body,await _notificationDetails(),
    payload: payload,
    );



static Future showScheduledNotification({
  int id=0,
  String? title,
  String? body,
  String? payload,
required DateTime scheduledDate,



}) async =>
    _notification.zonedSchedule(id, title, body,
        tz.TZDateTime.from(scheduledDate, tz.local),
       await _notificationDetails(),
        payload: payload,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,

        androidAllowWhileIdle: true);

}