import 'package:flutter/material.dart';

AppBar searchAppBar(context) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    bottom: PreferredSize(
        preferredSize: const Size.fromRadius(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Row(
              children: [
                Icon(Icons.search_outlined),
                VerticalDivider(),
                Text(
                  "Search",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        )),
  );
}
