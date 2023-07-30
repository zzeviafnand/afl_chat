part of 'chat_room_page.dart';

class ChatRoomItem extends StatefulWidget {
  const ChatRoomItem(
    this.chatRoom, {
    Key? key,
  }) : super(key: key);
  final ChatRoom chatRoom;

  @override
  State<ChatRoomItem> createState() => _ChatRoomItemState();
}

class _ChatRoomItemState extends State<ChatRoomItem> {
  final ScrollController _listController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  //

  _scrollDown() {
    _listController.jumpTo(_listController.initialScrollOffset);
  }

  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    context.read<ChatsCubit>().fetchChats(widget.chatRoom.id);

    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatsCubit, ChatsState>(
      listener: (context, state) {
        if (state.status.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Restoring Old Chat"),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ChatsStatus.initial:
            return const Text("Initializing");
          case ChatsStatus.loading:
            return _buildLoading();
          case ChatsStatus.success:
            return _buildChats(state.chats);
          // return _buildChats(state.chats);
          case ChatsStatus.failure:
            return const Text("error");
          case ChatsStatus.empty:
            return const Text("chats empty");
        }
      },
    );
  }

  _buildLoading() => const Center(child: CircularProgressIndicator());

  _buildChats(List<Chat>? chats) {
    return Column(
      children: [
        // TODO : Date
        Container(
          width: 100,
          //height: 100,
          decoration: BoxDecoration(
            // border: Border.all(
            //     color: Colors.black, width: 5.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueAccent,
          ),
          child: Center(
            child: Text(
              DateFormat("MM-dd-yyyy").format(
                DateTime.now(),
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        // TODO : item chat
        Expanded(
          child: ListView.builder(
            reverse: true,
            controller: _listController,
            itemCount: chats!.length,
            itemBuilder: (context, index) {
              var chat = chats[index];
              return ItemBubbleChat(
                isSender:
                    chat.from == FirebaseAuth.instance.currentUser!.phoneNumber,
                message: chat.message,
                time: chat.dateSent,
              );
            },
          ),
        ),
        // TODO : text input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width / 1.0,
          height: 80,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleProfilePicture(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (builder) => buttomsheet(),
                    );
                  },
                  child: const Icon(
                    Icons.attach_file_outlined,
                    color: Color(0xFF3c4df0),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  focusNode: myFocusNode,
                  textInputAction: TextInputAction.go,
                  onChanged: (value) {},
                  onSubmitted: (value) {
                    if (_textEditingController.text != "") {
                      UserProfile? userProfile = context
                          .read<ContactListCubit>()
                          .getUserProfileFromPhone(
                              widget.chatRoom.targetNumber);
                      context.read<ChatsCubit>().sendChat(userProfile!,
                          widget.chatRoom, _textEditingController.text);
                      _textEditingController.text = "";
                      _scrollDown();
                    }
                    myFocusNode.requestFocus();
                  },
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: Color(0xFF3c4df0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Material(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: InkWell(
                  onTap: (() {
                    UserProfile? userProfile = context
                        .read<ContactListCubit>()
                        .getUserProfileFromPhone(widget.chatRoom.targetNumber);
                    if (_textEditingController.text != "") {
                      context.read<ChatsCubit>().sendChat(userProfile!,
                          widget.chatRoom, _textEditingController.text);
                      _textEditingController.text = "";
                      Navigator.pop(context);
                      _scrollDown();
                    }
                  }),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buttomsheet() {
    return SizedBox(
      height: 178,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // iconcreate(
                  //   Icons.insert_drive_file_outlined,
                  //   Colors.blue,
                  //   'Document',
                  // ),
                  iconcreate(
                    Icons.notes_outlined,
                    Colors.blue,
                    'Note File',
                  ),
                  GestureDetector(
                    onTap: () async {
                      String? fileUrl =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const SelectConvertedFile();
                        },
                      ));
                      if (fileUrl != null) {
                        UserProfile? userProfile = context
                            .read<ContactListCubit>()
                            .getUserProfileFromPhone(
                                widget.chatRoom.targetNumber);
                        context.read<ChatsCubit>().sendChat(
                            userProfile!, widget.chatRoom, 'file://$fileUrl');

                        _scrollDown();
                      }
                    },
                    child: iconcreate(
                      Icons.file_present,
                      Colors.red,
                      'Converted File',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconcreate(IconData icon, Color color, String text) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(text),
      ],
    );
  }
}
