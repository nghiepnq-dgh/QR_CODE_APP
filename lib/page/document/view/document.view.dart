import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/page/document/document.bloc.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';
import 'package:qr_code_app/page/document/view/document-detail.view.dart';
import 'package:qr_code_app/util/Functions.dart';
import 'package:qr_code_app/util/ImgPath.dart';
import 'package:qr_code_app/util/Key.dart';
import 'package:qr_code_app/util/LocalStored.dart';

class DocumentPage extends StatelessWidget {
  Map<String, dynamic> object = new Map();
  @override
  Widget build(BuildContext context) {
    final DocumentBloc bloc = Provider.of<DocumentBloc>(context, listen: false);
    return SafeArea(
        child: Scaffold(
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
                            object['document_id'] = text;
                            DocumentBloc().onChangeText.add(object);
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
            body: buildBody(context, bloc, object)));
  }

  buildBody(BuildContext context, DocumentBloc bloc, Map object) {
    return StreamBuilder<DocumentsResponse>(
        stream: bloc.documents,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentsResponse> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Container(
              child: Text('Đã xảy ra lỗi trong lúc lấy dữ liệu !'),
            );
          }
          if (snapshot.hasData) {
            return ListItemDoc(object: snapshot?.data);
          }
          return Container();
        });
  }
}

class ListItemDoc extends StatefulWidget {
  final DocumentsResponse object;
  ListItemDoc({this.object});

  @override
  _ListItemDocState createState() => _ListItemDocState();
}

class _ListItemDocState extends State<ListItemDoc> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            final DocumentBloc bloc = Provider.of<DocumentBloc>(context, listen: false);
            bloc.documents;
          },
          key: KeyOption.item_doc,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget?.object?.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    final user = await LocalStore.getUserInfor();
                    final userInfo = json.decode(user);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocumentDetail(
                              widget?.object?.data[index].id, userInfo)),
                    );
                  },
                  title: Container(
                    decoration: new BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5)),
                    ),
                    height: 55.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                Image(
                                  image: AssetImage(ImgPath.logo),
                                  height: 30.0,
                                  width: 30.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      widget?.object?.data[index].id,
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    Text(
                                      "Chủ hồ sơ: ${widget?.object?.data[index]?.user?.identity}",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    Text(
                                      "Email: ${widget?.object?.data[index]?.user?.email}",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    )
                                  ],
                                )
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: new BoxDecoration(
                                  color: widget?.object?.data[index].status ==
                                          "NEW"
                                      ? Colors.green
                                      : widget?.object?.data[index].status ==
                                              "APPROVED"
                                          ? Colors.blue
                                          : widget?.object?.data[index]
                                                      .status ==
                                                  "REJECTED"
                                              ? Colors.red[200]
                                              : widget?.object?.data[index]
                                                          .status ==
                                                      "WAITTING"
                                                  ? Colors.green[200]
                                                  : Colors.orange[200],
                                  borderRadius:
                                      BorderRadiusDirectional.circular(7.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  FunctionsUtil.convertStatus(
                                      widget?.object?.data[index].status),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.0),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
