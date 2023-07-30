import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat extends Equatable with _$Chat {
  const factory Chat({
    required dynamic dateSent,
    required String from,
    required String to,
    required String message,
    required bool isRead,
  }) = _Chat;
  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  const Chat._();

  @override
  // TODO: implement props
  List<Object?> get props => [dateSent, from, to, message];
}

// class Chat {
//   final dynamic dateSent;
//   final String? from;
//   final String? to;
//   final String? message;
//   String get getMessage => message ?? "";
//   final String? error;
//   const Chat({this.dateSent, this.from, this.to, this.message, this.error});
//   Chat copyWith({String? dateSent, String? from, String? to, String? message}) {
//     return Chat(
//         dateSent: dateSent ?? this.dateSent,
//         from: from ?? this.from,
//         to: to ?? this.to,
//         message: message ?? this.message);
//   }

//   Map<String, Object?> toJson() {
//     return {'dateSent': dateSent, 'from': from, 'to': to, 'message': message};
//   }

//   static Chat fromJson(Map<String, Object?> json) {
//     return Chat(
//         dateSent:
//             json['dateSent'] == null ? null : json['dateSent'] as Timestamp,
//         from: json['from'] == null ? null : json['from'] as String,
//         to: json['to'] == null ? null : json['to'] as String,
//         message: json['message'] == null ? null : json['message'] as String);
//   }

//   static Chat withError(String errorMessage) {
//     return Chat(error: errorMessage);
//   }

//   @override
//   String toString() {
//     return '''Chat(
//                 dateSent:$dateSent,
// from:$from,
// to:$to,
// message:$message
//     ) ''';
//   }

//   @override
//   bool operator ==(Object other) {
//     return other is Chat &&
//         other.runtimeType == runtimeType &&
//         other.dateSent == dateSent &&
//         other.from == from &&
//         other.to == to &&
//         other.message == message;
//   }

//   @override
//   int get hashCode {
//     return Object.hash(runtimeType, dateSent, from, to, message);
//   }
// }
