import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:project_chat/cubit/open_file/open_file_cubit.dart';

class ItemBubbleChat extends StatelessWidget {
  const ItemBubbleChat({
    Key? key,
    required this.message,
    required this.isSender,
    required this.time,
  }) : super(key: key);
  final bool isSender;
  final String message;
  final dynamic time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      // ignore: sort_child_properties_last
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          // color: isSender ? const Color(0xFF4c82f6) : Color(0xFFe5c07b),
          color: isSender
              ? const Color(0xFF4c82f6)
              : const Color.fromARGB(255, 169, 194, 255),
          borderRadius: isSender
              ? const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (message.startsWith('file://')) ...[
              GestureDetector(
                onTap: () => context.read<OpenFileCubit>().openFile(
                    message.replaceAll('file://', '').split('/').last,
                    message.replaceAll('file://', '').split('/')[2]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(FontAwesomeIcons.fileWord, color: Colors.white),
                    const VerticalDivider(width: 3),
                    Flexible(
                      child: Text(
                        message.replaceAll('file://', '').split('/').last,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ] else ...[
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              )
            ],
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (message.startsWith('file://'))
                  BlocBuilder<OpenFileCubit, OpenFileState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: (message) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                        orElse: () => const Icon(FontAwesomeIcons.download,
                            color: Colors.white, size: 20),
                      );
                    },
                  ),
                const VerticalDivider(
                  width: 3,
                ),
                Text(
                  DateFormat('HH:mm').format(
                      (DateTime.fromMicrosecondsSinceEpoch(
                          (time as Timestamp).millisecondsSinceEpoch * 1000))),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
    );
  }
}
