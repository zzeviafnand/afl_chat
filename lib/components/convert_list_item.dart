import 'package:flutter/material.dart';
import 'package:project_chat/components/profile_image.dart';

class ConvertListItem extends StatelessWidget {
  const ConvertListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text(
          "Documen.docx",
        ),
        dense: true,
        leading: CircleProfilePicture(),
        trailing: Icon(Icons.share_outlined),
      ),
    );
  }
}
