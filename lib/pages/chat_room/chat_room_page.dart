import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_chat/components/itembublechat.dart';
import 'package:project_chat/components/profile_image.dart';
import 'package:project_chat/cubit/chats_cubit.dart';
import 'package:project_chat/models/chat.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:project_chat/models/user_profile.dart';
import 'package:project_chat/pages/chat_room/select-converted.dart';

// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../components/zegokit/call_page.dart';
import '../../components/zegokit/vcall_page.dart';
import '../../cubit/contact_list_cubit.dart';

part 'chat_room_app_bar.dart';

part 'chat_room_item.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage(this.chatRoom, {super.key});

  final ChatRoom chatRoom;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(callID: '', chatRoom: widget.chatRoom),
        body: ChatRoomItem(widget.chatRoom),
      ),
    );
  }
}
