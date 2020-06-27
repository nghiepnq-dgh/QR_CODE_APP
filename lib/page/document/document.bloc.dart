import 'package:flutter/material.dart';
import 'package:qr_code_app/page/document/document.repository.dart';
import 'package:qr_code_app/page/document/model/list_doc.model.dart';
import 'package:qr_code_app/util/toast.message.dart';

class DocumentBloc extends ChangeNotifier {
  final DocumentRepository _documentRepository = DocumentRepository();
  listDocuments(query) async {
    DocumentsResponse documentsResponse = await _documentRepository.listDocumentsReposi(query);
    if (documentsResponse?.data != null) {
      // return documentsResponse;
      return documentsResponse;
    }
    else {
      ToastMessage.error(message: documentsResponse.message);
      return documentsResponse;
    }
  }
}

final blocDocumentModule = DocumentBloc();