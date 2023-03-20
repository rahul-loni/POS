import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:possystem/api/get_api.dart';
import 'package:possystem/src/home/homescreen.dart';
import 'package:possystem/model/getproduct.dart';
import 'package:possystem/api/post_api.dart';

import '../bill print/bill_print.dart';

class MyCart extends StatefulWidget {
  final List<Products> selectedProducts;
  final double totalPrice;
  final int tableId;

  const MyCart(
      {Key? key,
      required this.selectedProducts,
      required this.totalPrice,
      required this.tableId})
      : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  late double totalPrice;
  late List<Products> selectedProducts;
  late Future<void> deleteFuture;
  late int tableId;

  final String url = '${Getapi.baseUrl}/billing/save-order-items';

  // List<Products> cartItems = [];

  List<Map<String, dynamic>> cartItems = [];

  void initState() {
    super.initState();
    totalPrice = widget.totalPrice;
    selectedProducts = widget.selectedProducts;
    tableId = widget.tableId;
    deleteFuture = Future.value();
  }

  bool _isLoading = false;

  Future<void> _deleteProduct(Products product) async {
    setState(() {
      deleteFuture = Future.delayed(Duration(seconds: 1));
    });
    await deleteFuture;
    setState(() {
      selectedProducts.remove(product);
      totalPrice -= (product.quantity * product.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorTelu,
      appBar: AppBar(
        title: const Text(
          'POS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'ORDER',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Text(
                    'Table No: ${widget.tableId.toString()}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 12.0,
                    mainAxisExtent: 110),
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  Products product = widget.selectedProducts[index];
                  return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          // Remove the item from the data source
                          selectedProducts.removeAt(index);
                          // Update the total price accordingly
                          totalPrice -= (product.price * product.quantity);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 90,
                                    width: 90,
                                    child: Image.network(
                                      "${Getapi.baseUrl}${product.image}",
                                      height: 90,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${product.name}',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${product.price}',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: colorSiji,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 70),
                                        Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: colorTelu,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      totalPrice -=
                                                          product.price;
                                                      product.quantity--;
                                                    });
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        content: Row(
                                                          children: [
                                                            CircularProgressIndicator(),
                                                            SizedBox(width: 20),
                                                            Text(
                                                                "Adding Product..."),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                    await Postapi()
                                                        .deleteItemToOrder(
                                                            product.slug);
                                                    // dismiss dialog after 2 seconds
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Image.asset(
                                                      "assets/minusbutton.png",
                                                      height: 22.0,
                                                      width: 22.0,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  product.quantity.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    setState(() {
                                                      totalPrice +=
                                                          product.price;
                                                      product.quantity++;
                                                    });
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                        content: Row(
                                                          children: [
                                                            CircularProgressIndicator(),
                                                            SizedBox(width: 20),
                                                            Text(
                                                                "Adding Product..."),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                    await Postapi()
                                                        .addItemToOrder(
                                                            product.slug);
                                                    // dismiss dialog after 2 seconds
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Image.asset(
                                                      "assets/addbutton.png",
                                                      height: 22.0,
                                                      width: 22.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 40),
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: Color.fromARGB(255, 209, 209, 209),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Rs.${totalPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colorSiji,
                          ),
                        ),
                        Text(
                          'Rs.${totalPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: colorSiji,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 55,
                  width: 150,
                  decoration: BoxDecoration(
                      color: buttoncolor2,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      'Cancel Order',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> body = {
                        "timestamp": DateTime.now()
                            .millisecondsSinceEpoch
                            .toString()
                            .substring(0, 10),
                        "table": widget.tableId,
                        "customer_name": "",
                        "customer_pan": "",
                        "financial_year": "2022-2023",
                        "amount": totalPrice,
                        "total_discount": 0,
                        "tax_amount": 0,
                        "service_amount": 0,
                        "payment_type": "unpaid",
                        "total_amount": totalPrice,
                        "is_realtime": 1
                      };

                      // var order_status = await Postapi().placeOrder(body);
                      // if (order_status == 200) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text('Order has been sent!'),
                      //       duration: Duration(seconds: 2),
                      //     ),
                      //   );

                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => HomeScreen()),
                      //   ).then((value) {
                      //     setState(() {
                      //       // cartItems = []; /
                      //       //
                      //       cartItems.clear();
                      //       /// clear the data
                      //     });
                      //   });

                      //   // Handle the response here
                      // } else {
                      //   final snackBar = SnackBar(
                      //     content: Text("Error while placing the order"),
                      //     duration: Duration(seconds: 3),
                      //   );
                      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      //   print("Error while placing the order");
                      // }
                      var order_id = await Postapi().placeOrder(body);
                      if (order_id != 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order has been sent!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        int orderId = order_id;
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => HomeScreen(
                        //             orderId: orderId,
                        //           )),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillPrintPage(
                              totalPrice: widget.totalPrice.toStringAsFixed(2),
                              productPrice: widget.selectedProducts[0].price
                                  .toStringAsFixed(2),
                              productName: widget.selectedProducts[0].name,
                              selectedProducts: selectedProducts,
                                orderId: orderId,
                            ),
                          ),
                        );

                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            cartItems = []; // clear the data
                          });
                        });
                      } else {
                        final snackBar = SnackBar(
                          content: Text("Error while placing the order"),
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        print("Error while placing the order");
                      }

                      // handle response
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(buttoncolor),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(fontSize: 18),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: Text('Send Order'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

const colorSiji = Color.fromARGB(255, 26, 26, 26);
const colorSijiSetengah = Color.fromARGB(255, 56, 56, 56);
const colorLoro = Color.fromARGB(255, 175, 234, 13);
const colorTelu = Color.fromARGB(255, 237, 237, 237);
const back = Color.fromRGBO(234, 240, 240, 1);

//button Color

const buttoncolor = Color.fromRGBO(177, 206, 212, 1);
const buttoncolor2 = Color.fromRGBO(236, 90, 90, 1);
