import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:possystem/api/get_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/gettable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../auth/loginscreen.dart';
import 'order/editorderscreen.dart';
import 'order/orderscreen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final int orderId;
  const HomeScreen({
    super.key,
    required this.orderId,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<Tables> table = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Getapi().getTables(context).then((value) {
      setState(() {
        table = value;
        print(value);
      });
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _logout(BuildContext context) async {
    String baseUrl = "http://192.168.1.77:8000";
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    print(refreshToken);
    final response = await http.post(
      Uri.parse('$baseUrl/logout/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      prefs.remove('access_token');
      prefs.remove('refresh_token');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to logout')),
      );
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "POS",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Table List',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: table.length,
                itemBuilder: (context, index) {
                  return userCard(table[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userCard(Tables table) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (table.status == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    tableId: table.id,
                    tableName: table.name,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditOrderScreen(
                    tableId: table.id,
                    tableName: table.name,
                    orderId: widget.orderId,
                  ),
                ),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: table.status == 1 ? Colors.grey[200] : Colors.red[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 1),
                Text(
                  'Table ${table.id} - ${table.name}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Capacity ${table.capacity}',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (table.status == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(
                            tableId: table.id,
                            tableName: table.name,
                          ),
                        ),
                      );
                    }
                  },
                  child: SvgPicture.asset(
                    'assets/table.svg',
                    color: Colors.black,
                    width: 120,
                    // width: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Order {
  final int id;
  final String orderId;

  Order({required this.id, required this.orderId});
}
