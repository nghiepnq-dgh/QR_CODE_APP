import 'package:qr_code_app/ApiProvider.dart';
import 'package:qr_code_app/page/history/model/list-history.model.dart';

class HistoryRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ListHistoryRespone> listHistory() {
    return _apiProvider.listHistory();
  }
}
