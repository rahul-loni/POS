import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:blue_print_pos/blue_print_pos.dart';
import 'package:blue_print_pos/models/blue_device.dart';
import 'package:blue_print_pos/models/connection_status.dart';
import 'package:blue_print_pos/receipt/receipt_section_text.dart';
import 'package:blue_print_pos/receipt/receipt_text_size_type.dart';
import 'package:blue_print_pos/receipt/receipt_text_style_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as RB;

import '../../model/getproduct.dart';
import '../home/homescreen.dart';
import 'bill_print_sucess.dart';

// class BillPrintPage extends StatefulWidget {
//   const BillPrintPage({Key? key,}) : super(key: key);

//   @override
//   State<BillPrintPage> createState() => _BillPrintPageState();
// }
class BillPrintPage extends StatefulWidget {
  final String totalPrice;
  final String productPrice;
  final String productName;
  final List<Products> selectedProducts;
  final int orderId;

  const BillPrintPage({
    Key? key,
    required this.totalPrice,
    required this.productPrice,
    required this.productName,
    required this.selectedProducts,
    required this.orderId,
  }) : super(key: key);

  @override
  State<BillPrintPage> createState() => _BillPrintPageState();
}

class _BillPrintPageState extends State<BillPrintPage> {
  final BluePrintPos _bluePrintPos = BluePrintPos.instance;
  List<BlueDevice> _blueDevices = <BlueDevice>[];
  BlueDevice? _selectedDevice;
  bool _isLoading = false;
  int _loadingAtIndex = -1;

  // BLE weighing
  final flutterReactiveBle = RB.FlutterReactiveBle();
  RB.DiscoveredDevice? deviceChipseaBle;
  String mButtonText = "Connect ";
  String mWeighingReading = "---";
  String mUnit = "no";

