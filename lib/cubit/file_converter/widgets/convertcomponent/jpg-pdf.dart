import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import '../../../../constants/chat_const.dart';
import '../../../open_file/open_file_cubit.dart';
import '../../file_upload_cubit.dart';

class JpgToPdf extends StatefulWidget {
  const JpgToPdf({super.key});

  @override
  State<JpgToPdf> createState() => _JpgToPdfState();
}

class _JpgToPdfState extends State<JpgToPdf> {
  File file = File("");

  @override
  void initState() {
    super.initState();
    context.read<FileUploadCubit>().getFiles('pptx', 'pdf');
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
                  "PPTX to PDF",
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<FileUploadCubit>().addFile('pptx', 'pdf');
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildFileList(List<FileData> file, int index) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        onTap: () => context.read<OpenFileCubit>().openFile(
            path.basename(file[index].path),
            FirebaseAuth.instance.currentUser!.uid),
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
