import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  int _selectedFloor = 1;
  int _selectedTable = -1;
  int _numGuests = 0;

  List<int> _floor1TableData = List.generate(20, (_) => 0);
  List<int> _floor2TableData = List.generate(20, (_) => 0);

  List<int> _getTableDataForSelectedFloor() {
    if (_selectedFloor == 1) {
      return _floor1TableData;
    } else {
      return _floor2TableData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tables'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedFloor = 1;
                    _selectedTable = -1;
                  });
                },
                child: Text('First Floor'),
                style: ElevatedButton.styleFrom(
                  primary:
                      _selectedFloor == 1 ? Colors.green : Colors.grey.shade400,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedFloor = 2;
                    _selectedTable = -1;
                  });
                },
                child: Text('Second Floor'),
                style: ElevatedButton.styleFrom(
                  primary:
                      _selectedFloor == 2 ? Colors.green : Colors.grey.shade400,
                ),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              final tableData = _getTableDataForSelectedFloor();
              final isSelected = _selectedTable == index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTable = isSelected ? -1 : index + 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isSelected ? Colors.green : Colors.grey.shade400,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.table_chart,
                          color: isSelected ? Colors.white : Colors.black),
                      SizedBox(height: 8),
                      Text(
                        'Table ${index + 1}',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                final tableData =
                                    _getTableDataForSelectedFloor();
                                tableData[index] =
                                    (tableData[index] - 1).clamp(0, 20);
                                if (isSelected) {
                                  _numGuests = tableData[index];
                                }
                              });
                            },
                          ),
                          Text(
                            tableData[index].toString(),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                final tableData =
                                    _getTableDataForSelectedFloor();
                                tableData[index] =
                                    (tableData[index] + 1).clamp(0, 20);
                                if (isSelected) {
                                  _numGuests = tableData[index];
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Selected Table: ${_selectedTable != -1 ? "Table $_selectedTable, Guests: $_numGuests" : "None"}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
