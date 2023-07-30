import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatroom.freezed.dart';

part 'chatroom.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  const ChatRoom._();

  const factory ChatRoom({
    required String id,
    required List<String> members,
    required String lastChat,
    int? unreadMessage,
    dynamic lastInteraction,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);

  String get targetNumber => members
      .where((element) =>
          element != FirebaseAuth.instance.currentUser!.phoneNumber)
      .first;
}
// class ChatRoom {
//   final String? id;
//   final List<dynamic>? member;
//   Future<Chat>? lastChat;
//   final String? error;
//   ChatRoom({this.id, this.member, this.error, this.lastChat});
//   String get targetNumber =>
//       member
//           ?.where((element) =>
//               element != FirebaseAuth.instance.currentUser!.phoneNumber)
//           .first ??
//       "Error!";
//   ChatRoom copyWith({String? id, List<dynamic>? member, String? error}) {
//     return ChatRoom(
//         id: id ?? this.id,
//         member: member ?? this.member,
//         error: error ?? this.error);
//   }

//   Map<String, Object?> toJson() {
//     return {'id': id, 'member': member, 'error': error};
//   }

//   static ChatRoom fromJson(Map<String, Object?> json, String id) {
//     return ChatRoom(
//         id: id,
//         member: json['member'] == null ? null : json['member'] as List<dynamic>,
//         error: json['error'] == null ? null : json['error'] as String);
//   }

//   static ChatRoom withError(String errorMessage) {
//     return ChatRoom(error: errorMessage);
//   }

//   @override
//   String toString() {
//     return '''ChatRoom(
//                 id:$id,
// member:$member,
// error:$error
//     ) ''';
//   }

//   @override
//   bool operator ==(Object other) {
//     return other is ChatRoom &&
//         other.runtimeType == runtimeType &&
//         other.id == id &&
//         other.member == member &&
//         other.error == error;
//   }

//   @override
//   int get hashCode {
//     return Object.hash(runtimeType, id, member, error);
//   }
// }
