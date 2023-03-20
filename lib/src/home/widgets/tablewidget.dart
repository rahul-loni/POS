// import 'package:flutter/material.dart';

// class TablelistWidget extends StatefulWidget {
//   @override
//   _TablelistWidgetState createState() => _TablelistWidgetState();
// }

// class _TablelistWidgetState extends State<TablelistWidget> {
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//         width: 428,
//         height: 129,
//         decoration: BoxDecoration(
//           color: Color.fromRGBO(255, 255, 255, 1),
//         ),
//         child: Stack(children: <Widget>[
//           Positioned(
//               top: 10,
//               left: 20,
//               child: Container(
//                   width: 162,
//                   height: 54,
//                   decoration: BoxDecoration(),
//                   child: Stack(children: <Widget>[
//                     Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Text(
//                           'table list',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Color.fromRGBO(0, 0, 0, 1),
//                               fontFamily: 'Quicksand',
//                               fontSize: 30,
//                               letterSpacing:
//                                   0 /*percentages not used in flutter. defaulting to zero*/,
//                               fontWeight: FontWeight.normal,
//                               height: 1),
//                         )),
//                     Positioned(
//                         top: 119,
//                         left: -20,
//                         child: Divider(
//                             color: Color.fromRGBO(236, 237, 237, 1),
//                             thickness: 1)),
//                   ]))),
//           Positioned(
//               top: 69,
//               left: 20,
//               child: Container(
//                   width: 275,
//                   height: 39,
//                   decoration: BoxDecoration(),
//                   child: Stack(children: <Widget>[
//                     Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(5),
//                               topRight: Radius.circular(5),
//                               bottomLeft: Radius.circular(5),
//                               bottomRight: Radius.circular(5),
//                             ),
//                             color: Color.fromRGBO(232, 197, 163, 1),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Text(
//                                 'first floor',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(0, 0, 0, 1),
//                                     fontFamily: 'Quicksand',
//                                     fontSize: 15,
//                                     letterSpacing:
//                                         0 /*percentages not used in flutter. defaulting to zero*/,
//                                     fontWeight: FontWeight.normal,
//                                     height: 1),
//                               ),
//                             ],
//                           ),
//                         )),
//                     Positioned(
//                         top: 0,
//                         left: 142,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(5),
//                               topRight: Radius.circular(5),
//                               bottomLeft: Radius.circular(5),
//                               bottomRight: Radius.circular(5),
//                             ),
//                             color: Color.fromRGBO(249, 249, 249, 1),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Text(
//                                 'second floor',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(217, 217, 217, 1),
//                                     fontFamily: 'Quicksand',
//                                     fontSize: 15,
//                                     letterSpacing:
//                                         0 ,
//                                     fontWeight: FontWeight.normal,
//                                     height: 1),
//                               ),
//                             ],
//                           ),
//                         )),
//                   ]))),
//         ]));
//   }
// }

// import 'package:flutter/material.dart';

// class TableSelectionWidget extends StatefulWidget {
//   @override
//   _TableSelectionWidgetState createState() => _TableSelectionWidgetState();
// }

// class _TableSelectionWidgetState extends State<TableSelectionWidget> {
//   int _selectedTable = 1;
//   Color _button1Color = Color.fromRGBO(232, 197, 163, 1);
//   Color _button2Color = Colors.blue;
//   // List<Widget> _getTableList(int tableNumber) {
//   //   // Return a list of widgets for the selected table number
//   //   // ...
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 428,
//       height: 129,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "Table List",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       color: Color.fromRGBO(0, 0, 0, 1),
//                       fontFamily: 'Quicksand',
//                       fontSize: 30,
//                       letterSpacing:
//                           0 /*percentages not used in flutter. defaulting to zero*/,
//                       fontWeight: FontWeight.normal,
//                       height: 1),
//                 )
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: _button1Color,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _selectedTable = 1;
//                       _button1Color = Color.fromRGBO(232, 197, 163, 1); // Change button color
//                       _button2Color = Colors.blue;
//                     });
//                   },
//                   // child: Text('First Floor'),
//                   child: Text(
//                     'first floor',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Color.fromRGBO(0, 0, 0, 1),
//                         fontFamily: 'Quicksand',
//                         fontSize: 15,
//                         letterSpacing:
//                             0 /*percentages not used in flutter. defaulting to zero*/,
//                         fontWeight: FontWeight.normal,
//                         height: 1),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: _button2Color,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _selectedTable = 2;
//                       _button1Color = Colors.blue; // Change button color
//                       _button2Color = Color.fromRGBO(232, 197, 163, 1);
//                     });
//                   },
//                   child: Text('Second floor'),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 2,
//               // children: _getTableList(_selectedTable),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

// class TableSelectionWidget extends StatefulWidget {
//   @override
//   _TableSelectionWidgetState createState() => _TableSelectionWidgetState();
// }

// class _TableSelectionWidgetState extends State<TableSelectionWidget> {
//   int _selectedTable = 1;
//   Color _button1Color = Colors.blue;
//   Color _button2Color = Colors.blue;

//   List<Widget> _getTableList(int tableNumber) {
//     List<Widget> tableList = [];

//     for (int i = 1; i <= 6; i++) {
//       tableList.add(
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Table $i',
//               style: TextStyle(fontSize: 24),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Guests: '),
//                 SizedBox(
//                   width: 50,
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     initialValue: '1',
//                     textAlign: TextAlign.center,
//                     onChanged: (value) {
//                       // Update the number of guests
//                     },
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Continue button pressed
//                   },
//                   child: Text('Continue'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     }

