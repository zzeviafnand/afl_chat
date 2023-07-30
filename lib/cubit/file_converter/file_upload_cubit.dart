import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_chat/helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'file_upload_state.dart';

part 'file_upload_cubit.freezed.dart';

class FileUploadCubit extends Cubit<FileUploadState> {
  FileUploadCubit() : super(const FileUploadState.initial());
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  BaseOptions options = BaseOptions(connectTimeout: const Duration(minutes: 5));
  final Dio dio = Dio();

  // Future getPDFFiles() async {
  //   try {
  //     // emit(const FileUploadState.loading());
  //     // final dir = await createDirectory("pdf");
  //     // final files = io.Directory(dir.path).listSync();
  //     // emit(FileUploadState.directorySelected(files: files));
  //     // logger.v(state);
  //     emit(const FileUploadState.loading());
  //     Map<String, dynamic>? token = await getToken();
  //     if (token != null) {
  //       List<FileData> files = await getPDFsFilesFromAspose(token);
  //       emit(FileUploadState.directorySelected(files: files));
  //     }
  //   } catch (e, s) {
  //     emit(const FileUploadState.error());
  //     logger.e("Error", [e, s]);
  //   }
  // }
  // Future getPDFFiles() async {
  //   try {
  //     emit(const FileUploadState.loading());
  //     // final dir = await createDirectory("pdf");
  //     // final files = io.Directory(dir.path).listSync();
  //     // emit(FileUploadState.directorySelected(files: files));
  //     // logger.v(state);
  //
  //     Map<String, dynamic>? token = await getToken();
  //     if (token != null) {
  //       List<FileData> files = await getPDFsFilesFromAspose(token);
  //       emit(FileUploadState.directorySelected(files: files));
  //     }
  //   } catch (e, s) {
  //     emit(FileUploadState.error(message: e.toString()));
  //     logger.e("Error", [e, s]);
  //   }
  // }
  //
  // Future fileLoaded() async {}
  //
  // Future<void> addPdfFile() async {
  //   try {
  //     final dir = await createDirectory("pdf");
  //     logger.v(
  //       "path: ${dir.path}",
  //     );
  //     final result = await FilePicker.platform.pickFiles();
  //     if (result != null) {
  //       logger.v(result);
  //       File file = File(result.files.single.path!);
  //       convertPdfToWord(file);
  //       // final newFile =
  //       //     await file.copy("${dir.path}/${result.files.single.name}");
  //       // logger.v(newFile);
  //     }
  //   } catch (e, s) {
  //     logger.e("Error", [e, s]);
  //   }
  // }
  //
  // Future<void> convertPdfToWord(File file) async {
  //   try {
  //     ///
  //     /// Periksa apakah file tersedia.
  //     ///
  //     File originalFile = File(file.path);
  //     if (await originalFile.exists()) {
  //       logger.v("file Exist");
  //     } else {
  //       logger.e("file Not Found");
  //     }
  //
  //     ///
  //     /// Upload File ke Aspose
  //     ///
  //     /// Ambil Token
  //     ///
  //     Map<String, dynamic>? token = await getToken();
  //     if (token != null) {
  //       ///
  //       ///Konversi dan Upload file Ke Aspose
  //       ///
  //       await convertAndUploadFileToAspose(token, file);
  //
  //       ///
  //       /// Simpan Data Hasil Konversi ke Internal Storage
  //       ///
  //       // final dir = await createDirectory("pdf");
  //       // var newFile =
  //       //     File("${dir.path}/${basenameWithoutExtension(fileParam.path)}.doc");
  //       // newFile.writeAsBytes(res);
  //       // logger.v("File Created");
  //     }
  //   } catch (e, s) {
  //     logger.e("Error", [e, s]);
  //   }
  // }

  Future<Map<String, dynamic>?> getToken() async {
    final SharedPreferences prefs = await _prefs;
    try {
      ///
      /// Periksa apakah ada data asposeToken di SharedPreferences
      ///
      final String? asposeTokenString = prefs.getString('asposeToken');
      if (asposeTokenString != null) {
        Map<String, dynamic> asposeToken = jsonDecode(asposeTokenString);

        ///
        /// Validasi Expiration asposeToken, jika tidak valid, maka Fetching Aspose Token dilakukan
        ///

        if (DateTime.now().millisecondsSinceEpoch > asposeToken['expiryDate']) {
          Map<String, dynamic> asposeToken = await fetchAsposeToken();
          logger.v("Token Expired, Refetch");
          return asposeToken;
        }

        ///
        /// Return asposeToken dari sharedPreferences tanpa fetch bila valid
        ///
        logger.v("Token Valid: $asposeToken");
        return asposeToken;
      }

      ///
      /// Jika tidak ketemu, fetch Aspose Token
      ///
      Map<String, dynamic> asposeToken = await fetchAsposeToken();
      logger.v("Initial Token Data Fetched");
      return asposeToken;
    } catch (e, f) {
      logger.e("error", [e, f]);
    }
    return null;
  }

  Future<Map<String, dynamic>> fetchAsposeToken() async {
    final SharedPreferences prefs = await _prefs;
    try {
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      };

      var data =
          'grant_type=client_credentials&client_id=7484eefb-3252-4d27-af3b-d6924b691d29&client_secret=60a353dcb1e35ac7565147edf69fb0ae';

      var url = Uri.parse('https://api.aspose.cloud/connect/token');
      var res = await http.post(url, headers: headers, body: data);
      if (res.statusCode != 200) {
        logger.e('http.post error: statusCode= ${res.statusCode}');
      }
      Map<String, dynamic> asposeToken = jsonDecode(res.body);

      DateTime date = DateTime.now();
      DateTime expiryDate = date.add(const Duration(hours: 1));
      asposeToken.addAll({"expiryDate": expiryDate.millisecondsSinceEpoch});
      prefs.setString('asposeToken', jsonEncode(asposeToken));

      logger.v("Fetched Token From Aspose Server");
      return jsonDecode(res.body);
    } catch (e, s) {
      logger.e("Error", [e, s]);
      return {};
    }
  }

  //
  // Future<void> convertAndUploadFileToAspose(token, File file) async {
  //   final userData = FirebaseAuth.instance.currentUser;
  //   BaseOptions options = BaseOptions(
  //     connectTimeout: const Duration(minutes: 2),
  //   );
  //   final Dio dio5Minute = Dio(options);
  //
  //   const url = 'https://api.aspose.cloud/v3.0/pdf/convert/doc';
  //   var headers = {
  //     'Content-Type': 'multipart/form-data',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${token['access_token']}',
  //   };
  //   final formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(file.path),
  //   });
  //
  //   ///
  //   /// Upload file ke aspose Cloud menggunakan metode put, menggunakan DIO
  //   ///
  //   final res = await dio5Minute.put(
  //     url,
  //     data: formData,
  //     options: Options(headers: headers),
  //     queryParameters: {
  //       "outPath":
  //           "doc/${FirebaseAuth.instance.currentUser!.uid}/${basenameWithoutExtension(file.path)}.doc",
  //     },
  //   );
  //   logger.v(res);
  // }

  // Future<List<FileData>> getPDFsFilesFromAspose(token) async {
  //   BaseOptions options = BaseOptions(
  //     connectTimeout: const Duration(minutes: 5),
  //   );
  //   final Dio dio5Minute = Dio(options);
  //
  //   var url =
  //       'https://api.aspose.cloud/v3.0/pdf/storage/folder/doc/${FirebaseAuth.instance.currentUser!.uid}/';
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${token['access_token']}',
  //   };
  //
  //   ///
  //   /// Upload file ke aspose Cloud menggunakan metode put, menggunakan DIO
  //   ///
  //   Response<Map<String, dynamic>> res = await dio5Minute.get(
  //     url,
  //     options: Options(headers: headers),
  //   );
  //   logger.v(res);
  //   if (res.data != null) {
  //     List data = res.data!['Value'];
  //     return data.map((e) => FileData.fromJson(e)).toList();
  //   }
  //   return [];
  // }

  Future getFiles(String from, String to) async {
    try {
      emit(const FileUploadState.loading());
      // final dir = await createDirectory("pdf");
      // final files = io.Directory(dir.path).listSync();
      // emit(FileUploadState.directorySelected(files: files));
      // logger.v(state);

      Map<String, dynamic>? token = await getToken();
      if (token != null) {
        List<FileData> files = await getFilesFromAspose(token, to);
        emit(FileUploadState.directorySelected(files: files));
      }
    } catch (e, s) {
      emit(FileUploadState.error(message: e.toString()));
      logger.e("Error", [e, s]);
    }
  }

  Future<List<FileData>> getFilesFromAspose(token, String type) async {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(minutes: 5),
    );
    final Dio dio5Minute = Dio(options);

    var url =
        'https://api.aspose.cloud/v3.0/pdf/storage/folder/doc/${FirebaseAuth.instance.currentUser!.uid}/';
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token['access_token']}',
    };

    ///
    /// Upload file ke aspose Cloud menggunakan metode put, menggunakan DIO
    ///
    Response<Map<String, dynamic>> res = await dio5Minute.get(
      url,
      options: Options(headers: headers),
    );
    logger.v(res);
    if (res.data != null) {
      List data = res.data!['Value'];
      return data.map((e) => FileData.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> addFile(String from, String to) async {
    List<String> files = [];
    switch (from) {
      case "words":
        files = ["docx", "doc"];
        break;
      case "pdf":
        files = ["pdf"];
        break;
      case "imaging":
        files = ["jpg"];
        break;
      case "pptx":
        files = ["pptx"];
        break;
    }
    try {
      final dir = await createDirectory("files");
      logger.v(
        "path: ${dir.path}",
      );
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: files,
      );
      if (result != null) {
        emit(const FileUploadState.loading());

        logger.v(result);
        File file = File(result.files.single.path!);
        convertFile(file, from, to);
        // final newFile =
        //     await file.copy("${dir.path}/${result.files.single.name}");
        // logger.v(newFile);
      }
    } catch (e, s) {
      emit(FileUploadState.error(message: e.toString()));
      logger.e("Error", [e, s]);
    }
  }

  Future<void> convertFile(File file, String from, String to) async {
    try {
      ///
      /// Periksa apakah file tersedia.
      ///
      File originalFile = File(file.path);
      if (await originalFile.exists()) {
        logger.v("file Exist");
      } else {
        logger.e("file Not Found");
      }

      ///
      /// Upload File ke Aspose
      ///
      /// Ambil Token
      ///
      Map<String, dynamic>? token = await getToken();
      if (token != null) {
        ///
        ///Konversi dan Upload file Ke Aspose
        ///
        await convertAndUploadFileToAsposeDynamic(token, file, from, to);

        ///
        /// Simpan Data Hasil Konversi ke Internal Storage
        ///
        // final dir = await createDirectory("pdf");
        // var newFile =
        //     File("${dir.path}/${basenameWithoutExtension(fileParam.path)}.doc");
        // newFile.writeAsBytes(res);
        // logger.v("File Created");
      }
    } catch (e, s) {
      logger.e("Error", [e, s]);
    }
  }

  Future<void> convertAndUploadFileToAsposeDynamic(
      token, File file, String from, String to) async {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(minutes: 2),
    );
    final Dio dio5Minute = Dio(options);
    var tox = "";
    switch (to) {
      case "words":
        tox = "doc";
        break;
      default:
        tox = to;
        break;
    }
    var url = "";
    if (from == "pdf") {
      url = 'https://api.aspose.cloud/v3.0/pdf/convert/doc';
    } else if (from == 'words') {
      url = 'https://api.aspose.cloud/v4.0/$from/convert?format=$to';
    }
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token['access_token']}',
    };
    final formData = FormData.fromMap({
      'Document': await MultipartFile.fromFile(file.path),
    });

    ///
    /// Upload file ke aspose Cloud menggunakan metode put, menggunakan DIO
    ///
    final res = await dio5Minute.put(
      url,
      data: formData,
      options: Options(headers: headers),
      queryParameters: {
        "outPath":
            "doc/${FirebaseAuth.instance.currentUser!.uid}/${basenameWithoutExtension(file.path)}.$tox",
      },
    );
    getFiles(from, to);
    logger.v(res);
  }
}
//
// Future<Uint8List> convertPDF(accessToken) async {
//   var headers = {
//     'Content-Type': 'application/json-',
//     'Authorization': 'Bearer $accessToken',
//   };
//
//   var url =
//       Uri.parse('https://api.aspose.cloud/v3.0/pdf/document.pdf/convert/doc');
//
//   var res = await http.get(url, headers: headers);
//   if (res.statusCode != 200) {
//     logger.e('http.get error: statusCode= ${res.statusCode} ${res.body}');
//   }
//   var fileBytes = res.bodyBytes;
//   return fileBytes;
// }

Future<Directory> createDirectory(String folder) async {
  final dir = await getApplicationDocumentsDirectory();
  final path = "${dir.path}/$folder";
  final newDir = Directory(path);
  if (await newDir.exists()) {
    logger.v('Directory already exists');
  } else {
    final dir = await newDir.create(recursive: true);
    logger.v('Directory created at ${dir.path}');
  }
  return newDir;
}
