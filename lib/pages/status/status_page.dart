import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:project_chat/components/profile_image.dart';
import 'package:project_chat/cubit/contact_list_cubit.dart';
import 'package:project_chat/cubit/users_status_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:project_chat/models/user_profile.dart';
import 'package:project_chat/models/user_status.dart';
import 'package:project_chat/resource/extensions/ext.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  void initState() {
    super.initState();
    context.read<UsersStatusCubit>().getAllStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<UsersStatusCubit, UsersStatusState>(
        builder: (context, state) {
      return state.when(
          initial: () => const Text("Initial"),
          loading: () => const Text("Loading"),
          error: () => const Text("Error"),
          loaded: (userStatuses) {
            Logger().v(userStatuses.groupBy((n) => n.uid));
            return ListView.separated(
                itemBuilder: (context, yIndex) {
                  return StatusItem(userStatuses.groupBy((n) => n.uid), yIndex);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: userStatuses.groupBy((n) => n.uid).length);
          },
          created: () => Container());
    }));
  }
}

class StatusItem extends StatelessWidget {
  const StatusItem(
    this.userStatuses,
    this.yIndex, {
    super.key,
  });

  final int yIndex;
  final Map<String, List<UserStatusModel>> userStatuses;

  @override
  Widget build(BuildContext context) {
    UserProfile? userProfile = context
        .read<ContactListCubit>()
        .getUserProfileFromUID(userStatuses.keys.elementAt(yIndex));
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, xIndex) {
          if (yIndex == 0 && xIndex == 0) {
            return _buildAddItem(context, xIndex);
          }
          return _buildItem(context, xIndex);
        },
        separatorBuilder: (context, index) {
          return const VerticalDivider();
        },
        itemCount: userStatuses.values.elementAt(yIndex).length,
      ),
    );
  }

  AspectRatio _buildItem(BuildContext context, int xIndex) {
    UserProfile? userProfile = context
        .read<ContactListCubit>()
        .getUserProfileFromUID(userStatuses.keys.elementAt(yIndex));
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Container(
        width: 40,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(userStatuses.values
                      .elementAt(yIndex)
                      .elementAt(xIndex)
                      .statusImageUrl ??
                  ""),
              onError: (exception, stackTrace) {},
            )),
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DottedBorder(
                    color: Colors.blue,
                    borderType: BorderType.Circle,
                    radius: const Radius.circular(5),
                    padding: const EdgeInsets.all(2),
                    child: CircleProfilePicture(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          NetworkImage(userProfile?.photoUrl ?? ""),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                  ),
                ),
                Container(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color.fromARGB(100, 255, 255, 255),
                      ],
                    )),
                    child: Text(
                      userProfile!.fullName ?? userProfile.phone,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    )),
              ],
            )),
      ),
    );
  }

  DottedBorder _buildAddItem(BuildContext context, int xIndex) {
    UserStatusModel userStatus = UserStatusModel(
      uid: FirebaseAuth.instance.currentUser!.uid,
    );
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: GestureDetector(
          onTap: () =>
              context.read<UsersStatusCubit>().createStatus(userStatus),
          child: const Align(
            alignment: Alignment.center,
            child: CircleProfilePicture(
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
}
