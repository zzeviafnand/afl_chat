import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/cubit/user_auth_cubit.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAuthCubit, UserAuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userData = state.userProfile;
        String fullName = userData?.fullName ?? "";
        String bio = userData?.bio ?? "";
        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            title: const Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              child: ListView(
                children: [
                  const UpdateUserProfileWidget(),
                  const Divider(),
                  Column(
                    children: [
                      const Divider(),
                      TextField(
                        onChanged: (value) => fullName = value,
                        controller: TextEditingController(text: fullName),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          labelText: "Nama Lengkap",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Masukkan Nama",
                          hintStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  TextField(
                    controller: TextEditingController(text: bio),
                    onChanged: (value) => bio = value,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(12),
                        labelText: "Bio",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Tulis Bio",
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        )),
                  ),
                  const Divider(),
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12),
                      labelText: "Nomor HP",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: userData?.phone,
                      hintStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF3c4df0),
                      ),
                      onPressed: () => {
                        if (userData != null)
                          {
                            context.read<UserAuthCubit>().updateUserProfile(
                                userData.copyWith(fullName: fullName, bio: bio))
                          }
                      },
                      child: const Text(
                        "SIMPAN",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class UpdateUserProfileWidget extends StatelessWidget {
  const UpdateUserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 130,
            height: 130,
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                color: Colors.white,
                onPressed: () {
                  context.read<UserAuthCubit>().uploadProfilePicture();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
