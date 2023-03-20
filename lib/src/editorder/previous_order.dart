import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../model/ordereditems.dart';

class PreviousOrdersScreen extends StatefulWidget {
  @override
  _PreviousOrdersScreenState createState() => _PreviousOrdersScreenState();
}

class _PreviousOrdersScreenState extends State<PreviousOrdersScreen> {
  List<OrderItem> _previousOrders = [];

  @override
  void initState() {
    super.initState();
    fetchPreviousOrders();
  }
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
static String baseUrl = "http://192.168.1.77:8000";
  Future<void> fetchPreviousOrders() async {
    final SharedPreferences prefs = await _prefs;
    var access_token = prefs.getString('access_token');

    final url = Uri.parse('$baseUrl/billing/edit-get-product-by-category/21/5');
    final headers = {'Authorization': 'Bearer $access_token'};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List<dynamic> orderItemsJson = responseBody['order_items'];
        final List<OrderItem> orderItems = orderItemsJson
            .map((orderItemJson) => OrderItem.fromJson(orderItemJson))
            .toList();
        setState(() {
          _previousOrders = orderItems;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed with exception: $e.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Orders'),
      ),
      body: ListView.builder(
        itemCount: _previousOrders.length,
        itemBuilder: (BuildContext context, int index) {
          final orderItem = _previousOrders[index];
          return ListTile(
            title: Text(orderItem.product),
            subtitle: Text('\$${orderItem.price}'),
            trailing: Text(orderItem.orderedDate),
          );
        },
      ),
    );
  }
}
