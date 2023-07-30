part of 'chatroom_bloc.dart';

abstract class ChatroomState extends Equatable {
  const ChatroomState();

  @override
  List<Object> get props => [];
}

class ChatroomInitial extends ChatroomState {}

class ChatRoomLoading extends ChatroomState {}

class ChatRoomLoaded extends ChatroomState {
  final List<ChatRoom> chatRoomList;

  const ChatRoomLoaded(this.chatRoomList);

  @override
  List<Object> get props => [chatRoomList];
}

class ChatRoomError extends ChatroomState {
  final String? message;

  const ChatRoomError(this.message);
}
