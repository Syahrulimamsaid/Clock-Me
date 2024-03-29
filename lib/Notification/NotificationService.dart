import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'Clock_Me',
            channelName: 'Clock Me',
            channelDescription: 'Alarm App',
            defaultColor: Colors.purple,
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            onlyAlertOnce: true,
            playSound: true,
            enableVibration: true,
            defaultPrivacy: NotificationPrivacy.Public,
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            criticalAlerts: true)
      ],
    );

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> showNotification(
    int ID, {
    required final String Title,
    required final String Body,
    required final bool statusSchedule,
    final Schedule? schedule,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
  }) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: ID,
            channelKey: 'Clock_Me',
            title: Title,
            body: Body,
            actionType: actionType,
            notificationLayout: notificationLayout,
            summary: summary,
            category: category,
            payload: payload,
            locked: true,
            autoDismissible: false,
            fullScreenIntent: true,
            wakeUpScreen: true,
            bigPicture: bigPicture),
        actionButtons: actionButtons,
        schedule: (statusSchedule)
            ? NotificationCalendar(
                minute: schedule!.time.minute,
                hour: schedule.time.hour,
                day: schedule.time.day,
                weekday: schedule.time.weekday,
                month: schedule.time.month,
                year: schedule.time.year,
                preciseAlarm: true,
                allowWhileIdle: true,
                timeZone: await AwesomeNotifications.localTimeZoneIdentifier,
              )
            : null);
  }
}

class Schedule {
  String details;
  DateTime time;

  Schedule({required this.details, required this.time});
}
