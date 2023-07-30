part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

class ChatsInitial extends ChatsState {
  const ChatsInitial();
}

class ChatsInitialized extends ChatsState {
  final ChatRoom chatRoom;
  const ChatsInitialized({required this.chatRoom});

  @override
  List<Object> get props => [chatRoom];
}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  final List<Chat> chats;
  const ChatsLoaded(this.chats);
  @override
  List<Object> get props => [chats];
}

class ChatsError extends ChatsState {
  final String? message;
  const ChatsError(this.message);
}
