import 'package:flutter/material.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    required this.tabletBody,
  }) : super(key: key);
  final Widget mobileBody;
  final Widget tabletBody;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    print('responsive');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          print('mobile');
          return widget.mobileBody;
        } else {
          print('tablet');
          return widget.tabletBody;
        }
      },
    );
  }
}