  @override
  void initState() {
    super.initState();
    (WidgetsBinding.instance).addPostFrameCallback((_) async {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onScanPressed() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
      if (statuses[Permission.bluetoothScan] != PermissionStatus.granted ||
          statuses[Permission.bluetoothConnect] != PermissionStatus.granted) {
        return;
      }
    }

    setState(() => _isLoading = true);
    _bluePrintPos.scan().then((List<BlueDevice> devices) {
      if (devices.isNotEmpty) {
        setState(() {
          _blueDevices = devices;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onDisconnectDevice() {
    _bluePrintPos.disconnect().then((ConnectionStatus status) {
      if (status == ConnectionStatus.disconnect) {
        setState(() {
          _selectedDevice = null;
        });
      }
    });
  }

  void _onSelectDevice(int index) {
    setState(() {
      _isLoading = true;
      _loadingAtIndex = index;
    });
    final BlueDevice blueDevice = _blueDevices[index];
    _bluePrintPos.connect(blueDevice).then((ConnectionStatus status) {
      if (status == ConnectionStatus.connected) {
        setState(() => _selectedDevice = blueDevice);
      } else if (status == ConnectionStatus.timeout) {
        _onDisconnectDevice();
      } else {
        if (kDebugMode) {
          print('$runtimeType - something wrong');
        }
      }
      setState(() => _isLoading = false);
    });
  }

  // Future<void> _onPrintReceipt() async {
  //   /// Example for Print Imagae , add your compnay logo hera
  //   final ByteData logoBytes = await rootBundle.load(
  //     'assets/logo.jpg',
  //   );

  //   /// Example for Print Text
  //   final ReceiptSectionText receiptText = ReceiptSectionText();
  //   receiptText.addImage(
  //     base64.encode(Uint8List.view(logoBytes.buffer)),
  //     width: 300,
  //   );
  //   receiptText.addSpacer();
  //   receiptText.addText(
  //     'EXCEED YOUR VISION',
  //     size: ReceiptTextSizeType.medium,
  //     style: ReceiptTextStyleType.bold,
  //   );
  //   receiptText.addText(
  //     'MC Koo',
  //     size: ReceiptTextSizeType.small,
  //   );
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText('Time', '04/06/22, 10:30');
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText(
  //     'Apple 4pcs',
  //     '\$ 10.00',
  //     leftStyle: ReceiptTextStyleType.normal,
  //     rightStyle: ReceiptTextStyleType.bold,
  //   );
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText(
  //     'TOTAL',
  //     '\$ 10.00',
  //     leftStyle: ReceiptTextStyleType.normal,
  //     rightStyle: ReceiptTextStyleType.bold,
  //   );
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText(
  //     'Payment',
  //     'Cash',
  //     leftStyle: ReceiptTextStyleType.normal,
  //     rightStyle: ReceiptTextStyleType.normal,
  //   );
  //   receiptText.addSpacer(count: 2);

  //   await _bluePrintPos.printReceiptText(receiptText);

  //   /// Example for print QR
  //   await _bluePrintPos.printQR('https://www.google.com/', size: 250);

  //   /// Text after QR
  //   final ReceiptSectionText receiptSecondText = ReceiptSectionText();
  //   receiptSecondText.addText('Powered by Google',
  //       size: ReceiptTextSizeType.small);
  //   receiptSecondText.addSpacer();
  //   await _bluePrintPos.printReceiptText(receiptSecondText, feedCount: 1);
  // }

  // Use this for checking and single print Dont remove this code

  // Future<void> _onPrintReceipt() async {
  //   final ByteData logoBytes = await rootBundle.load('assets/logo.jpg');

  //   final ReceiptSectionText receiptText = ReceiptSectionText();
  //   receiptText.addImage(
  //     base64.encode(Uint8List.view(logoBytes.buffer)),
  //     width: 300,
  //   );
  //   receiptText.addSpacer();
  //   receiptText.addText(
  //     'EXCEED YOUR VISION',
  //     size: ReceiptTextSizeType.medium,
  //     style: ReceiptTextStyleType.bold,
  //   );
  //   receiptText.addText(
  //     'MC Koo',
  //     size: ReceiptTextSizeType.small,
  //   );
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText('Time', '04/06/22, 10:30');
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText(
  //     widget.productName,
  //     'Rs.${widget.productPrice}',
  //     leftStyle: ReceiptTextStyleType.normal,
  //     rightStyle: ReceiptTextStyleType.bold,
  //   );
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText(
  //     'TOTAL',
  //     'Rs.${widget.totalPrice}',
  //     leftStyle: ReceiptTextStyleType.normal,
  //     rightStyle: ReceiptTextStyleType.bold,
  //   );
  //   receiptText.addSpacer(useDashed: true);
  //   receiptText.addLeftRightText(
  //     'Payment',
  //     'Cash',
  //     leftStyle: ReceiptTextStyleType.normal,
  //     rightStyle: ReceiptTextStyleType.normal,
  //   );
  //   receiptText.addSpacer(count: 2);

  //   await _bluePrintPos.printReceiptText(receiptText);

  //   await _bluePrintPos.printQR('https://www.google.com/', size: 250);

  //   final ReceiptSectionText receiptSecondText = ReceiptSectionText();
  //   receiptSecondText.addText('Powered by Google',
  //       size: ReceiptTextSizeType.small);
  //   receiptSecondText.addSpacer();
  //   await _bluePrintPos.printReceiptText(receiptSecondText, feedCount: 1);
  // }

  // for multiple product
  Future<void> _onPrintReceipt() async {
    final ByteData logoBytes = await rootBundle.load('assets/logo.jpg');

    final ReceiptSectionText receiptText = ReceiptSectionText();
    receiptText.addImage(
      base64.encode(Uint8List.view(logoBytes.buffer)),
      width: 300,
    );
    receiptText.addSpacer();
    receiptText.addText(
      'EXCEED YOUR VISION',
      size: ReceiptTextSizeType.medium,
      style: ReceiptTextStyleType.bold,
    );
    receiptText.addText(
      'MC Koo',
      size: ReceiptTextSizeType.small,
    );
    receiptText.addSpacer(useDashed: true);

    for (final product in widget.selectedProducts) {
      receiptText.addLeftRightText(
        '${product.name} ${product.quantity}x',
        'Rs.${product.price * product.quantity}',
        leftStyle: ReceiptTextStyleType.normal,
        rightStyle: ReceiptTextStyleType.bold,
      );
    }

    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText(
      'TOTAL',
      'Rs.${widget.totalPrice.toString()}',
      leftStyle: ReceiptTextStyleType.normal,
      rightStyle: ReceiptTextStyleType.bold,
    );
    receiptText.addSpacer(useDashed: true);
    receiptText.addLeftRightText(
      'Payment',
      'Cash',
      leftStyle: ReceiptTextStyleType.normal,
      rightStyle: ReceiptTextStyleType.normal,
    );
    receiptText.addSpacer(count: 2);

    await _bluePrintPos.printReceiptText(receiptText);

    final ReceiptSectionText receiptSecondText = ReceiptSectionText();
    receiptSecondText.addText('Powered by Sagar Sedhai',
        size: ReceiptTextSizeType.small);
    receiptSecondText.addSpacer();
    await _bluePrintPos.printReceiptText(receiptSecondText, feedCount: 1);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BillPrintSuccessPage(
                orderId: widget.orderId,
              )),
    );
    //Use this if there is error above
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => HomeScreen(
    //             orderId: widget.orderId,
    //           )),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bill Print',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: _isLoading && _blueDevices.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : _blueDevices.isNotEmpty
                ? SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Weight (" + mUnit + ")",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            mWeighingReading,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 48),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            child: Text(
                              mButtonText,
                            ),
                            onPressed: () {
                              setState(() {
                                mButtonText = "Connecting...";
                              });

                              flutterReactiveBle.scanForDevices(
                                withServices: [],
                                scanMode: RB.ScanMode.lowLatency,
                              ).listen((device) async {
                                //code for handling results
                                if (deviceChipseaBle == null &&
                                    device.name == "Chipsea-BLE") {
                                  deviceChipseaBle = device;

                                  flutterReactiveBle
                                      .connectToDevice(
                                    id: device.id,
                                    servicesWithCharacteristicsToDiscover: null,
                                    connectionTimeout:
                                        const Duration(seconds: 2),
                                  )
                                      .listen((connectionState) {
                                    // Handle connection state updates
                                    String _connectionStatus = "---";
                                    switch (connectionState.connectionState) {
                                      case RB.DeviceConnectionState.connected:
                                        _connectionStatus =
                                            "Connected Chipsea-BLE";
                                        break;
                                      case RB.DeviceConnectionState.connecting:
                                        _connectionStatus = "Connecting...";
                                        break;
                                      case RB
                                          .DeviceConnectionState.disconnected:
                                        _connectionStatus = "Disconnected";
                                        break;
                                      case RB
                                          .DeviceConnectionState.disconnecting:
                                        _connectionStatus = "Disconnecting...";
                                        break;
                                      default:
                                        break;
                                    }

                                    setState(() {
                                      mButtonText = _connectionStatus;
                                    });
                                  }, onError: (Object error) {
                                    // Handle a possible error
                                  });

                                  List<RB.DiscoveredService> services =
                                      await flutterReactiveBle.discoverServices(
                                    device.id,
                                  );

                                  final characteristic =
                                      RB.QualifiedCharacteristic(
                                    serviceId: RB.Uuid.parse("FFF0"),
                                    characteristicId: RB.Uuid.parse("fff1"),
                                    deviceId: device.id,
                                  );
                                  flutterReactiveBle
                                      .subscribeToCharacteristic(characteristic)
                                      .listen((data) {
                                    // code to handle incoming data
                                    if (data.isNotEmpty) {
                                      List<int> _dataReading =
                                          data.sublist(0, 6);
                                      int _dataAttribute = data[6];
                                      int _dataDecimalPoint =
                                          _dataAttribute & 0x07;
                                      int _dataUnit = _dataAttribute & 0x38;

                                      String _reading =
                                          String.fromCharCodes(_dataReading);
                                      if (_reading.isNotEmpty) {
                                        int decimalPointAt =
                                            _reading.length - _dataDecimalPoint;
                                        String _readingFront = _reading
                                            .substring(0, decimalPointAt);
                                        String _readingBack =
                                            _reading.substring(decimalPointAt);

                                        String _unit = "no";
                                        if (_dataUnit == 8) {
                                          _unit = "kg";
                                        } else if (_dataUnit == 16) {
                                          _unit = "lb";
                                        } else if (_dataUnit == 24) {
                                          _unit = "oz";
                                        } else if (_dataUnit == 32) {
                                          _unit = "g";
                                        }

                                        setState(() {
                                          mWeighingReading = _readingFront +
                                              "." +
                                              _readingBack;
                                          mUnit = _unit;
                                        });
                                      }
                                    }
                                  }, onError: (dynamic error) {
                                    // code to handle errors
                                  });
                                }
                              }, onError: (err) {
                                //code for handling error
                              });
                            },
                          ),
                        ),
                        Column(
                          children: List<Widget>.generate(_blueDevices.length,
                              (int index) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: _blueDevices[index].address ==
                                            (_selectedDevice?.address ?? '')
                                        ? _onDisconnectDevice
                                        : () => _onSelectDevice(index),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _blueDevices[index].name,
                                            style: TextStyle(
                                              color: _selectedDevice?.address ==
                                                      _blueDevices[index]
                                                          .address
                                                  ? Colors.blue
                                                  : Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            _blueDevices[index].address,
                                            style: TextStyle(
                                              color: _selectedDevice?.address ==
                                                      _blueDevices[index]
                                                          .address
                                                  ? Colors.blueGrey
                                                  : Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (_loadingAtIndex == index && _isLoading)
                                  Container(
                                    height: 24.0,
                                    width: 24.0,
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child: const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blue,
                                      ),
                                    ),
                                  ),
                                if (!_isLoading &&
                                    _blueDevices[index].address ==
                                        (_selectedDevice?.address ?? ''))
                                  TextButton(
                                    onPressed: _onPrintReceipt,
                                    child: Container(
                                      color: _selectedDevice == null
                                          ? Colors.grey
                                          : Colors.blue,
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text(
                                        'Test Print',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5);
                                          }
                                          return Theme.of(context).primaryColor;
                                        },
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          'Scan bluetooth device',
                          style: TextStyle(fontSize: 24, color: Colors.blue),
                        ),
                        Text(
                          'Press button scan',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _onScanPressed,
        child: const Icon(Icons.search),
        backgroundColor: _isLoading ? Colors.grey : Colors.blue,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
