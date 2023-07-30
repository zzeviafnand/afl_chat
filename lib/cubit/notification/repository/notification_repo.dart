import 'package:dio/dio.dart';
import 'package:project_chat/resource/api_provider.dart';

BaseOptions options = BaseOptions(
  baseUrl: "https://fcm.googleapis.com/",
  headers: {
    "Authorization":
        "key=AAAAI1zsptc:APA91bGqi1ViQynEsxUs8_pJueJLjL44cBZtApz-rfriu_X23HRajkocbiZK2yxlcrhCWTav7m_x02Y-6hnqYIcn5SnBLyp1qhdo3FoQLj0_eEe957a2yx3uF3SojzBG0eGNsyvOZ4mX"
  },
);

extension Notification on ApiProvider {
  Future<void> notifyChat(String target, String title, String body, String type,
      String content, String from) async {
    Dio dio = Dio(options);
    await dio.post(
      "fcm/send",
      data: {
        "to": target,
        "notification": {"title": title, "body": body},
        "data": {
          "type": type,
          "content": from,
        }
      },
    );
  }

  Future<void> testNotificationToUser() async {
    Dio dio = Dio(options);
    await dio.post("fcm/send", data: {
      "to":
          "dgKmjxr7QoWVOHykIDuPL4:APA91bEdVTFeSHHId5mR7AdLVUXqlyrxA0x2UBr-pX8fQzl0ZLfzzBn0wVLzFpWV2PRooLaeL-YwiNgbyzkHmXRcmkWQjrdEo0-9hGolH2gYgs_O8JKOfJdqS-tq5Qj7DneBQvW-jrmA",
      "notification": {
        "title": "Breaking News",
        "body": "New news story available."
      },
      "data": {"story_id": "story_12345"}
    });
  }
}
