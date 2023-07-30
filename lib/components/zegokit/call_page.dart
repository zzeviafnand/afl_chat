import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../cubit/contact_list_cubit.dart';
import '../../models/chatroom.dart';
import 'config.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key, required this.callID, required this.chatRoom});
  final String callID;
  final ChatRoom chatRoom;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final userID = FirebaseAuth.instance.currentUser!.phoneNumber!;
  late String callID;
  @override
  void initState() {
    super.initState();
    var arrCallID = [widget.chatRoom.targetNumber, userID];
    arrCallID.sort((a, b) => a.compareTo(b));
    setState(() {
      callID = arrCallID.join("-");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: Config
          .appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: Config
          .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userID,
      userName: userID,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
        ..avatarBuilder = (BuildContext context, Size size, ZegoUIKitUser? user,
            Map extraInfo) {
          return user != null
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                      context
                              .read<ContactListCubit>()
                              .getUserProfileFromPhone(
                                  widget.chatRoom.targetNumber)!
                              .photoUrl ??
                          "",
                    )),
                  ),
                )
              : const SizedBox();
        }
        ..audioVideoViewConfig = ZegoPrebuiltAudioVideoViewConfig(
          backgroundBuilder: (BuildContext context, Size size,
              ZegoUIKitUser? user, Map extraInfo) {
            return user != null
                ? ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Image(
                        image: NetworkImage(
                      context
                              .read<ContactListCubit>()
                              .getUserProfileFromPhone(
                                  widget.chatRoom.targetNumber)!
                              .photoUrl ??
                          "",
                    )),
                  )
                : const SizedBox();
          },
        ),
    );
  }
}
