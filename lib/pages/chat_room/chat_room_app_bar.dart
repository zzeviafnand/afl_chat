part of 'chat_room_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.callID, required this.chatRoom})
      : preferredSize = const Size.fromHeight(kToolbarHeight);
  final String callID;
  final ChatRoom chatRoom;

  //final Uphone = FirebaseAuth.instance.currentUser!.phoneNumber.toString();
  @override
  final Size preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // default is 56.0
  final userID = FirebaseAuth.instance.currentUser!.phoneNumber!;
  final uphoneID = FirebaseAuth.instance.currentUser!.phoneNumber!;
  var usergetID = ValueNotifier("-");
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
    return yourPage(context);
  }

  Widget yourPage(BuildContext context) {
    final targetUser = context
        .read<ContactListCubit>()
        .getUserProfileFromPhone(widget.chatRoom.targetNumber);
    return AppBar(
      centerTitle: false,
      title: Row(
        children: [
          CircleProfilePicture(
            backgroundImage: NetworkImage(
              context
                      .read<ContactListCubit>()
                      .getUserProfileFromPhone(widget.chatRoom.targetNumber)!
                      .photoUrl ??
                  "",
            ),
            onBackgroundImageError: (exception, stackTrace) {},
          ),
          const VerticalDivider(),
          //Expanded(
          //  child: Text(callID),
          //),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                targetUser?.fullName ?? targetUser?.phone ?? "Unknown Error",
                style: const TextStyle(color: Color(0xFF3c4df0), fontSize: 18),
              ),
              Text(
                targetUser?.bio ?? "",
                style: const TextStyle(color: Color(0xFF3c4df0), fontSize: 14),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
              return CallPage(
                callID: userID,
                chatRoom: widget.chatRoom,
              );
            }));
          },
          icon: const Icon(Icons.call_outlined),
        ),
        //callButton(false),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
              return VCallPage(
                callID: userID,
                chatRoom: widget.chatRoom,
              );
            }));
          },
          icon: const Icon(Icons.video_call_outlined),
        ),
        //callButton(true),
      ],
    );
  }
}

  // Widget callButton(bool isVideoCall) {
  //   return ValueListenableBuilder<String>(
  //     valueListenable: usergetID,
  //     builder: (context, inviteeUserID, _) {
  //       var invitees = getInvitesFromusergetID(widget.chatRoom.targetNumber);

  //       return ZegoSendCallInvitationButton(
  //         unclickableBackgroundColor: Colors.blue,
  //         isVideoCall: isVideoCall,
  //         invitees: invitees,
  //         iconSize: const Size(40, 40),
  //         buttonSize: const Size(50, 50),
  //         onPressed: (String code, String message, List<String> errorInvitees) {
  //           if (errorInvitees.isNotEmpty) {
  //             String userIDs = "";
  //             for (int index = 0; index < errorInvitees.length; index++) {
  //               if (index >= 5) {
  //                 userIDs += '... ';
  //                 break;
  //               }

  //               var userID = errorInvitees.elementAt(index);
  //               userIDs += '$userID ';
  //             }
  //             if (userIDs.isNotEmpty) {
  //               userIDs = userIDs.substring(0, userIDs.length - 1);
  //             }

  //             var message = 'User doesn\'t exist or is offline: $userIDs';
  //             if (code.isNotEmpty) {
  //               message += ', code: $code, message:$message';
  //             }
  //             showToast(
  //               message,
  //               position: StyledToastPosition.top,
  //               context: context,
  //             );
  //           } else if (code.isNotEmpty) {
  //             showToast(
  //               'code: $code, message:$message',
  //               position: StyledToastPosition.top,
  //               context: context,
  //             );
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

  // List<ZegoUIKitUser> getInvitesFromusergetID(String targetNumber) {
  //   List<ZegoUIKitUser> invitees = [];
  //   var inviteeIDs = targetNumber.trim().replaceAll('，', '');
  //   inviteeIDs.split(",").forEach((inviteeUserID) {
  //     if (inviteeUserID.isEmpty) {
  //       return;
  //     }
  //     invitees.add(ZegoUIKitUser(
  //       id: inviteeUserID,
  //       name: ' $inviteeUserID',
  //     ));
  //   });
  //   return invitees;
  // }

//List<ZegoUIKitUser> getInvitesFromTextCtrl(String textCtrlText) {

//}
// }
