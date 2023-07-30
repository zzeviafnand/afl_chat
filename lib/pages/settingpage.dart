import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/pages/profile/profile_page.dart';

import '../cubit/user_auth_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context
                                .read<UserAuthCubit>()
                                .getUserProfile()
                                ?.fullName ??
                            context
                                .read<UserAuthCubit>()
                                .getUserProfile()
                                ?.phone ??
                            ""),
                        Text(context
                                .read<UserAuthCubit>()
                                .getUserProfile()
                                ?.phone ??
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
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              )),
              child: const ListTile(
                leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(Icons.person_outline_outlined)),
                title: Text(
                  "Akun",
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 40, 51, 50)),
                ),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
            GestureDetector(
              onTap: (() => FirebaseAuth.instance.signOut()),
              child: const ListTile(
                leading: SizedBox(
                    height: 30, width: 30, child: Icon(Icons.logout_outlined)),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(0, 40, 51, 50)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
