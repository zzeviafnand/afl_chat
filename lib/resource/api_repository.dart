import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_chat/cubit/notification/repository/notification_repo.dart';
import 'package:project_chat/models/chat.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:project_chat/models/note.dart';
import 'package:project_chat/models/user_status.dart';
import 'package:project_chat/resource/provider_extension/notes_provider.dart';
import 'package:project_chat/resource/provider_extension/user_profile_provider.dart';

import '../models/user_profile.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<ChatRoom>> fetchChatRooms() {
    return _provider.getChatRooms();
  }

  Future<List<Chat>> fetchChats(roomId) {
    return _provider.getChats(roomId);
  }

  Future<List<Chat>> restoreChat(roomId) {
    return _provider.restoreChat(roomId);
  }

  Future<void>? sendChat(UserProfile userProfile, ChatRoom chatRoom, message) {
    _provider.sendChat(chatRoom, message);
    if (userProfile.fcmToken != null) {
      _provider.notifyChat(userProfile.fcmToken!, "Message from Someone",
          message, "chat", message, userProfile.fullName ?? userProfile.phone);
    }
    return null;
  }

  Future<ChatRoom> initChat(List<String> member) {
    return _provider.initChat(member);
  }

  Query<Chat> steamChatChanges(String? chatRoomId) {
    return _provider.streamChatChanges(chatRoomId);
  }

  Query<ChatRoom> streamChatRooms() {
    return _provider.streamChatRooms();
  }

  Future<UserProfile?> updateUserProfile(userProfile, {bool? isEditing}) {
    return _provider.updateUserProfile(userProfile, isEditing: isEditing);
  }

  Future<void> updateUserSCMToken(String token, UserProfile userProfile) async {
    return _provider.updateUserSCMToken(token, userProfile);
  }

  Future<List<Note>> getNotes() {
    return _provider.getNotes();
  }

  Future<Note?> createNote(note) {
    return _provider.createNote(note);
  }

  Future<QuerySnapshot<UserProfile>> getContacts() {
    return _provider.getContacts();
  }

  Future<void> createStatus(UserStatusModel userStatus) async {
    _provider.createStatus(userStatus);
  }

  Future<QuerySnapshot<UserStatusModel>> getAllStatuses() async {
    return _provider.getAllStatuses();
  }
}

class NetworkError extends Error {}
