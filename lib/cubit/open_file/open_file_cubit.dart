import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_chat/cubit/file_converter/file_upload_cubit.dart';

import '../../helper.dart';

part 'open_file_state.dart';

part 'open_file_cubit.freezed.dart';

class OpenFileCubit extends Cubit<OpenFileState> {
  OpenFileCubit() : super(const OpenFileState.initial());

  FileUploadCubit get fileUploadCubit => FileUploadCubit();

  Future<void> openFile(String fileName, String uid) async {
    emit(const OpenFileState.loading());
    Map<String, dynamic>? token = await fileUploadCubit.getToken();

    if (token != null) {
      _downloadAndOpenDocument(token, fileName, uid);
    }
  }

  Future<void> _downloadAndOpenDocument(
      token, String fileName, String uid) async {
    try {
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(minutes: 5),
      );
      final Dio dio5Minute = Dio(options);

      var url =
          'https://api.aspose.cloud/v4.0/words/storage/file/doc/${uid}/$fileName';
      var headers = {
        'Authorization': 'Bearer ${token['access_token']}',
      };

      ///
      /// Upload file ke aspose Cloud menggunakan metode put, menggunakan DIO
      ///
      final res = await dio5Minute.get(
        url,
        options: Options(headers: headers, responseType: ResponseType.bytes),
      );
      // final response =
      //     await _dio.get(url, options: Options(responseType: ResponseType.bytes));
      //
      if (res.statusCode == 200) {
        final appDir =
            await getExternalStorageDirectory(); // Use getApplicationDocumentsDirectory() for internal storage
        final file = File('${appDir?.path}/document.doc');
        await file.writeAsBytes(res.data);
        _openFile(file);
      } else {
        // Handle error response
        emit(OpenFileState.error(
            message: 'Error downloading the file ${res.statusCode}'));
        logger.e('Error downloading the file');
      }
    } catch (e) {
      // Handle Dio errors or other exceptions
      emit(OpenFileState.error(message: 'Error ${e.toString()}'));

      logger.e('Error: $e');
    }
  }

  Future<void> _openFile(File file) async {
    try {
      final result = await OpenFile.open(file.path);

      if (result.type == ResultType.done) {
        // File was opened successfully
      } else {
        emit(OpenFileState.error(
            message: 'Error opening the file ${result.type}'));
        // Handle other result types (e.g., result.type == ResultType.error)
        logger.e('Error opening the file');
      }
    } catch (e) {
      emit(OpenFileState.error(message: 'Error ${e.toString()}'));
      // Handle exceptions
      logger.e('Error: $e');
    }
  }
}
