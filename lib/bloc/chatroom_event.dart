part of 'chatroom_bloc.dart';

abstract class ChatroomEvent extends Equatable {
  const ChatroomEvent();

  @override
  List<Object> get props => [];
}

class GetChatList extends ChatroomEvent {}

class StreamChatRoomList extends ChatroomEvent {
  final List<ChatRoom> chatRoomList;
  const StreamChatRoomList(this.chatRoomList);

  @override
  List<Object> get props => [chatRoomList];
}
