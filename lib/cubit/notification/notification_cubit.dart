import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_chat/resource/api_repository.dart';

import '../../helper.dart';
import '../../main.dart';

part 'notification_state.dart';

part 'notification_cubit.freezed.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState.initial());
  final ApiRepository apiRepository = ApiRepository();

  Future<void> testNotificationToUser() async {}

  Future<void> testLocalNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      notificationDetails,
      payload: 'item x',
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Chat',
      'Incoming Chat',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.data['content'],
      message.notification?.body,
      notificationDetails,
      payload: 'item x',
    );
  }

  static Future<void> notificationInitial() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    logger.v('User granted permission: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.v('Got a message whilst in the foreground!');
      logger.v('Message data: ${message.notification?.title}');

      if (message.notification != null) {
        logger.v(
            'Message also contained a notification: ${message.notification?.body}');
      }
      showNotification(message)
          .then((value) => logger.v("Notification Triggered"));
    });
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        logger.v("onDidReceiveNotificationResponse: $details");
      },
    );
  }
}
