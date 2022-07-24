import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CenterTextMessage extends StatelessWidget {
  const CenterTextMessage({
    Key? key,
    required this.content,
    this.size = 24,
  }) : super(key: key);

  final String content;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Text(
          content,
          style: TextStyle(
            fontSize: size,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
