import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import '../../../../constants/chat_const.dart';
import '../../cubit/file_converter/file_upload_cubit.dart';
import '../../cubit/open_file/open_file_cubit.dart';

class SelectConvertedFile extends StatefulWidget {
  const SelectConvertedFile({super.key});

  @override
  State<SelectConvertedFile> createState() => _SelectConvertedFileState();
}

class _SelectConvertedFileState extends State<SelectConvertedFile> {
  File file = File("");

  @override
  void initState() {
    super.initState();
    context.read<FileUploadCubit>().getFiles('word', 'pdf');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OpenFileCubit, OpenFileState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message ?? "Opening File"),
            ),
          ),
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          title: const Row(
            children: [
              Expanded(
                child: Text(
                  "Pilih File",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Converted Files: '),
            Expanded(
              child: BlocConsumer<FileUploadCubit, FileUploadState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (message) => const Center(
                      child: Text("Error Loading Files"),
                    ),
                    directorySelected: (fileNames) => ListView.builder(
                      itemCount: fileNames.length,
                      itemBuilder: (context, index) {
                        return _buildFileList(fileNames, index);
                      },
                    ),
                    // initial: () => const Center(child: CircularProgressIndicator()),

                    // orElse: () => const Center(
                    //   child: Center(
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         CircularProgressIndicator(),
                    //         Text("Converting Files"),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    orElse: () => const Center(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Unknown Error"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileList(List<FileData> file, int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        onTap: () => Navigator.of(context).pop(file[index].path),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: ChatColor.primaryColor),
          borderRadius: BorderRadius.circular(20),
        ),
        leading: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: double.infinity, child: Icon(Icons.picture_as_pdf)),
            SizedBox(height: double.infinity, child: Icon(Icons.arrow_right)),
            SizedBox(
                height: double.infinity,
                child: Icon(FontAwesomeIcons.fileWord)),
          ],
        ),
        title: Text(
          file[index].name,
        ),
        // subtitle: Text(file[index].path, overflow: TextOverflow.ellipsis),
        trailing:
            IconButton(onPressed: () => null, icon: const Icon(Icons.share)),
      ),
    );
  }
}
