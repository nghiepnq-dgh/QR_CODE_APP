import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/page/history/history.bloc.dart';
import 'package:qr_code_app/page/history/model/list-history.model.dart';
import 'package:qr_code_app/util/Functions.dart';

class PageListHistoryDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HistoryBloc bloc = Provider.of<HistoryBloc>(context);
    return SafeArea(child: Scaffold(body: buildBody(context, bloc)));
  }

  buildBody(BuildContext context, HistoryBloc bloc) {
    return StreamBuilder<ListHistoryRespone>(
        stream: bloc.listHistoryStream,
        builder:
            (BuildContext context, AsyncSnapshot<ListHistoryRespone> snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Container(
              child: Text('Đã xảy ra lỗi trong lúc lấy dữ liệu !'),
            );
          }
          if (snapshot.hasData) {
            return ListItemHistory(snapshot?.data);
          }
          return Container();
        });
  }
}

class ListItemHistory extends StatefulWidget {
  final ListHistoryRespone listHistory;
  ListItemHistory(this.listHistory);
  @override
  _ListItemHistoryState createState() => _ListItemHistoryState();
}

class _ListItemHistoryState extends State<ListItemHistory> {
  @override
  void initState() {
    super.initState();
  }
 Future<Null> _refresh() async {
    HistoryBloc().getListHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
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
            "Lich Sử Tìm Kiếm",
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            _refresh();
          },
                  child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
                itemCount: widget?.listHistory?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    title: Container(
                      decoration: new BoxDecoration(
                        border: Border(bottom: BorderSide(width: 0.5)),
                      ),
                      height: 80.0,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            widget?.listHistory?.data[index]
                                                    .document?.id
                                                    .toString() ??
                                                "---",
                                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Chủ hồ sơ: ${widget?.listHistory?.data[index].user?.identity}",
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                          Text(
                                            "Email: ${widget?.listHistory?.data[index].user?.email}",
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
                                        color: widget?.listHistory?.data[index]
                                                    .document?.status ==
                                                "NEW"
                                            ? Colors.green
                                            : widget?.listHistory?.data[index]
                                                        .document?.status ==
                                                    "APPROVED"
                                                ? Colors.blue
                                                : Colors.red[200],
                                        borderRadius:
                                            BorderRadiusDirectional.circular(7.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Text(
                                        FunctionsUtil.convertStatus(widget
                                            ?.listHistory
                                            ?.data[index]
                                            .document
                                            ?.status),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13.0),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 1.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Ngày tìm: ${widget?.listHistory?.data[index].createdAt}",
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
