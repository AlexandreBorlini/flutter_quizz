import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: FirebaseOptions(
    apiKey: "AIzaSyArdFYTVphHlKALVs7KkvpAdVwE6yaI9WQ",
    appId: "1:416635906650:android:a941818482098ffb1c4663",
    messagingSenderId: "416635906650",
    projectId: "flutterquizz-98591",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QUIZZ APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(title: 'QUIZZ APP'),
    );
  }
}
