import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_chat/constants/chat_const.dart';
import 'package:project_chat/cubit/user_auth_cubit.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset('assets/otp.svg'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Masukkan Kode OTP yang  telah dikirim ke (nomor hp)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Ganti Nomor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                const OTPVerificationWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPVerificationWidget extends StatefulWidget {
  const OTPVerificationWidget({super.key});

  @override
  State<OTPVerificationWidget> createState() => _OTPVerificationWidgetState();
}

class _OTPVerificationWidgetState extends State<OTPVerificationWidget> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAuthCubit, UserAuthState>(
      listener: (context, state) {
        if (state.status.isOtpInvalid) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "OTP Invalid")));
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: TextField(
                onChanged: (value) => setState(() {
                  otp = value;
                }),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
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
                    : () async =>
                        await context.read<UserAuthCubit>().verifyOtp(otp),
                child: state.status.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("LANJUT"),
              ),
            )
          ],
        );
      },
    );
  }
}
