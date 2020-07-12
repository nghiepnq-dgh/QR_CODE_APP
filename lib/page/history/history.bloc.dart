import 'package:flutter/material.dart';
import 'package:qr_code_app/page/history/history.repository.dart';
import 'package:qr_code_app/page/history/model/list-history.model.dart';
import 'package:qr_code_app/util/toast.message.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class HistoryBloc with ChangeNotifier {
  HistoryBloc() {
    getListHistory();
  }
  final HistoryRepository _historyRepository = HistoryRepository();
  Stream<ListHistoryRespone> get listHistoryStream => _listHistoryStream.stream;
  final _listHistoryStream = BehaviorSubject<ListHistoryRespone>();

  Future<ListHistoryRespone> getListHistory() async {
    Map<String, dynamic> query = new Map();
    query['page'] = 1;
    query['limit'] = 1000;
    ListHistoryRespone listHistoryRespone =
        await _historyRepository.listHistory(query);
    if (listHistoryRespone?.data != null) {
      _listHistoryStream.add(listHistoryRespone);
    } else {
      ToastMessage.error(message: listHistoryRespone?.message);
    }
  }

  @override
  void dispose() {
    _listHistoryStream.close();
    super.dispose();
  }
}
