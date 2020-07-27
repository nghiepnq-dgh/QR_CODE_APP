import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/page/document/document.bloc.dart';
import 'package:qr_code_app/page/document/model/doc_detail.model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qr_code_app/util/Functions.dart';

class DocumentDetail extends StatefulWidget {
  final docId;
  final user;
  DocumentDetail(this.docId, this.user);
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
            value: DocumentBloc().getDetailDoc(widget.docId),
            child: ValidateDocument(widget.user, widget.docId),
          )),
    );
  }
}

class ValidateDocument extends StatefulWidget {
  var user;
  final id;
  ValidateDocument(this.user, this.id);

  @override
  _ValidateDocumentState createState() => _ValidateDocumentState();
}

class _ValidateDocumentState extends State<ValidateDocument> {
  final object = {};

  String room;
  String status;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      DocumentDetailResponse document =
          await DocumentBloc().getDetailDoc(widget.id);
      setState(() {
        room = document?.room != null ? document.room : "Công chứng";
        status = document?.status != null ? document.status : "NEW";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Object>(builder: (context, value, child) {
      if (value != null) {
        DocumentDetailResponse data = value;
        TextEditingController reason =
            new TextEditingController(text: data?.reason);
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
                            flex: 3,
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
                            child: data?.user?.role == "NORMAL"
                                ? Container(
                                    decoration: new BoxDecoration(
                                        color: data.status == "NEW"
                                            ? Colors.green
                                            : data.status == "APPROVED"
                                                ? Colors.blue
                                                : data.status == "REJECTED"
                                                    ? Colors.red[200]
                                                    : data.status == "WAITTING"
                                                        ? Colors.green[200]
                                                        : Colors.orange[200],
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                7.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        FunctionsUtil.convertStatus(
                                            data.status),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  )
                                : DropdownButton<String>(
                                    value: status,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        status = newValue;
                                      });
                                      object['status'] = status;
                                      DocumentBloc().updateDoc(data.id, object);
                                    },
                                    items: <String>[
                                      'NEW',
                                      'WAITTING',
                                      'ADDINNFO',
                                      'APPROVED',
                                      'REJECTED',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                            FunctionsUtil.convertStatus(value)),
                                      );
                                    }).toList(),
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
                      height: 10.0,
                    ),
                    data?.user?.role != "NORMAL"
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 4, child: Text("Phòng trực thuộc:")),
                              Expanded(
                                  flex: 2,
                                  child: DropdownButton<String>(
                                    value: room,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        room = newValue;
                                      });
                                      object['room'] = room;
                                      DocumentBloc().updateDoc(data.id, object);
                                    },
                                    items: <String>[
                                      'Công chứng',
                                      'Địa chính',
                                      'Dân sự'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ))
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Text("Phòng xử lí: "),
                              Text(
                                data?.room != null ? data.room : "Trống",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    data?.user?.role != "NORMAL"
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: reason,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      labelText: 'Mô tả về hồ sơ:'),
                                ),
                              ),
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
                                          Text(
                                            "Gửi",
                                            maxLines: 1,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      object['reason'] = reason.text;
                                      DocumentBloc().updateDoc(data.id, object);
                                    },
                                    shape: const StadiumBorder(),
                                  )),
                            ],
                          )
                        : Row(
                            children: <Widget>[
                              Text("Mô tả: "),
                              Text(
                                data?.reason != null ? data.reason : "Trống",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Nội dung: "),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration:
                              new BoxDecoration(border: Border.all(width: 0.5)),
                          child: Html(
                            data: """
                                      ${data?.contend}
                                    """,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    // Text("${widget.user.toString()}"),
                    // widget.user['role'] != "NORMAL"
                    //     ? Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: <Widget>[
                    //           Expanded(
                    //               flex: 1,
                    //               child: RawMaterialButton(
                    //                 fillColor: Colors.redAccent[100],
                    //                 splashColor: Colors.greenAccent,
                    //                 child: Padding(
                    //                   padding: EdgeInsets.all(10.0),
                    //                   child: Row(
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: const <Widget>[
                    //                       Icon(
                    //                         Icons.healing,
                    //                         color: Colors.amber,
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10.0,
                    //                       ),
                    //                       Text(
                    //                         "Từ chối",
                    //                         maxLines: 1,
                    //                         style:
                    //                             TextStyle(color: Colors.white),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 onPressed: () {
                    //                   object['status'] = "REJECTED";
                    //                   object['reason'] = reason.text;
                    //                   DocumentBloc().updateDoc(data.id, object);
                    //                 },
                    //                 shape: const StadiumBorder(),
                    //               )),
                    //           Expanded(
                    //               flex: 1,
                    //               child: RawMaterialButton(
                    //                 fillColor: Colors.lightBlueAccent,
                    //                 splashColor: Colors.greenAccent,
                    //                 child: Padding(
                    //                   padding: EdgeInsets.all(10.0),
                    //                   child: Row(
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: const <Widget>[
                    //                       Icon(
                    //                         Icons.check_circle_outline,
                    //                         color: Colors.amber,
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10.0,
                    //                       ),
                    //                       Text(
                    //                         "Giải quyết",
                    //                         maxLines: 1,
                    //                         style:
                    //                             TextStyle(color: Colors.white),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 onPressed: () {
                    //                   object['status'] = "APPROVED";
                    //                   object['reason'] = reason.text;
                    //                   DocumentBloc().updateDoc(data.id, object);
                    //                 },
                    //                 shape: const StadiumBorder(),
                    //               )),
                    //         ],
                    //       )
                    //     : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Center(
          child: Text("Empty data"),
        );
      }
    });
  }
}
