import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.heightBox = 10.0,
    this.heightDivider = 1.0,
    this.start = 30.0,
    this.end = 30.0,
    this.color = kPrimaryColor
  }) : super(key: key);

  final double heightBox;
  final double heightDivider;
  final double start;
  final double end;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightBox,
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: start, end: end),
          height: heightDivider,
          color: color,
        ),
      ),
    );
  }
}