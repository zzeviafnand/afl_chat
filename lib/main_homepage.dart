import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/cubit/user_auth_cubit.dart';
import 'package:project_chat/pages/chat_rooms/chat_room_list_home_page.dart';
import 'package:project_chat/cubit/file_converter/widgets/fileconvertpage.dart';
import 'package:project_chat/pages/note/notepage.dart';
import 'package:project_chat/pages/settingpage.dart';

import 'cubit/contact_list_cubit.dart';
import 'helper.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ContactListCubit>().getAllContacts();
    FirebaseMessaging.instance.getToken().then((fcmToken) {
      logger.v("Generating FCM Token");
      context
          .read<UserAuthCubit>()
          .setFCMToken(fcmToken)
          .then((value) => logger.v("FCM Token Generated"));
      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        context
            .read<UserAuthCubit>()
            .setFCMToken(fcmToken)
            .then((value) => logger.v("FCM Token Generated"));
        logger.v("FCM Token Refreshed");
        // Note: This callback is fired at each app startup and whenever a new
        // token is generated.
      }).onError((err) {
        logger.e("FCM_TOKEN ERROR: $err");
        // Error getting token.
      });
    });
  }

  int _pageIndex = 0;
  final List<Widget> _tabList = [
    const HomePage(),
    const FileConvertPage(),
    const NotePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: _tabList.elementAt(_pageIndex),
              ),
            ],
          ),
        ],
      ),
      //TODO : JADIKAN FLOATING
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFF3c4df0),
          unselectedItemColor: const Color.fromARGB(255, 189, 194, 201),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _pageIndex,
          onTap: (int index) {
            setState(() {
              _pageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.message_sharp), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_present_sharp), label: "File"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notes_sharp), label: "Note"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_sharp), label: "Setting"),
          ]),
      // bottomNavigationBar: BottomNavigationBar(
      //     selectedItemColor: Colors.blue,
      //     unselectedItemColor: Colors.grey,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     currentIndex: _pageIndex,
      //     onTap: (int index) {
      //       setState(() {
      //         _pageIndex = index;
      //       });
      //     },
      //     items: const [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.message_sharp), label: "Home"),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.file_present_sharp), label: "File"),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.notes_sharp), label: "Note"),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.settings_sharp), label: "Setting"),
      //     ]),
    );
  }
}
