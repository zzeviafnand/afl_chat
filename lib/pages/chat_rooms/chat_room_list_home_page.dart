import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/components/appbar.dart';
import 'package:project_chat/main.dart';
import 'package:project_chat/models/chatroom.dart';
import 'package:project_chat/pages/chat_room/chat_room_page.dart';
import 'package:project_chat/pages/contact/contact_page.dart';

import '../../cubit/chat_rooms_cubit.dart';
import '../../cubit/notification/notification_cubit.dart';
import 'chat_room_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ChatRoomsCubit>().initialCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: chatAppBar(context, isHome: true),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Notification Test'),
              onTap: () async {
                await context.read<NotificationCubit>().testLocalNotification();
              },
            ),
            ListTile(
              title: const Text('Send to 02'),
              onTap: () async {
                await context
                    .read<NotificationCubit>()
                    .testNotificationToUser();
              },
            ),
          ],
        ),
      ),
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: bodyKey,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          dividerTheme: const DividerThemeData(color: Colors.transparent),
          // useMaterial3: true,
          // primaryColor: ChatColor.primaryColor,
          // primarySwatch: ChatColor.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          // textTheme: TextTheme(
          //   bodyLarge: GoogleFonts.poppins(),
          //   bodyMedium: GoogleFonts.poppins(),
          //   bodySmall: GoogleFonts.poppins(),
          //   displayLarge: GoogleFonts.poppins(),
          //   displayMedium: GoogleFonts.poppins(),
          //   displaySmall: GoogleFonts.poppins(),
          //   headlineLarge: GoogleFonts.poppins(),
          //   headlineMedium: GoogleFonts.poppins(),
          //   headlineSmall: GoogleFonts.poppins(),
          //   labelLarge:
          //       GoogleFonts.poppins().copyWith(fontWeight: FontWeight.bold),
          //   labelMedium: GoogleFonts.poppins(),
          //   labelSmall: GoogleFonts.poppins(),
          //   titleLarge: GoogleFonts.poppins(),
          //   titleMedium: GoogleFonts.poppins(),
          //   titleSmall: GoogleFonts.poppins(),
          // ),
        ),
        home: Scaffold(
          body: BlocConsumer<ChatRoomsCubit, ChatRoomsState>(
            listener: (context, state) {
              if (state.status.isOnlineDataEmpty) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchContactPage(),
                  ),
                );
              }
            },
            builder: (context, state) =>
                BlocBuilder<ChatRoomsCubit, ChatRoomsState>(
              builder: (context, state) {
                switch (state.status) {
                  case Status.initial:
                    return const Text("Initializing");
                  case Status.loading:
                    return const Text("Loading");
                  case Status.loadedFromNetwork:
                    return _buildCard(context, state.chatRooms);
                  case Status.failure:
                    return const Text("Failure");
                  case Status.storageEmpty:
                    return const Text("Storage Empty");
                  case Status.onlineDataEmpty:
                    return const Text("Online Data Empty");
                  case Status.loadedFromStorage:
                    return _buildCard(context, state.chatRooms);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildCard(context, List<ChatRoom> chatRoomModel) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        ChatRoom chatRoom = chatRoomModel[index];
        return GestureDetector(
            onTap: (() async {
              await mainNavKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => ChatRoomPage(chatRoom),
                ),
              );
            }),
            child: ChatListItem(chatRoom));
      },
      separatorBuilder: (context, index) => const Divider(
        height: 2,
      ),
      itemCount: chatRoomModel.length,
    );
  }
}
