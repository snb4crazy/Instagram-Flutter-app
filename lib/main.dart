import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/responsive/mobile_screen_layout.dart';
import 'package:instagram/responsive/responsive_layout.dart';
import 'package:instagram/responsive/web_screen_layout.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['apiKey'].toString(),
        appId: dotenv.env['appId'].toString(),
        messagingSenderId: dotenv.env['messagingSenderId'].toString(),
        projectId: dotenv.env['projectId'].toString(),
        storageBucket: dotenv.env['storageBucket'].toString(),
        //not sure if it's needed
        authDomain: dotenv.env['authDomain'].toString(),
        measurementId: dotenv.env['measurementId'].toString(),
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: SignupScreen(),
      //LoginScreen(),
      //const ResponsiveLayout(
      //mobileScreenLayout: MobileScreenLayout(),
      //webScreenLayout: WebScreenLayout(),
      //),
    );
  }
}
