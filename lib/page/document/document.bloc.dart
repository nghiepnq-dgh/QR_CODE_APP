import 'package:flutter/material.dart';
import 'package:qr_code_app/page/document/document.repository.dart';
import 'package:qr_code_app/page/document/model/doc_detail.model.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';
import 'package:qr_code_app/util/toast.message.dart';
import 'package:rxdart/rxdart.dart';
class DocumentBloc extends ChangeNotifier {
  DocumentBloc() {
    listDocuments();
  }

  Sink<dynamic> get onChangeText =>_documents.sink;
  final DocumentRepository _documentRepository = DocumentRepository();
  Stream<DocumentsResponse> get documents => _documents.stream;
  final _documents = BehaviorSubject<DocumentsResponse>();

  Future<DocumentsResponse> listDocuments() async {
    final Map<String, dynamic> query = new Map();
    query['page'] = 1;
    query['limit'] = 1000;
    DocumentsResponse documentsResponse =
        await _documentRepository.listDocumentsReposi(query);
    if (documentsResponse?.data != null) {
      _documents.add(documentsResponse);
    } else {
      ToastMessage.error(message: documentsResponse.message);
    }
  }

  getDetailDoc(id) async {
    DocumentDetailResponse documentDetailResponse =
        await _documentRepository.getDetailDoc(id);
    if (documentDetailResponse?.id != null) {
      return documentDetailResponse;
    } else {
      ToastMessage.error(message: documentDetailResponse.message);
      return null;
    }
  }

  updateDoc(id, data) async {
    DocumentDetailResponse documentDetailResponse =
        await _documentRepository.updateDoc(id, data);
    if (documentDetailResponse?.error == null) {
      ToastMessage.success(message: 'Chỉnh sửa thành công');
      return documentDetailResponse;
    } else {
      ToastMessage.error(message: documentDetailResponse.message);
      return documentDetailResponse;
    }
  }

  @override
  void dispose() {
    _documents.close();
    super.dispose();
  }
}