//     return tableList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 428,
//         height: 129,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _selectedTable = 1;
//                     _button1Color = Colors.red;
//                     _button2Color = Colors.blue;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: _button1Color,
//                 ),
//                 child: Text('Table 1'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _selectedTable = 2;
//                     _button1Color = Colors.blue;
//                     _button2Color = Colors.red;
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: _button2Color,
//                 ),
//                 child: Text('Table 2'),
//               ),
//             ],
//           ),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 2,
//               children: List.generate(
//                 6,
//                 (index) => GestureDetector(
//                   onTap: () {
//                     // Table selected
//                   },
//                   child: Container(
//                     margin: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.grey.shade200,
//                     ),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: 1,
//                       itemBuilder: (context, index) {
//                         return _getTableList(_selectedTable)[index];
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TableSelectionWidget extends StatefulWidget {
//   @override
//   _TableSelectionWidgetState createState() => _TableSelectionWidgetState();
// }

// class _TableSelectionWidgetState extends State<TableSelectionWidget> {
//   int _selectedTable = -1;
//   int _numGuests = 0;
//   List<int> _tableData = [2, 4, 6, 3, 5, 1];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 500,
//       child: Column(
//         children: [
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               padding: EdgeInsets.all(16),
//               itemCount: _tableData.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final int tableNumber = index + 1;
//                 final int numPeople = _tableData[index];
//                 final bool isSelected = _selectedTable == tableNumber;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedTable = tableNumber;
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.blue : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.table_chart,
//                             size: 48, color: isSelected ? Colors.white : Colors.black),
//                         Text(
//                           'Table $tableNumber',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: isSelected ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.remove, color: Colors.white),
//                               onPressed: () {
//                                 setState(() {
//                                   _tableData[index] =
//                                       (_tableData[index] - 1).clamp(0, 20);
//                                   if (isSelected) {
//                                     _numGuests =
//                                         (_numGuests - 1).clamp(0, 20);
//                                   }
//                                 });
//                               },
//                             ),
//                             Text(
//                               numPeople.toString(),
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: isSelected ? Colors.white : Colors.black,
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.add, color: Colors.white),
//                               onPressed: () {
//                                 setState(() {
//                                   _tableData[index] =
//                                       (_tableData[index] + 1).clamp(0, 20);
//                                   if (isSelected) {
//                                     _numGuests =
//                                         (_numGuests + 1).clamp(0, 20);
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Table $_selectedTable'),
//                 Text('Guests: $_numGuests'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TableSelectionWidget extends StatefulWidget {
//   @override
//   _TableSelectionWidgetState createState() => _TableSelectionWidgetState();
// }

// class _TableSelectionWidgetState extends State<TableSelectionWidget> {
//   int _selectedTable = -1;
//   int _numGuests = 0;
//   List<int> _tableDataFirstFloor = [2, 4, 6, 3, 5, 1];
//   List<int> _tableDataSecondFloor = [8, 9, 10, 7, 11, 12];

//   List<int> _getTableDataForSelectedFloor() {
//     if (_selectedFloor == 1) {
//       return _tableDataFirstFloor;
//     } else {
//       return _tableDataSecondFloor;
//     }
//   }

//   int _selectedFloor = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 600,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _selectedFloor = 1;
//                     _selectedTable = -1;
//                   });
//                 },
//                 child: Text('First Floor'),
//                 style: ElevatedButton.styleFrom(
//                   primary: _selectedFloor == 1 ? Colors.blue : Colors.grey[300],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _selectedFloor = 2;
//                     _selectedTable = -1;
//                   });
//                 },
//                 child: Text('Second Floor'),
//                 style: ElevatedButton.styleFrom(
//                   primary: _selectedFloor == 2 ? Colors.blue : Colors.grey[300],
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               padding: EdgeInsets.all(16),
//               itemCount: _getTableDataForSelectedFloor().length,
//               itemBuilder: (BuildContext context, int index) {
//                 final int tableNumber = index + 1;
//                 final int numPeople = _getTableDataForSelectedFloor()[index];
//                 final bool isSelected = _selectedTable == tableNumber;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _selectedTable = tableNumber;
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.blue : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.table_chart,
//                             size: 48,
//                             color: isSelected ? Colors.white : Colors.black),
//                         Text(
//                           'Table $tableNumber',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: isSelected ? Colors.white : Colors.black,
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.remove, color: Colors.white),
//                               onPressed: () {
//                                 setState(() {
//                                   final tableData =
//                                       _getTableDataForSelectedFloor();
//                                   tableData[index] =
//                                       (tableData[index] - 1).clamp(0, 20);
//                                   if (isSelected) {
//                                     _numGuests = (_numGuests - 1).clamp(0, 20);
//                                   }
//                                 });
//                               },
//                             ),
//                             Text(
//                               numPeople.toString(),
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: isSelected ? Colors.white : Colors.black,
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.add, color: Colors.white),
//                               onPressed: () {
//                                 setState(() {
//                                   final tableData =
//                                       _getTableDataForSelectedFloor();
//                                   tableData[index] =
//                                       (tableData[index] + 1).clamp(0, 20);
//                                   if (isSelected) {
//                                     _numGuests = (_numGuests + 1).clamp(0, 20);
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           _selectedTable != -1
//               ? Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     'Table $_selectedTable guests: $_numGuests',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }
