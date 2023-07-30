part of 'file_upload_cubit.dart';

class FileData {
  String name;
  bool isFolder;
  DateTime modifiedDate;
  int size;
  String path;

  FileData({
    required this.name,
    required this.isFolder,
    required this.modifiedDate,
    required this.size,
    required this.path,
  });

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      name: json['Name'],
      isFolder: json['IsFolder'],
      modifiedDate: DateTime.parse(json['ModifiedDate']),
      size: json['Size'],
      path: json['Path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'IsFolder': isFolder,
      'ModifiedDate': modifiedDate.toIso8601String(),
      'Size': size,
      'Path': path,
    };
  }
}

@freezed
class FileUploadState with _$FileUploadState {
  const factory FileUploadState.initial() = _Initial;

  const factory FileUploadState.loading() = _Loading;

  const factory FileUploadState.error({required String message}) = _Error;

  const factory FileUploadState.noFileSelected() = _NoFileSelected;

  const factory FileUploadState.directorySelected(
      {required List<FileData> files}) = _DirectorySelected;

  const factory FileUploadState.fileSelected({dynamic selectedFile}) =
      _FileSelected;
}
