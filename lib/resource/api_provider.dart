import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:encrypt/encrypt.dart';
import 'package:project_chat/models/user_profile.dart';
import 'package:project_chat/models/user_status.dart';

import '../models/chat.dart';

class ApiProvider {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final key = Key.fromUtf8('Tu/DG0uUjKTxva4G5YuiWA==');
  final iv = IV.fromLength(16);

  Future<List<ChatRoom>> getChatRooms() async {
    try {
      QuerySnapshot<Map<String, dynamic>> res = await db
          .collection('chatrooms')
          .where('members',
              arrayContains: FirebaseAuth.instance.currentUser?.phoneNumber)
          .where('lastInteraction', isNull: false)
          .get();
      return res.docs.map((e) {
        var json = e.data();
        json.addAll({"id": e.id});
        ChatRoom chatRoom = ChatRoom.fromJson(json);
        return chatRoom;
      }).toList();
    } catch (error, stacktrace) {
      print("Exception occured on getChatList: $error stackTrace: $stacktrace");
      return [];
    }
  }

  Future<List<Chat>> getChats(chatRoomId) {
    return DbRef.instance
        .chat(chatRoomId)
        .orderBy('dateSent', descending: true)
        .where('isRead', isEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  Future<List<Chat>> restoreChat(chatRoomId) {
    return DbRef.instance
        .chat(chatRoomId)
        .orderBy('dateSent', descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  //enkrip ngirim pesan
  Future<void> sendChat(ChatRoom chatRoom, message) async {
    final encrypter = Encrypter(AES(key));

    try {
      final encrypted = encrypter.encrypt(message, iv: iv);
      var chat = await DbRef.instance.chat(chatRoom.id).add(
            Chat(
              dateSent: DateTime.now(),
              from: FirebaseAuth.instance.currentUser!.phoneNumber!,
              to: chatRoom.targetNumber,
              message: encrypted.base64,
              isRead: false,
            ),
          );

      // print(decrypted);
      print(encrypted.base64);
      chat.parent.parent!.update({
        "unreadMessage": FieldValue.increment(1),
        "lastInteraction": DateTime.now(),
        "lastChat": encrypted.base64,
      });
    } catch (error, stacktrace) {
      print("Exception occured on getChatList: $error stackTrace: $stacktrace");
    }
  }

  Future<ChatRoom> initChat(List<String> members) async {
    // Find chat room where contains members
    final find = await db.collection('chatrooms').where('memberMap',
        isEqualTo: {members[0]: 'member', members[1]: 'member'}).get();
    // If room not found, get chat room by members
    if (find.docs.isNotEmpty) {
      var json = find.docs.single.data();
      json.addAll({"id": find.docs.single.id});
      return ChatRoom.fromJson(json);
    } else {
      var newData = await db.collection('chatrooms').add({
        'memberMap': {members[0]: 'member', members[1]: 'member'},
        'members': members,
        'lastChat': "Start New Chat",
      });
      var chatRoom = await newData
          .withConverter<ChatRoom>(
            fromFirestore: _chatRoomFromFireStore,
            toFirestore: _chatRoomToFireStore,
          )
          .get();
      return chatRoom.data()!;
    }
  }

  //dekrip pesan di chat room
  Query<Chat> streamChatChanges(String? chatRoomId) {
    final encrypter = Encrypter(AES(key));

    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('dateSent', descending: true)
        .withConverter<Chat>(
          fromFirestore: (snapshot, options) {
            final decrypted =
                encrypter.decrypt64(snapshot.data()!['message'], iv: iv);
            return Chat.fromJson(snapshot.data()!).copyWith(message: decrypted);
          },
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Query<ChatRoom> streamChatRooms() {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .where('members',
            arrayContains: FirebaseAuth.instance.currentUser?.phoneNumber)
        .where('lastInteraction', isNull: false)
        .withConverter<ChatRoom>(
      fromFirestore: (snapshot, options) {
        var json = snapshot.data()!;
        json.addAll({"id": snapshot.id});

        ChatRoom chatRoom = ChatRoom.fromJson(json);
        final encrypter = Encrypter(AES(key));
        final decrypted = encrypter.decrypt64(chatRoom.lastChat, iv: iv);
        return chatRoom.copyWith(lastChat: decrypted);
      },
      toFirestore: (value, SetOptions? options) {
        return {};
      },
    );
  }

  Future<QuerySnapshot<UserProfile>> getContacts() {
    return db
        .collection('users')
        .where('phone',
            isNotEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UserProfile.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => {},
        )
        .get();
  }

  Future<void> createStatus(UserStatusModel userStatus) async {
    db
        .collection('userStatus')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UserStatusModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value
              .copyWith(
                  milisecondCreatedAt: DateTime.now().millisecondsSinceEpoch)
              .toJson(),
        )
        .add(userStatus);
  }

  Future<QuerySnapshot<UserStatusModel>> getAllStatuses() async {
    return db
        .collection('userStatus')
        .withConverter(
            fromFirestore: (snapshot, options) =>
                UserStatusModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, options) => {})
        .get();
  }
}

class DbRef {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  DbRef._privateConstructor();

  static final DbRef _instance = DbRef._privateConstructor();

  static DbRef get instance => _instance;

  CollectionReference<Chat> chat(chatRoomId) {
    return db
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('chats')
        .withConverter<Chat>(
          fromFirestore: (snapshot, options) => Chat.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  CollectionReference<Chat> chatRoom() {
    return db.collection('chatrooms').withConverter<Chat>(
          fromFirestore: (snapshot, options) => Chat.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }
}

ChatRoom _chatRoomFromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
  var json = snapshot.data();
  json!.addAll({"id": snapshot.id});
  return ChatRoom.fromJson(json);
}

Map<String, dynamic> _chatRoomToFireStore(
        ChatRoom value, SetOptions? options) =>
    value.toJson();
