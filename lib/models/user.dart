class User {
  final String? id;
  final String? phone;
  final String? username;
  final String? error;
  const User({this.id, this.phone, this.username, this.error});
  User copyWith({String? id, String? phone, String? username, String? error}) {
    return User(
        id: id ?? this.id,
        phone: phone ?? this.phone,
        username: username ?? this.username,
        error: error ?? this.error);
  }

  Map<String, Object?> toJson() {
    return {'id': id, 'phone': phone, 'username': username, 'error': error};
  }

  static User fromJson(Map<String, Object?> json) {
    return User(
        id: json['id'] == null ? null : json['id'] as String,
        phone: json['phone'] == null ? null : json['phone'] as String,
        username: json['username'] == null ? null : json['username'] as String,
        error: json['error'] == null ? null : json['error'] as String);
  }

  @override
  String toString() {
    return '''User(
                id:$id,
phone:$phone,
username:$username,
error:$error
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is User &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.phone == phone &&
        other.username == username &&
        other.error == error;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, phone, username, error);
  }
}
