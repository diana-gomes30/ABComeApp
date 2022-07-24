import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TitleResultsPage extends StatelessWidget {
  const TitleResultsPage({
    Key? key,
    required this.title,
    this.padding=20,
  }) : super(key: key);

  final String title;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
