part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatsEvent {
  final String? chatRoomId;
  const ChatLoaded(this.chatRoomId);
}

class InitializingChats extends ChatsEvent {
  final List<String> member;
  const InitializingChats({required this.member});
}

class SendChatMessage extends ChatsEvent {
  final ChatRoom chatRoom;
  final String message;

  @override
  List<Object> get props => [message];
  const SendChatMessage(this.chatRoom, this.message);
}

class ChatStreamed extends ChatsEvent {
  final List<Chat> chats;
  const ChatStreamed(this.chats);

  @override
  List<Object> get props => [chats];
}
