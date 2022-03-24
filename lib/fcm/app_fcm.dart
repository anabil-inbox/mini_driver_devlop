import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/tasks/task_response.dart';
import 'package:inbox_driver/feature/view/screens/home/home_screen.dart';
import 'package:inbox_driver/feature/view/screens/home/instant_order/instant_order_screen.dart';
import 'package:inbox_driver/feature/view_model/home_view_modle/home_view_modle.dart';
import 'package:inbox_driver/util/constance.dart';
import 'package:inbox_driver/util/sh_util.dart';
import 'package:logger/logger.dart';

class AppFcm {
  AppFcm._();
  static AppFcm fcmInstance = AppFcm._();

  static HomeViewModel homeViewModel =
      Get.put(HomeViewModel(), permanent: true);

  init() {
    configuration();
    registerNotification();
    getTokenFCM();
  }

  ValueNotifier<int> notificationCounterValueNotifer = ValueNotifier(0);
  MethodChannel platform =
      const MethodChannel('dexterx.dev/flutter_local_notifications_example');
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  RemoteMessage messages = const RemoteMessage();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'com.inbox.driver', // id
    'com.inbox.driver', // title
    //  'IMPORTANCE_HIGH', // description
    importance: Importance.max,
    //showBadge: true,
  );

  configuration() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('drawable/app_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await selectNotification(notificationAppLaunchDetails?.payload);
    }
  }

  Future selectNotification(String? payload) async {
    try {
      // RemoteMessage message = messages;
      Logger().e(messages);
      goToOrderPage(messages.data, isFromTerminate: false);
    } catch (e) {
      Logger().d(e);
    }
  }

  void registerNotification() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      //todo this for add badge for app
      // var android = message.data;
      Logger().e("MSG_MESSAGE $message");
      Logger().e("MSG_NOT_MESSAGE $messages");
      Logger().e("MSG_NOT ${message.data.toString()}");
      if (Platform.isIOS || Platform.isAndroid) {
        messages = message;
        updatePages(message);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              iOS: const IOSNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                /* subtitle: message.notification.body,*/
              ),
              android: AndroidNotificationDetails(
                channel.id, channel.name,
                // channel.description,
                styleInformation: const BigTextStyleInformation(''),
                enableLights: true,
                enableVibration: true,
                fullScreenIntent: true,
                autoCancel: true,
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
            payload: "${message.data}");
      }
    });
  }

  getTokenFCM() async {
    await _firebaseMessaging.getToken().then((token) async {
      Logger().d('token fcm : $token');
      await SharedPref.instance.setFCMToken(token.toString());
    }).catchError((err) {
      Logger().d(err);
    });
  }

  static void goToOrderPage(Map<String, dynamic> map,
      {required bool isFromTerminate}) async {
    Logger().i(map[Constance.id].toString());
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      if (map[Constance.id].toString() == Constance.userSignature) {
      } else if (map[Constance.id].toString() == Constance.addedNewTask) {
        await homeViewModel.refrshHome();
        Get.off(() => HomeScreen());
      } else if (map[Constance.id].toString() ==
          Constance.addedNewSpecificTask) {
        //details
      } else if (map[Constance.id].toString() == Constance.accetedRequestTime) {
        homeViewModel.operationTask =
            TaskResponse.fromJson(map, isFromNotification: true);
          // Get.offAll(() => InstantOrderScreen(
          //   taskId: homeViewModel.operationTask.tas,
          //   taskStatusId: "",
          // ));  
        homeViewModel.update();
      }
    });
  }

  void updatePages(RemoteMessage message) async {
    homeViewModel.operationTask = TaskResponse.fromJson(message.data, isFromNotification: true);
    await homeViewModel.refrshHome();
  }
}
