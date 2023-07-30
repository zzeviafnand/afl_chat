import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/constants/chat_const.dart';
import 'package:project_chat/cubit/user_auth_cubit.dart';
import 'package:project_chat/main.dart';
import 'package:project_chat/pages/profile/profile_page.dart';
import 'package:project_chat/pages/contact/contact_page.dart';
import 'package:project_chat/pages/status/status_page.dart';

AppBar chatAppBar(BuildContext context, {bool isHome = false}) {
  return AppBar(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(12),
      ),
    ),
    centerTitle: true,
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Row(
      children: [
        const Text(
          "AFL Chat",
          style: TextStyle(
              //(106, 175, 100)
              color: Color(0xFFe8ebf3),
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        GestureDetector(
          onTap: (() => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchContactPage(),
                ),
              )),
          child: const Icon(
            Icons.search_sharp,
            size: 32.0,
            color: Color(0xFFe8ebf3),
          ),
        ),
        const VerticalDivider(),
        GestureDetector(
          onTap: () => mainNavKey.currentState!.push(MaterialPageRoute(
            builder: (context) => const EditProfilePage(),
          )),
          child: Container(
            width: 40,
            height: 40,
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
        ),
      ],
    ),
    bottom: !isHome
        ? null
        : PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 19),
                  child: const BodyPageBottomWidget(),
                ),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.white,
                    ),
                    Container(
                      width: double.infinity,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: ChatColor.primaryColor,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12))),
                    ),
                  ],
                )
              ],
            ),
          ),
  );
}

class BodyPageBottomWidget extends StatefulWidget {
  const BodyPageBottomWidget({
    super.key,
  });

  @override
  State<BodyPageBottomWidget> createState() => _BodyPageBottomWidgetState();
}

class _BodyPageBottomWidgetState extends State<BodyPageBottomWidget> {
  bool? isShowStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              bodyKey.currentState!.popUntil((route) => route.isFirst);
              setState(() {
                isShowStatus = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: isShowStatus != true ? const Color(0xFF011d5a) : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "CHAT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3c4df0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              bodyKey.currentState!.push(MaterialPageRoute(
                builder: (context) => const StatusPage(),
              ));
              setState(() {
                isShowStatus = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: isShowStatus == true ? const Color(0xFF011d5a) : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "STORY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3c4df0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
