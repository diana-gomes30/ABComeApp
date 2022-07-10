import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.isTablet,
    required this.onClicked,
    this.isSettingsPage = false,
  }) : super(key: key);

  final String imagePath;
  final bool isTablet;
  final VoidCallback onClicked;
  final bool isSettingsPage;

  @override
  Widget build(BuildContext context) {
    const color = kPrimaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.10, vertical: MediaQuery.of(context).size.height*0.05),
      child: Center(
        child: Stack(
          children: [
            buildImage(context),
            isSettingsPage
                ? const SizedBox(height: 0)
                : Positioned(
                    bottom: 0,
                    right: isTablet ? MediaQuery.of(context).size.width*0.03 : MediaQuery.of(context).size.width*0.05,
                    child: buildEditIcon(color, context),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Utils.imageFromBase64String(
          imagePath,
          width: isTablet ? MediaQuery.of(context).size.width*0.3 : MediaQuery.of(context).size.width*0.4, //isTablet ? 300.0 : 150.0,
          height: isTablet ? MediaQuery.of(context).size.width*0.3 : MediaQuery.of(context).size.width*0.4,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color, BuildContext context) => buildCircle(
        color: color,
        all: 0,
        size: isTablet ? MediaQuery.of(context).size.width*0.05 : MediaQuery.of(context).size.width*0.1,
        child: IconButton(
          icon: const Icon(Icons.edit),
          color: Colors.white,
          iconSize: isTablet ? MediaQuery.of(context).size.width*0.02 : MediaQuery.of(context).size.width*0.05,
          onPressed: onClicked,
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
    required double size,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          width: size,
          height: size,
          color: color,
          child: child,
        ),
      );
}
