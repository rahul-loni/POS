import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:possystem/api/get_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Postapi {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String baseUrl = Getapi.baseUrl;

  // login
  Future<int> login(String username, String password) async {
    var url = Uri.parse('$baseUrl/login/');
    var payload = json.encode({"username": username, "password": password});
    var headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, body: payload, headers: headers);

    // comment this code
    final SharedPreferences prefs = await _prefs;
    Map<String, dynamic> tokens = {
      "refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY3ODk1MTY2NSwiaWF0IjoxNjc4ODY1MjY1LCJqdGkiOiJkNzA1ODhkODA1NzQ0NjdhOTdhNjI1ZTA5NzE3OTE3MyIsInVzZXJfaWQiOjF9.ISmduVw0QR5KU2g_Ug4b2ywXtPt7m4c33mI3PxYHji4",
      "access": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjc4OTA4NDY1LCJpYXQiOjE2Nzg4NjUyNjUsImp0aSI6ImU4ZjdmMTBjZjUzOTQzNzU4Y2QxNjU1OTY1YmY5YzVkIiwidXNlcl9pZCI6MX0.IU7sZVP5m5-C-71061fZudL5zIkAbCVXKOuJ1WfhcOQ"
    };
    prefs.setString('access_token', tokens['access']);
    prefs.setString('refresh_token', tokens['refresh']);

    if (response.statusCode == 200) {
      print(response.statusCode);

      // un-comment this code
      // final responseBody = jsonDecode(response.body);
      // prefs.setString('access_token', responseBody['access']);
      // prefs.setString('refresh_token', responseBody['refresh']);
    }
    return response.statusCode;
  }

  // refresh token
  Future<int> refreshToken() async {
    final SharedPreferences prefs = await _prefs;
    var refresh_token = prefs.getString('refresh_token');

    var url = Uri.parse('$baseUrl/token/refresh/');
    var payload = json.encode({"refresh": refresh_token});
    var headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, body: payload, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final SharedPreferences prefs = await _prefs;
      prefs.setString('access_token', responseBody['access']);
    } else {
      final SharedPreferences prefs = await _prefs;
      await prefs.clear();
    }
    return response.statusCode;
  }

  // add item to order
  Future<void> addItemToOrder(String slug) async {
    final SharedPreferences prefs = await _prefs;
    var access_token = prefs.getString('access_token');

    final url = Uri.parse('$baseUrl/billing/add-item-to-order-item/$slug');
    final headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        print("addr");
        print(response.body);
        final responseBody = jsonDecode(response.body);
        // Handle the response here
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed with exception: $e.');
    }
  }

  //edit item to order
  Future<void> editaddItemToOrder(int orderId,String slug) async {
    print("sagar");
    print(orderId);
    print(slug);
    final SharedPreferences prefs = await _prefs;
    var access_token = prefs.getString('access_token');

    final url = Uri.parse('$baseUrl/billing/edit-add-item-to-order-item/$orderId/$slug');
    final headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        print("addr");
        print(response.body);
        final responseBody = jsonDecode(response.body);
        // Handle the response here
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed with exception: $e.');
    }
  }
  
  //delete in edit item
  Future<void> delteeditItemToOrder(int orderId,String slug) async {
    print("sagar");
    print(orderId);
    print(slug);
    final SharedPreferences prefs = await _prefs;
    var access_token = prefs.getString('access_token');

    final url = Uri.parse('$baseUrl/billing/edit-remove-item-from-order-item/$orderId/$slug');
    final headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        print("addr");
        print(response.body);
        final responseBody = jsonDecode(response.body);
        // Handle the response here
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed with exception: $e.');
    }
  }

  // delete item to order
  Future<void> deleteItemToOrder(String slug) async {
    final SharedPreferences prefs = await _prefs;
    var access_token = prefs.getString('access_token');

    final url = Uri.parse('$baseUrl/billing/remove-item-from-order-item/$slug');
    final headers = {
      'Authorization': 'Bearer $access_token',
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        print("delete");
        print(response.body);
        final responseBody = jsonDecode(response.body);

        print(responseBody);
        // Handle the response here
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Request failed with exception: $e.');
    }
  }

  //  edit place order
  Future<int> editplaceOrder( int orderId,Map<String, dynamic> payload) async {
    final SharedPreferences prefs = await _prefs;
    
    var access_token = prefs.getString('access_token');

    final url = Uri.parse('$baseUrl/billing/edit-save-order-items/$orderId');
    print(payload);
    final headers = {'Authorization': 'Bearer $access_token', 'Content-Type': 'application/json'};

    try {
      final response = await http.post(url, body: json.encode(payload), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(" edit order placed");
        print(response.body);
        final responseBody = jsonDecode(response.body);

        print(responseBody);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      return response.statusCode;
    } catch (e) {
      print('Request failed with exception: $e.');
      return 400;
    }
  }

  //placeorder
  Future<int> placeOrder(Map<String, dynamic> payload) async {
  final SharedPreferences prefs = await _prefs;
  var access_token = prefs.getString('access_token');

  final url = Uri.parse('$baseUrl/billing/save-order-items');
  print(payload);
  final headers = {'Authorization': 'Bearer $access_token', 'Content-Type': 'application/json'};

  try {
    final response = await http.post(url, body: json.encode(payload), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("order placed");
      print(response.body);
      final responseBody = jsonDecode(response.body);

      print(responseBody);
      prefs.setString('order_id', responseBody['order_id'].toString());

      final orderId = responseBody['order_id'];
      return orderId;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return 0;
    }
  } catch (e) {
    print('Request failed with exception: $e.');
    return 0;
  }
}


  // Future<int> placeOrder(Map<String, dynamic> payload) async {
  //   final SharedPreferences prefs = await _prefs;
  //   var access_token = prefs.getString('access_token');

  //   final url = Uri.parse('$baseUrl/billing/save-order-items');
  //   print(payload);
  //   final headers = {
  //     'Authorization': 'Bearer $access_token',
  //     'Content-Type': 'application/json'
  //   };

  //   try {
  //     final response =
  //         await http.post(url, body: json.encode(payload), headers: headers);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       print("order placed");
  //       print(response.body);
  //       final responseBody = jsonDecode(response.body);

  //       print(responseBody);

  //       // get the order_id here
  //       final orderId = responseBody['order_id'];
  //       print(orderId);
  //       return orderId;
  //     } else {
  //       print('Request failed with status: ${response.statusCode}.');
  //       return 0;
  //     }
  //   } catch (e) {
  //     print('Request failed with exception: $e.');
  //     return 400;
  //   }
  // }
}
