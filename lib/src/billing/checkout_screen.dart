// import 'package:flutter/material.dart';
// import 'package:possystem/src/home/widgets/table_selection.dart';
// import 'package:possystem/src/model/getorder.dart';

// import '../home/table.dart';
// import '../network/post_api.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   List<Orders> orders = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     Postapi.getOrder(context).then((value) {
//       setState(() {
//         orders = value;
//         print(value);
//       });
//     });
//   }

//   @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(title: Text("Checkout")),
//   //     body: Padding(
//   //       padding: const EdgeInsets.all(16.0),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //             children: [
//   //               Text(
//   //                 "Table No: ${orders.isNotEmpty ? orders[0].table.id : ""}",
//   //                 style: TextStyle(fontSize: 16),
//   //               ),
//   //               Text(
//   //                 "Table Name: ${orders.isNotEmpty ? orders[0].table.name : ""}",
//   //                 style: TextStyle(fontSize: 16),
//   //               ),
//   //               SizedBox(height: 16),
//   //             ],
//   //           ),
//   //           Text(
//   //             "Your Payment Details",
//   //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//   //           ),
//   //           SizedBox(height: 16),
//   //           Text(
//   //             "Bill No: ${orders.isNotEmpty ? orders[0].billNo : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Transaction ID: ${orders.isNotEmpty ? orders[0].transactionId : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Customer Name: ${orders.isNotEmpty ? orders[0].customerName : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Customer PAN: ${orders.isNotEmpty ? orders[0].customerPan : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Amount: ${orders.isNotEmpty ? orders[0].amount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Discount: ${orders.isNotEmpty ? orders[0].discount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Taxable Amount: ${orders.isNotEmpty ? orders[0].taxableAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Tax Amount: ${orders.isNotEmpty ? orders[0].taxAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Service Amount: ${orders.isNotEmpty ? orders[0].serviceAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Total Amount: ${orders.isNotEmpty ? orders[0].totalAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           SizedBox(height: 32),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               // TODO: Implement confirm order logic
//   //             },
//   //             child: Text("Confirm Order"),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }\
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Checkout',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//         ),
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Your Payment Details",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               "Table Name: ${orders.isNotEmpty ? orders[0].table.name : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               "Table No: ${orders.isNotEmpty ? orders[0].table.id : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 24),
//             Text(
//               "Bill No: ${orders.isNotEmpty ? orders[0].billNo : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Transaction ID: ${orders.isNotEmpty ? orders[0].transactionId : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 24),
//             Text(
//               "Customer Name: ${orders.isNotEmpty ? orders[0].customerName : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Customer PAN: ${orders.isNotEmpty ? orders[0].customerPan : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 24),
//             Text(
//               "Amount: ${orders.isNotEmpty ? orders[0].amount : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Discount: ${orders.isNotEmpty ? orders[0].discount : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Taxable Amount: ${orders.isNotEmpty ? orders[0].taxableAmount : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Tax Amount: ${orders.isNotEmpty ? orders[0].taxAmount : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Service Amount: ${orders.isNotEmpty ? orders[0].serviceAmount : ""}",
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Total Amount: ${orders.isNotEmpty ? orders[0].totalAmount : ""}",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ExampleScreen(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//                 primary: Colors.green,
//                 textStyle: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               child: Text("Confirm Order"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //        title: const Text(
//   //         'Checkout',
//   //         style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//   //       ),
//   //       automaticallyImplyLeading: false,
//   //       elevation: 0,
//   //       backgroundColor: Colors.white,
//   //       ),
//   //     body: Padding(
//   //       padding: const EdgeInsets.all(16.0),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.stretch,
//   //         children: [
//   //           Text(
//   //             "Table No: ${orders.isNotEmpty ? orders[0].table.id : ""}",
//   //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//   //           ),
//   //           SizedBox(height: 8),
//   //           Text(
//   //             "Table Name: ${orders.isNotEmpty ? orders[0].table.name : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           SizedBox(height: 32),
//   //           Text(
//   //             "Your Payment Details",
//   //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//   //           ),
//   //           SizedBox(height: 16),
//   //           Text(
//   //             "Bill No: ${orders.isNotEmpty ? orders[0].billNo : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Transaction ID: ${orders.isNotEmpty ? orders[0].transactionId : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Customer Name: ${orders.isNotEmpty ? orders[0].customerName : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Customer PAN: ${orders.isNotEmpty ? orders[0].customerPan : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Amount: ${orders.isNotEmpty ? orders[0].amount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Discount: ${orders.isNotEmpty ? orders[0].discount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Taxable Amount: ${orders.isNotEmpty ? orders[0].taxableAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Tax Amount: ${orders.isNotEmpty ? orders[0].taxAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Service Amount: ${orders.isNotEmpty ? orders[0].serviceAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           Text(
//   //             "Total Amount: ${orders.isNotEmpty ? orders[0].totalAmount : ""}",
//   //             style: TextStyle(fontSize: 16),
//   //           ),
//   //           SizedBox(height: 32),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               // TODO: Implement confirm order logic
//   //             },
//   //             child: Padding(
//   //               padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//   //               child: Text(
//   //                 "Confirm Order",
//   //                 style: TextStyle(fontSize: 18),
//   //               ),
//   //             ),
//   //             style: ElevatedButton.styleFrom(
//   //               primary: Colors.green,
//   //               shape: RoundedRectangleBorder(
//   //                 borderRadius: BorderRadius.circular(16),
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
