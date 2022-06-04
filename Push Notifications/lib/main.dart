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

  final token = await FirebaseMessaging.instance.getToken();
  setPushToken(token);

  runApp(App());
}

void setPushToken(String? token) async {
  await GetStorage.init();

  if (GetStorage().read<String>('pushToken') == token) {
    print('Token já existe');
    return;
  }

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

  final device = Device(
    token: token,
    model: model,
    brand: brand,
  );

  sendDevice(device);

  GetStorage().write('pushToken', token);
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
