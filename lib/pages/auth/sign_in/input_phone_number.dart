import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_chat/constants/chat_const.dart';
import 'package:project_chat/cubit/user_auth_cubit.dart';

import 'input_otp.dart';

class InputPhoneNumberPage extends StatelessWidget {
  const InputPhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "AFL CHAT",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
              ),
              const Divider(),
              SvgPicture.asset('assets/person_chat.svg'),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Masukkan Nomor Telepon Anda Untuk Melanjutkan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              const SignInChatAppWithPhoneNumberWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInChatAppWithPhoneNumberWidget extends StatefulWidget {
  const SignInChatAppWithPhoneNumberWidget({super.key});

  @override
  State<SignInChatAppWithPhoneNumberWidget> createState() =>
      _SignInChatAppWithPhoneNumberWidgetState();
}

class _SignInChatAppWithPhoneNumberWidgetState
    extends State<SignInChatAppWithPhoneNumberWidget> {
  String number = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAuthCubit, UserAuthState>(
      listener: (context, state) {
        if (state.status.isNumberInvalid) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Nomor Anda Salah, Cek Lagi")));
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Error Hubungi Admin")));
        }
        if (state.status.isCodeSent) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const OTPPage(),
          ));
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Do you want to go back?'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.read<UserAuthCubit>().pop();
                        Navigator.pop(context, true);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
            return shouldPop!;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Stack(
                  children: [
                    if (state.status.isLoading)
                      const Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Align(
                            heightFactor: 0.5,
                            alignment: Alignment.centerRight,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          number = value;
                        });
                      },
                      readOnly: state.status.isLoading,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ChatColor.primaryColor,
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: state.status.isLoading
                      ? null
                      : () async => await context
                          .read<UserAuthCubit>()
                          .signInWithPhoneNumber(number),
                  child: state.status.isLoading
                      ? const Text("Loading...")
                      : const Text("LANJUT"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
