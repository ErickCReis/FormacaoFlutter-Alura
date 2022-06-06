import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetups/http/web.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _startPushNotificationHandler();

  runApp(App());
}

void _startPushNotificationHandler() async {
  final messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.denied ||
      settings.authorizationStatus == AuthorizationStatus.notDetermined) {
    return;
  }

  final token = await messaging.getToken();
  _setPushToken(token);

  FirebaseMessaging.onMessage.listen(_firebaseMessageForegroundHandler);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgroudHandler);
}

void _firebaseMessageForegroundHandler(message) {
  print('Foreground message received');

  if (message.data.isNotEmpty) {
    print('message.data: ${message.data}');
  }

  if (message.notification != null) {
    print(
        'message.notification: Title = ${message.notification?.title}, Body = ${message.notification?.body}');
  }
}

Future<void> _firebaseMessageBackgroudHandler(RemoteMessage message) async {
  print('Background message received');

  if (message.data.isNotEmpty) {
    print('message.data: ${message.data}');
  }

  if (message.notification != null) {
    print(
        'message.notification: Title = ${message.notification?.title}, Body = ${message.notification?.body}');
  }
}

void _setPushToken(String? token) async {
  await GetStorage.init();

  if (GetStorage().read<String>('pushToken') == token) {
    print('Token já existe');
    return;
  }

  final device = await _getDeviceInfo();
  device.token = token;

  await sendDevice(device);

  GetStorage().write('pushToken', token);
}

Future<Device> _getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();
  String? model;
  String? brand;

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    model = androidInfo.model;
    brand = androidInfo.brand;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    model = iosInfo.utsname.machine;
    brand = 'Apple';
  }

  return Device(
    token: null,
    model: model,
    brand: brand,
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dev meetups',
      home: EventsScreen(),
    );
  }
}
