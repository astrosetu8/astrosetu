import 'dart:io';

import 'package:astrosetu/provider/astro_profile/astro_profile_bloc.dart';
import 'package:astrosetu/provider/astrologer/astrologer_bloc.dart';
import 'package:astrosetu/provider/dashboard/dashboard_bloc.dart';
import 'package:astrosetu/provider/login/auth_bloc.dart';
import 'package:astrosetu/provider/profile/profile_bloc.dart';
import 'package:astrosetu/route/pageroute.dart';
import 'package:astrosetu/route/route_generater.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/theamdata.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool _notificationsEnabled = false;
Future<void> backgroundHandler(RemoteMessage message) async {

}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  _requestPermissions();
  getNotification();

  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  if (Platform.isIOS || Platform.isMacOS) {

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp();
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
}

Future<void> getNotification() async {
  if (Platform.isIOS || Platform.isMacOS) {

  } else if (Platform.isAndroid) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    print('A new onMessageOpenedApp event was published!${message.data}');

  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!${message.data}');

  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(),),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(),
          ),
          BlocProvider<AstrologerBloc>(
            create: (context) => AstrologerBloc(),
          ),
          BlocProvider<AstroProfileBloc>(
            create: (context) => AstroProfileBloc(),
          ),
        ],
        child: MaterialApp(
          initialRoute: RoutePath.splash,
          onGenerateRoute: MyRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightMode,
          // home: ProfileRegisterScreen(),
        ),
      ),
    );
  }
}
