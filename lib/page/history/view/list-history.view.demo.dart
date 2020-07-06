import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_app/page/history/history.bloc.dart';
import 'package:qr_code_app/page/history/model/list-history.model.dart';

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
  ListItemHistory(this.listHistory);
  final ListHistoryRespone listHistory;
  @override
  _ListItemHistoryState createState() => _ListItemHistoryState();
}

class _ListItemHistoryState extends State<ListItemHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.listHistory.toString()),
    );
  }
}
