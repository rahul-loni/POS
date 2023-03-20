import 'package:flutter/material.dart';
import 'package:possystem/model/getcategory.dart' as categories;
import 'package:possystem/model/getproduct.dart';
import 'package:possystem/src/mycart/my_cart.dart';
import '../../../api/post_api.dart';
import '../../../api/get_api.dart';

class OrderScreen extends StatefulWidget {
  final int tableId;
  final String tableName;

  const OrderScreen({Key? key, required this.tableId, required this.tableName})
      : super(key: key);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Products> selectedProducts = [];
  List<Categories> categories = [];
  List<Products> products = [];

  void incrementQuantity(Products product) {
    setState(() {
      product.quantity++;
    });
  }

  void decrementQuantity(Products product) {
    if (product.quantity > 0) {
      setState(() {
        product.quantity--;
      });
    }
  }

  int totalQuantity = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getapi().getCategory(context).then((value) {
      setState(() {
        categories = value;
        print(value);
      });
    });

    Getapi().getProduct(context).then((value) {
      setState(() {
        products = value;
        print("sa");
        print(value);
      });
    });
  }

  int _count = 1;
  int _selectedIndex = 0;
  int selectedProductIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 40,
                  ),
                  onPressed: () {
                    selectedProducts.addAll(
                        products.where((product) => product.quantity > 0));
                    double totalPrice = selectedProducts.fold(
                        0,
                        (sum, product) =>
                            sum + (product.price * product.quantity));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCart(
                          selectedProducts: selectedProducts,
                          totalPrice: totalPrice,
                          tableId: widget.tableId,
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        selectedProducts.clear();
                      });
                    });
                  },
                ),
                totalQuantity > 0
                    ? Positioned(
                        top: 1,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 22,
                            minHeight: 22,
                          ),
                          child: Text(
                            '$totalQuantity',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            padding: EdgeInsets.all(8),
            child: Text(
              'Table NO: ${widget.tableId.toString()}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 55,
            child: Container(
              color: Color.fromARGB(255, 205, 241, 223),
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Categories category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedIndex == index
                                ? Colors.purple
                                : Colors.grey.shade300,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.purple
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: GridView.builder(
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2,
              //   childAspectRatio: 0.75,
              // ),
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 4, childAspectRatio: 0.8,),
              itemCount: products
                  .where((product) =>
                      product.category.id == categories[_selectedIndex].id)
                  .length,
              itemBuilder: (BuildContext context, int index) {
                Products product = products
                    .where((product) =>
                        product.category.id == categories[_selectedIndex].id)
                    .toList()[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedProductIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${Getapi.baseUrl}${product.image}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        selectedProductIndex == index
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    // onTap: () async {
                                    //   setState(() {
                                    //     if (product.quantity > 0) {
                                    //       product.quantity--;
                                    //       totalQuantity--;
                                    //     }
                                    //   });
                                    //   showDialog(
                                    //     context: context,
                                    //     barrierDismissible: false,
                                    //     builder: (_) => AlertDialog(
                                    //       content: Row(
                                    //         children: [
                                    //           CircularProgressIndicator(),
                                    //           SizedBox(width: 20),
                                    //           Text("Removing Product..."),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   );
                                    //   await Postapi.deleteItemToOrder(product.slug);
                                    //   // dismiss dialog after 2 seconds
                                    //   Future.delayed(Duration(seconds: 2), () {
                                    //     Navigator.of(context).pop();
                                    //   });
                                    // },
                                    onTap: () async {
                                      if (product.quantity > 0) {
                                        setState(() {
                                          product.quantity--;
                                          totalQuantity--;
                                        });
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => AlertDialog(
                                            content: Row(
                                              children: [
                                                CircularProgressIndicator(),
                                                SizedBox(width: 20),
                                                Text("Removing Product..."),
                                              ],
                                            ),
                                          ),
                                        );
                                        await Postapi()
                                            .deleteItemToOrder(product.slug);
                                        // dismiss dialog after 2 seconds
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.of(context).pop();
                                        });
                                      }
                                    },

                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      child: Image.asset(
                                        "assets/minusbutton.png",
                                        height: 24.0,
                                        width: 24.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    product.quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        product.quantity++;
                                        totalQuantity++;
                                      });
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (_) => AlertDialog(
                                          content: Row(
                                            children: [
                                              CircularProgressIndicator(),
                                              SizedBox(width: 20),
                                              Text("Adding Product..."),
                                            ],
                                          ),
                                        ),
                                      );
                                      await Postapi()
                                          .addItemToOrder(product.slug);
                                      // dismiss dialog after 2 seconds
                                      Future.delayed(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      child: Image.asset(
                                        "assets/addbutton.png",
                                        height: 24.0,
                                        width: 24.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
