import 'package:qr_code_app/ApiProvider.dart';
import 'package:qr_code_app/page/document/model/doc_detail.model.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';

class DocumentRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<DocumentsResponse> listDocumentsReposi(query) {
    return _apiProvider.listDocuments(query);
  }

  Future<DocumentDetailResponse>getDetailDoc(id) {
    return _apiProvider.getDocId(id);
  }


  Future<DocumentDetailResponse>updateDoc(id, data) {
    return _apiProvider.updateDoc(id, data);
  }
}
