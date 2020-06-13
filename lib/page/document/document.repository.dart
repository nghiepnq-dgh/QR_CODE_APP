import 'package:qr_code_app/ApiProvider.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';

class DocumentRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<DocumentsResponse> listDocumentsReposi() {
    return _apiProvider.listDocuments();
  }
}
