import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/page/document/document.bloc.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';
import 'package:qr_code_app/util/Functions.dart';
import 'package:qr_code_app/util/ImgPath.dart';
import 'package:qr_code_app/util/Key.dart';

class ListItemDoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Object>(builder: (context, value, child) {
      if (value != null) {
        DocumentsResponse item = value;
        return RefreshIndicator(
          onRefresh: (){},
          key: KeyOption.item_doc,
                  child: ListView.builder(
              itemCount: item?.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  title: Container(
                    decoration: new BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5)),
                    ),
                    height: 55.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 6,
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
                                      item?.data[index].id,
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    Text(
                                      "Chủ hồ sơ: ${item?.data[index]?.user?.identity}",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    Text(
                                      "Email: ${item?.data[index]?.user?.email}",
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
                                  color: item?.data[index].status == "NEW"
                                      ? Colors.green
                                      : item?.data[index].status == "APPROVED"
                                          ? Colors.blue
                                          : Colors.red[200],
                                  borderRadius:
                                      BorderRadiusDirectional.circular(7.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  FunctionsUtil.convertStatus(
                                      item?.data[index].status),
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
        );
      }
      return Center(
        child: Text("Empty data"),
      );
    });
  }
}
