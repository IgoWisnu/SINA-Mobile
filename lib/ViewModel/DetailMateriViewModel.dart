import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';



class DetailMateriMuridViewModel extends ChangeNotifier {
  bool isDownloading = false;
  String? localFilePath;

  Future<void> downloadFile(String url) async {
    try {
      isDownloading = true;
      notifyListeners();

      final dir = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final filePath = '${dir.path}/$fileName';

      await Dio().download(url, filePath);
      localFilePath = filePath;
    } catch (e) {
      rethrow;
    } finally {
      isDownloading = false;
      notifyListeners();
    }
  }
}