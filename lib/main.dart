import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/firebase_options.dart';
import 'package:csi_hackathon/screens/StartingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: scaffoldBackgroundColor),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo', 
      home: StartingPage()
      );
  }
}
