import 'package:flutter/material.dart';
import 'package:possystem/src/auth/loginscreen.dart';
import 'package:possystem/src/home/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  dynamic access_token;

  @override
  void initState() {
    checkLogin();
    // TODO: implement initState
    super.initState();
  }

  void checkLogin() async {
    print(access_token);
    final SharedPreferences prefs = await _prefs;
    setState(() {
      access_token = prefs.getString('access_token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return access_token != null
        ? HomeScreen(
            orderId: 0,
          )
        : LoginScreen();
  }
}
