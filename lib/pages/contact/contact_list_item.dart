import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/components/profile_image.dart';
import 'package:project_chat/cubit/chat_room_cubit.dart';
import 'package:project_chat/pages/chat_room/chat_room_page.dart';

import '../../models/user_profile.dart';

class ContactListItem extends StatefulWidget {
  const ContactListItem(this.userProfile, this.index, {super.key});

  final UserProfile userProfile;
  final int index;

  @override
  State<ContactListItem> createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.userProfile.fullName ?? widget.userProfile.phone),
        subtitle: widget.userProfile.fullName == null
            ? null
            : Text(widget.userProfile.phone),
        dense: true,
        leading: CircleProfilePicture(
          backgroundImage: NetworkImage(widget.userProfile.photoUrl ?? ""),
          onBackgroundImageError: (exception, stackTrace) {},
        ),
        trailing: BlocConsumer<ChatRoomCubit, ChatRoomState>(
          listener: (context, state) {
            if (state.status.isSuccess && state.chatRoom != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ChatRoomPage(state.chatRoom!),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status.isLoading && state.selectedIndex == widget.index) {
              return const CircularProgressIndicator();
            }
            return GestureDetector(
              onTap: (() {
                context.read<ChatRoomCubit>().initializeChat([
                  FirebaseAuth.instance.currentUser!.phoneNumber!,
                  widget.userProfile.phone
                ], widget.index);
                // chatsBloc.add(
                //   InitializingChats(
                //     member: [
                //       FirebaseAuth.instance.currentUser!.phoneNumber!,
                //       widget.userDoc['phone']
                //     ],
                //   ),
                // );
              }),
              child: const Icon(Icons.chat_sharp),
            );
          },
        ),
      ),
    );
  }
}
