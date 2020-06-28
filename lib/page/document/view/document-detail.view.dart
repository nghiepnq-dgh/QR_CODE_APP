import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/page/document/document.bloc.dart';
import 'package:qr_code_app/page/document/model/doc_detail.model.dart';
import 'package:qr_code_app/util/Functions.dart';

class DocumentDetail extends StatefulWidget {
  final docId;
  DocumentDetail(this.docId);
  @override
  _DocumentDetailState createState() => _DocumentDetailState();
}

class _DocumentDetailState extends State<DocumentDetail> {
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
              "Chi tiết hồ sơ",
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
          body: FutureProvider<Object>.value(
            value: blocDocumentModule.getDetailDoc(widget.docId),
            child: ValidateDocument(),
          )),
    );
  }
}

class ValidateDocument extends StatelessWidget {
  final object = {};
  
  @override
  Widget build(BuildContext context) {
    return Consumer<Object>(builder: (context, value, child) {
      if (value != null) {
        DocumentDetailResponse data = value;
        TextEditingController reason = new TextEditingController(text: data?.reason);
        return RefreshIndicator(
          onRefresh: () {},
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 4,
                            child: Row(
                              children: <Widget>[
                                Text('Mã hồ sơ: '),
                                Text(
                                  data?.id,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: data.status == "NEW"
                                      ? Colors.green
                                      : data.status == "APPROVED"
                                          ? Colors.blue
                                          : Colors.red[200],
                                  borderRadius:
                                      BorderRadiusDirectional.circular(7.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  FunctionsUtil.convertStatus(data.status),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Email người sở hữu: '),
                            Text(
                              data?.user?.email,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text('CMND người sở hữu: '),
                            Text(
                              data?.user?.identity,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    TextFormField(
                      controller: reason,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Mô tả về hồ sơ'),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: RawMaterialButton(
                              fillColor: Colors.redAccent[100],
                              splashColor: Colors.greenAccent,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.healing,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Từ chối",
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                object['status'] = "REJECTED";
                                object['reason'] = reason.text;
                                blocDocumentModule.updateDoc(data.id, object);
                              },
                              shape: const StadiumBorder(),
                            )),
                        Expanded(
                            flex: 1,
                            child: RawMaterialButton(
                              fillColor: Colors.lightBlueAccent,
                              splashColor: Colors.greenAccent,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Giải quyết",
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                object['status'] = "APPROVED";
                                object['reason'] = reason.text;
                                blocDocumentModule.updateDoc(data.id, object);
                              },
                              shape: const StadiumBorder(),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
      return Center(
        child: Text("Empty data"),
      );
    });
  }
}
