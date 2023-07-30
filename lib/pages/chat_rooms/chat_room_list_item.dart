import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_chat/components/profile_image.dart';
import 'package:project_chat/cubit/contact_list_cubit.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:project_chat/models/user_profile.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem(this.data, {super.key});

  final ChatRoom data;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  UserProfile? targetUser;

  @override
  void initState() {
    super.initState();
    targetUser = context
        .read<ContactListCubit>()
        .getUserProfileFromPhone(widget.data.targetNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white,
      child: ListTile(
        title: Text(targetUser?.fullName ??
            widget.data.targetNumber ??
            "Unknown Error"),
        subtitle: Text(widget.data.lastChat),
        dense: true,
        leading: DottedBorder(
          color: Colors.blue,
          borderType: BorderType.Circle,
          radius: const Radius.circular(5),
          child: CircleProfilePicture(
            backgroundImage: NetworkImage(
              targetUser?.photoUrl ?? "",
            ),
            onBackgroundImageError: (exception, stackTrace) {},
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DateFormat('HH:mm').format(
                (DateTime.fromMicrosecondsSinceEpoch(
                    (widget.data.lastInteraction as Timestamp)
                            .millisecondsSinceEpoch *
                        1000)))),
            if (widget.data.unreadMessage != null)
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xFF3c4df0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    widget.data.unreadMessage.toString() ?? "",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
