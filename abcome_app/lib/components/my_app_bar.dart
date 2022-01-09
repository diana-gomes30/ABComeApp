
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color(0xff161837),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}