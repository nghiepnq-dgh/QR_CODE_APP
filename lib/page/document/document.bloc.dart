import 'package:flutter/material.dart';
import 'package:qr_code_app/page/document/document.repository.dart';
import 'package:qr_code_app/page/document/model/doc_detail.model.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';
import 'package:qr_code_app/util/toast.message.dart';

class DocumentBloc extends ChangeNotifier {
  final DocumentRepository _documentRepository = DocumentRepository();

  listDocuments(query) async {
    query['page'] = 1;
    query['limit'] = 20;
    DocumentsResponse documentsResponse =
        await _documentRepository.listDocumentsReposi(query);
    if (documentsResponse?.data != null) {
      return documentsResponse;
    } else {
      ToastMessage.error(message: documentsResponse.message);
      return documentsResponse;
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
}

final blocDocumentModule = DocumentBloc();
