import 'package:flutter/material.dart';
import 'package:qr_code_app/page/login/login.bloc.dart';
import 'package:qr_code_app/page/main_drawer/dart/drawer.view.dart';
import 'package:qr_code_app/page/user/model/user_me.dart';
import 'package:qr_code_app/router/route_generator.dart';
import 'package:qr_code_app/util/Key.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

import 'package:qr_code_app/util/LocalStored.dart';

class HomePage extends StatefulWidget {
//  var userInfor;
//  HomePage({Key key, this.userInfor}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScanResult scanResult;
  final _flashOnController = TextEditingController(text: "Bật Flash");
  final _flashOffController = TextEditingController(text: "Tắt Flash");
  final _cancelController = TextEditingController(text: "Huỷ");

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;
  var userInfo;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => getUserInfo());
  }

  Future<void> getUserInfo() async {
    userInfo = await LocalStore.getUserInfor();
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();
    setState(() {});
    var contentList = <Widget>[
      if (scanResult != null)
        Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Kết quả"),
                subtitle: Text(scanResult.type?.toString() ?? ""),
              ),
              ListTile(
                title: Text("Nội dung"),
                subtitle: Text(scanResult.rawContent ?? ""),
              ),
              ListTile(
                title: Text("Định dạng"),
                subtitle: Text(scanResult.format?.toString() ?? ""),
              ),
              ListTile(
                title: Text("Ghi chú định dạng"),
                subtitle: Text(scanResult.formatNote ?? ""),
              ),
            ],
          ),
        ),
      ListTile(
        title: Text("Lựa chọn Camera"),
        dense: true,
        enabled: false,
      ),
      RadioListTile(
        onChanged: (v) => setState(() => _selectedCamera = -1),
        value: -1,
        title: Text("Camera mặc định"),
        groupValue: _selectedCamera,
      ),
    ];

    ////
    for (var i = 0; i < _numberOfCameras; i++) {
      contentList.add(RadioListTile(
        onChanged: (v) => setState(() => _selectedCamera = i),
        value: i,
        title: Text("Camera ${i + 1}"),
        groupValue: _selectedCamera,
      ));
    }
//
//    contentList.addAll([
//      ListTile(
//        title: Text("Button Texts"),
//        dense: true,
//        enabled: false,
//      ),
//      ListTile(
//        title: TextField(
//          decoration: InputDecoration(
//            hasFloatingPlaceholder: true,
//            labelText: "Flash On",
//          ),
//          controller: _flashOnController,
//        ),
//      ),
//      ListTile(
//        title: TextField(
//          decoration: InputDecoration(
//            hasFloatingPlaceholder: true,
//            labelText: "Flash Off",
//          ),
//          controller: _flashOffController,
//        ),
//      ),
//      ListTile(
//        title: TextField(
//          decoration: InputDecoration(
//            hasFloatingPlaceholder: true,
//            labelText: "Cancel",
//          ),
//          controller: _cancelController,
//        ),
//      ),
//    ]);
//    /////

    if (Platform.isAndroid) {
      contentList.addAll([
        ListTile(
          title: Text("Tùy chọn cụ thể của Android"),
          dense: true,
          enabled: false,
        ),
        ListTile(
          title: Text(
              "Khả năng chịu đựng (${_aspectTolerance.toStringAsFixed(2)})"),
          subtitle: Slider(
            min: -1.0,
            max: 1.0,
            value: _aspectTolerance,
            onChanged: (value) {
              setState(() {
                _aspectTolerance = value;
              });
            },
          ),
        ),
        CheckboxListTile(
          title: Text("Sử dụng lấy nét tự động"),
          value: _useAutoFocus,
          onChanged: (checked) {
            setState(() {
              _useAutoFocus = checked;
            });
          },
        )
      ]);
    }

    contentList.addAll([
      ListTile(
        title: Text("Lựa chọn khác"),
        dense: true,
        enabled: false,
      ),
      CheckboxListTile(
        title: Text("Bất đầu với flash"),
        value: _autoEnableFlash,
        onChanged: (checked) {
          setState(() {
            _autoEnableFlash = checked;
          });
        },
      )
    ]);

    contentList.addAll([
      ListTile(
        title: Text("Định dạng mã vạch"),
        dense: true,
        enabled: false,
      ),
      ListTile(
        trailing: Checkbox(
          tristate: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: selectedFormats.length == _possibleFormats.length
              ? true
              : selectedFormats.length == 0 ? false : null,
          onChanged: (checked) {
            setState(() {
              selectedFormats = [
                if (checked ?? false) ..._possibleFormats,
              ];
            });
          },
        ),
        dense: true,
        enabled: false,
        title: Text("Phát hiện các định dạng mã vạch"),
        subtitle: Text(
          'Nếu tất cả không được chọn, tất cả các định dạng nền tảng có thể sẽ được sử dụng',
        ),
      ),
    ]);

    contentList.addAll(_possibleFormats.map(
      (format) => CheckboxListTile(
        value: selectedFormats.contains(format),
        onChanged: (i) {
          setState(() => selectedFormats.contains(format)
              ? selectedFormats.remove(format)
              : selectedFormats.add(format));
        },
        title: Text(format.toString()),
      ),
    ));

    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: KeyOption.home,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            "Trang chủ",
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              tooltip: "Scan",
              onPressed: scan,
            )
          ],
        ),

        drawer: Drawer(
          child:
          ListMenuProvider(),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: contentList,
        ),
      ),
    );
  }

  Future scan() async {
    try {
      var options = ScanOptions(
        strings: {
          "cancel": _cancelController.text,
          "flash_on": _flashOnController.text,
          "flash_off": _flashOffController.text,
        },
//          final _flashOnController = TextEditingController(text: "Bật Flash");
//      final _flashOffController = TextEditingController(text: "Tắt Flash");
//      final _cancelController = TextEditingController(text: "Huỷ");
        restrictFormat: selectedFormats,
        useCamera: _selectedCamera,
        autoEnableFlash: _autoEnableFlash,
        android: AndroidOptions(
          aspectTolerance: _aspectTolerance,
          useAutoFocus: _useAutoFocus,
        ),
      );

      var result = await BarcodeScanner.scan(options: options);

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      setState(() {
        scanResult = result;
      });
    }
  }
}
