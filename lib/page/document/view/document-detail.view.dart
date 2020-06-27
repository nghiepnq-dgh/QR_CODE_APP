import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/page/document/document.bloc.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';
import 'package:qr_code_app/page/document/view/list_item_doc.view.dart';

class DocumentPage extends StatefulWidget {
  DocumentPage({Key key}) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  Map<String, dynamic> object = new Map();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Danh sách hồ sơ",
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(Icons.camera),
          //     tooltip: "Scan",
          //   )
          // ],
          bottom: PreferredSize(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    height: 40.0,
                    child: TextField(
                      onChanged: (text) {
                        object['id'] = text;
                        blocDocumentModule.listDocuments(object);
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[400],
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(35.0))),
                          labelText: "Tìm kiếm",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
              preferredSize: const Size.fromHeight(50.0)),
        ),
        body: Container(),
      ),
    );
  }
}

