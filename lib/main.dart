import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_chat/cubit/chat_room_cubit.dart';
import 'package:project_chat/cubit/chat_rooms_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_chat/constants/chat_const.dart';
import 'package:project_chat/cubit/contact_list_cubit.dart';
import 'package:project_chat/cubit/notes_cubit.dart';
import 'package:project_chat/cubit/open_file/open_file_cubit.dart';
import 'package:project_chat/cubit/user_auth_cubit.dart';
import 'package:project_chat/cubit/users_status_cubit.dart';
import 'package:project_chat/main_homepage.dart';
import 'package:project_chat/pages/profile/profile_page.dart';

import 'cubit/file_converter/file_upload_cubit.dart';
import 'cubit/notification/notification_cubit.dart';
import 'pages/auth/sign_in.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OpenFileCubit(),
        ),
        BlocProvider(
          create: (context) => ChatRoomsCubit(),
        ),
        BlocProvider(
          create: (context) => ChatRoomCubit(),
        ),
        BlocProvider(
          create: (context) => UserAuthCubit(),
        ),
        BlocProvider(
          create: (context) => FileUploadCubit(),
        ),
        BlocProvider(
          create: (context) => NotesCubit(),
        ),
        BlocProvider(
          create: (context) => ContactListCubit(),
        ),
        BlocProvider(
          create: (context) => UsersStatusCubit(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
      ],
      child: const RootApp(),
    ),
  );
}

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> bodyKey = GlobalKey<NavigatorState>();

class _RootAppState extends State<RootApp> {
  @override
  void initState() {
    super.initState();
    context.read<UserAuthCubit>().checkUserProfileFromFirebase();
    NotificationCubit.notificationInitial();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAuthCubit, UserAuthState>(
      listener: (context, state) {
        if (state.status.isUserDataLoaded) {
          mainNavKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainHomePage(),
            ),
            ((Route<dynamic> route) => false),
          );
        }
        if (state.status.isUserDataInitializing) {
          mainNavKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const EditProfilePage(),
            ),
            ((Route<dynamic> route) => false),
          );
        }
        if (state.status.isInitial) {
          mainNavKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainChatHomePage(title: 'HFE Chat'),
            ),
            ((Route<dynamic> route) => false),
          );
        }
      },
      child: MaterialApp(
        navigatorKey: mainNavKey,
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          dividerTheme: const DividerThemeData(color: Colors.transparent),
          // useMaterial3: true,
          // primaryColor: ChatColor.primaryColor,
          // primarySwatch: ChatColor.primaryColor,
          scaffoldBackgroundColor: ChatColor.primaryColor,
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
        home: const MainChatHomePage(
          title: "HFE CHAT",
        ),
      ),
    );
  }
}

class MainChatHomePage extends StatefulWidget {
  const MainChatHomePage({super.key, required this.title});

  final String title;

  @override
  State<MainChatHomePage> createState() => _MainChatHomePageState();
}

class _MainChatHomePageState extends State<MainChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "WELCOME TO",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            Text(
              "AFL CHAT",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
            ),
            SvgPicture.asset('assets/welcome.svg'),
            const Divider(),
            const Text(
              "Connect - Chat - Share - Enjoy",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const InputPhoneNumberPage(),
                  ),
                ),
                child: const Text("MULAI"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "PENGATURAN",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            context.read<UserAuthCubit>().getUserPicture() ??
                                "https://images.pexels.com/photos/14226004/pexels-photo-14226004.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        const Text("William John Malik"),
                        const Text("Statusnya single"),
                        Text(FirebaseAuth.instance.currentUser!.phoneNumber ??
                            ""),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              height: 30,
            ),
            const ListTile(
              leading: SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(Icons.person_outline_outlined)),
              title: Text(
                "Akun",
                style: TextStyle(fontSize: 22),
              ),
              trailing: Icon(Icons.arrow_right),
            ),
            const Divider(
              height: 370,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF00a8f4),
                  shape: const StadiumBorder(
                    side: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text("KELUAR"),
              ),
            ),
            const Text("Tinggal navbar")
          ],
        ),
      ),
    );
  }
}
