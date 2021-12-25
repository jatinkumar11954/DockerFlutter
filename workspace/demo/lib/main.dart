import 'package:athome_partner_app/model/serviceData.dart';
import 'package:athome_partner_app/route_generator.dart';
import 'package:athome_partner_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:overlay_support/overlay_support.dart' as overlay;
import 'model/userData.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseMessaging.onBackgroundMessage(
  //     _firebaseMessagingBackgroundHandler);
  // await localhostServer.start();

  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }


  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await Firebase.initializeApp();

  runApp(MyApp());
}

Color primaryColorLight = Colors.grey;
Color primaryColor = Colors.black;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey));
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => ProductListData()),
        ChangeNotifierProvider(create: (_) => UserData()),
        // ChangeNotifierProvider(create: (_) => Service()),
        // ChangeNotifierProvider(create: (_) => CartData()),
      ],
      child:  OverlaySupport(
    
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: primaryColor,
              primaryColorLight: primaryColorLight,
              buttonColor: primaryColor),
          home: WelcomePage(),
        ),
      ),
    );
  }
}
