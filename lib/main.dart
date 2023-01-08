import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:welcome2023/screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCfrXb_KeGRxQ8_m8RQrlI7tArvWkoCJqY",
          authDomain: "welcome2023-govind-dev.firebaseapp.com",
          projectId: "welcome2023-govind-dev",
          storageBucket: "welcome2023-govind-dev.appspot.com",
          messagingSenderId: "402950950598",
          appId: "1:402950950598:web:7d7dc56310e9bd05a291c7",
          measurementId: "G-8VD40HTXM9"),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome 2023',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const DashBoardScreen(),
    );
  }
}
