import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetups/http/web.dart';
import 'package:meetups/models/device.dart';
import 'package:meetups/screens/events_screen.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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

  final token = await messaging.getToken(
    vapidKey:
        'BAX7TOd78WjoDab_XATCbi1bc7o8jpN_P31s10Fg-xoj0iHwjQFgl_n1nXi2adlu-MsVuCt5ByCFi7Z-RGeYWZY',
  );
  _setPushToken(token);

  FirebaseMessaging.onMessage.listen(_firebaseMessageForegroundHandler);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgroudHandler);

  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage?.data.containsKey('message') ?? false) {
    showCustomDialog(initialMessage?.data['message']);
  }
}

void showCustomDialog(String message) {
  final okButton = OutlinedButton(
    child: Text('OK'),
    onPressed: () => Navigator.pop(navigatorKey.currentContext!),
  );

  final alert = AlertDialog(
    title: Text('Promoção imperdível!'),
    content: Text(message),
    actions: [okButton],
  );

  showDialog(context: navigatorKey.currentContext!, builder: (_) => alert);
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
  print(token);
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

  if (kIsWeb) {
    final web = await deviceInfo.webBrowserInfo;

    model = 'Web';
    brand = web.userAgent;
  } else {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
      brand = androidInfo.brand;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.utsname.machine;
      brand = 'Apple';
    }
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
      navigatorKey: navigatorKey,
    );
  }
}
