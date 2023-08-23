
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:live_score/firebase_notification_handler.dart';
import 'home_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseNotificationHandler().initialization();
  FirebaseNotificationHandler().onTokenRefresh();
  print(await FirebaseNotificationHandler().getToken());
  await FirebaseNotificationHandler().unSubscriberToTopic("Ostad");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primarySwatch: Colors.amber
      ),
      home: const HomeScreen(),
    );
  }
}


