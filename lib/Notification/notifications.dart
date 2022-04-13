import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:money_manager_app/customs/utilities.dart';



Future<void> scheduledNotification(int day, String? body, int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      largeIcon: 'resource://drawable/res_notification_app_icon',
      category: NotificationCategory.Recommendation,
      locked: false,
      id: id,
      channelKey: 'scheduled_channel',
      title: '${Emojis.money_money_bag} Payment Reminder ${Emojis.money_money_bag}',
      body: 'Finish this payment today ${Emojis.smile_face_with_raised_eyebrow} $body',
      bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'go to app',
      ),
    ],
    schedule: NotificationCalendar(
        allowWhileIdle: true,
        day: day,
        hour: 08,
        minute: 30,
        second: 0,
        millisecond: 0,
        repeats: true,
        preciseAlarm: true),
  );
}

Future<void> scheduledNotificationRepeat(int day, String? body, int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      largeIcon: 'resource://drawable/res_notification_app_icon',
      category: NotificationCategory.Recommendation,
      locked: false,
      id: id,
      channelKey: 'scheduled_channel',
      title: '${Emojis.money_money_bag} Payment Reminder ${Emojis.money_money_bag}',
      body: 'Finished payment? - $body',
      bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar(
        allowWhileIdle: true,
        day: day,
        hour: 20,
        minute: 00,
        second: 0,
        millisecond: 0,
        repeats: true,
        preciseAlarm: true),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduledNotificationsOne(int id) async {
  await AwesomeNotifications().cancelSchedule(id);
}
