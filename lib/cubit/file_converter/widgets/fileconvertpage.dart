import 'package:flutter/material.dart';
import 'package:project_chat/cubit/file_converter/widgets/convertcomponent/jpg-pdf.dart';
import 'package:project_chat/cubit/file_converter/widgets/convertcomponent/word-pdf.dart';

import '../../../components/appbar.dart';
import 'convertcomponent/pdf-jpg.dart';
import 'convertcomponent/pdf-word.dart';

class FileConvertPage extends StatefulWidget {
  const FileConvertPage({super.key});

  @override
  State<FileConvertPage> createState() => _FileConvertPageState();
}

class _FileConvertPageState extends State<FileConvertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: chatAppBar(context),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(18),
        crossAxisSpacing: 12,
        mainAxisSpacing: 50,
        crossAxisCount: 2,
        children: [
          GestureDetector(
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PdfToWord(),
                  ),
                )),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/pdf-100.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 6.3,
                    width: MediaQuery.of(context).size.width / 2.8,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    " PDF TO WORD",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WordToPdf(),
                  ),
                )),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/microsoft-word.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 6.3,
                    width: MediaQuery.of(context).size.width / 2.8,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    " WORD TO PDF",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PdfToJpg(),
                  ),
                )),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/pdf.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 6.3,
                    width: MediaQuery.of(context).size.width / 2.8,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    " PDF TO JPG",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const JpgToPdf(),
                  ),
                )),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.transparent,
                  child: Image.asset(
                    "assets/jpg.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 6.3,
                    width: MediaQuery.of(context).size.width / 2.8,
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    " JPG TO PDF",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
