import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_chat/components/barsearch.dart';
import 'package:project_chat/cubit/contact_list_cubit.dart';
import 'package:project_chat/models/user_profile.dart';
import 'package:project_chat/pages/contact/contact_list_item.dart';

class SearchContactPage extends StatefulWidget {
  const SearchContactPage({super.key});

  @override
  State<SearchContactPage> createState() => _SearchContactPageState();
}

class _SearchContactPageState extends State<SearchContactPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: searchAppBar(context),
      body: BlocBuilder<ContactListCubit, ContactListState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (userProfiles) => _buildContactList(userProfiles),
            error: (e, s) => const Center(child: Text("Error")),
            orElse: () => const Center(child: Text("Unknown Error")),
          );
        },
      ),
    );
  }

  _buildContactList(List<UserProfile> userProfiles) {
    return ListView.separated(
      itemCount: userProfiles.length,
      itemBuilder: (context, index) =>
          ContactListItem(userProfiles[index], index),
      separatorBuilder: (context, index) => const Divider(height: 2),
    );
  }
}
