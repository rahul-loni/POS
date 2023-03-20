import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:possystem/api/post_api.dart';
import 'package:possystem/model/getorder.dart';
import 'package:possystem/model/ordereditems.dart';
import '../main.dart';
import '../model/getproduct.dart';
import '../model/gettable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Getapi {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String baseUrl = "http://192.168.1.75:8000";

  // get table
  Future<List<Tables>> getTables(context) async {
    try {
      final SharedPreferences prefs = await _prefs;
      print("sagar");

      var access_token = prefs.getString('access_token');
      print(access_token);
      String apiUrl = "$baseUrl/table";
      var response = await get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $access_token'});

      if (response.statusCode == 200) {
        var usersResponse = jsonDecode(response.body);
        log("response $usersResponse");
        print(usersResponse);
        List data = usersResponse['tables'];

        List<Tables> users = [];
        for (var element in data) {
          Tables user = Tables.fromJson(element);
          users.add(user);
        }

        return users;
      } else if (response.statusCode == 401) {
        var refresh_status = Postapi().refreshToken();
        if (refresh_status == 200) {
          getTables(context);
        } else {
          // MaterialPageRoute(builder: (context) => MainScreen());
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      log("Error $e");
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      return [];
    }
  }

  // get category
  Future<List<Categories>> getCategory(context) async {
    try {
      final SharedPreferences prefs = await _prefs;
      var access_token = prefs.getString('access_token');

      String apiUrl = "$baseUrl/item/category?page=1";
      var response = await get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $access_token'});

      if (response.statusCode == 200) {
        var usersResponse = jsonDecode(response.body);
        log("response $usersResponse");
        print(usersResponse);
        List data = usersResponse['categories'];

        List<Categories> cateogories = [];
        for (var element in data) {
          Categories user = Categories.fromJson(element);
          cateogories.add(user);
        }

        return cateogories;
      } else if (response.statusCode == 401) {
        var refresh_status = Postapi().refreshToken();
        if (refresh_status == 200) {
          getCategory(context);
        } else {
          // MaterialPageRoute(builder: (context) => MainScreen());
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      log("Error $e");
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      return [];
    }
  }

  // get product
  Future<List<Products>> getProduct(context) async {
    try {
      final SharedPreferences prefs = await _prefs;
      var access_token = prefs.getString('access_token');

      String apiUrl = "$baseUrl/item/product?page=1";
      var response = await get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $access_token'});

      if (response.statusCode == 200) {
        var usersResponse = jsonDecode(response.body);
        log("response $usersResponse");
        print(usersResponse);
        List data = usersResponse['products'];

        List<Products> products = [];
        for (var element in data) {
          Products product = Products.fromJson(element);
          products.add(product);
        }

        return products;
      } else if (response.statusCode == 401) {
        var refresh_status = Postapi().refreshToken();
        if (refresh_status == 200) {
          getProduct(context);
        } else {
          // MaterialPageRoute(builder: (context) => MainScreen());
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print("yes");
      log("Error $e");
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      return [];
    }
  }

  // get orders
  Future<List<Orders>> getOrder(context) async {
    try {
      final SharedPreferences prefs = await _prefs;
      var access_token = prefs.getString('access_token');

      String apiUrl = "$baseUrl/billing/orders?page=1";
      var response = await get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $access_token'});

      if (response.statusCode == 200) {
        var usersResponse = jsonDecode(response.body);
        log("response $usersResponse");
        print(usersResponse);
        List data = usersResponse['orders'];

        List<Orders> orders = [];
        for (var element in data) {
          Orders order = Orders.fromJson(element);
          orders.add(order);
        }

        return orders;
      } else if (response.statusCode == 401) {
        var refresh_status = Postapi().refreshToken();
        if (refresh_status == 200) {
          getOrder(context);
        } else {
          // MaterialPageRoute(builder: (context) => MainScreen());
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print("yes");
      log("Error $e");
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      return [];
    }
  }

  //get
  Future<List<OrderItem>> getOrderforedit(context, int orderId) async {
    try {
      final SharedPreferences prefs = await _prefs;
      var access_token = prefs.getString('access_token');

      String apiUrl =
          "$baseUrl/billing/edit-get-product-by-category/$orderId/100";
      var response = await get(Uri.parse(apiUrl),
          headers: {'Authorization': 'Bearer $access_token'});

      if (response.statusCode == 200) {
        var usersResponse = jsonDecode(response.body);
        log("response $usersResponse");
        print(usersResponse);
        List data = usersResponse['order_item'];

        List<OrderItem> orders = [];
        for (var element in data) {
          OrderItem order = OrderItem.fromJson(element);
          orders.add(order);
        }

        return orders;
      } else if (response.statusCode == 401) {
        var refresh_status = Postapi().refreshToken();
        if (refresh_status == 200) {
          getOrder(context);
        } else {
          // MaterialPageRoute(builder: (context) => MainScreen());
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print("yes");
      log("Error $e");
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      return [];
    }
  }

  // Future<List<OrderItem>> getOrderforedit(context) async {
  //   try {
  //     final SharedPreferences prefs = await _prefs;
  //     var access_token = prefs.getString('access_token');

  //     String apiUrl = "$baseUrl/billing/edit-get-product-by-category/35/1";
  //     var response = await get(Uri.parse(apiUrl),
  //         headers: {'Authorization': 'Bearer $access_token'});

  //     if (response.statusCode == 200) {
  //       var usersResponse = jsonDecode(response.body);
  //       log("response $usersResponse");
  //       print(usersResponse);

  //       if (usersResponse != null && usersResponse['orders'] != null) {
  //         List data = usersResponse['orders'];

  //         List<OrderItem> orders = [];
  //         for (var element in data) {
  //           OrderItem order = OrderItem.fromJson(element);
  //           orders.add(order);
  //         }

  //         return orders;
  //       } else {
  //         return [];
  //       }
  //     } else if (response.statusCode == 401) {
  //       var refresh_status = Postapi().refreshToken();
  //       if (refresh_status == 200) {
  //         getOrder(context);
  //       } else {
          // MaterialPageRoute(builder: (context) => MainScreen());
  //       }
  //       return [];
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     print("yes");
  //     log("Error $e");
  //     print(e);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Error")));
  //     return [];
  //   }
  // }

}
