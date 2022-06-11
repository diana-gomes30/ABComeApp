import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    this.isSettingsPage = false,
  }) : super(key: key);

  final String imagePath;
  final VoidCallback onClicked;
  final bool isSettingsPage;

  @override
  Widget build(BuildContext context) {
    const color = kPrimaryColor;
    return Container(
      padding: const EdgeInsets.only(left: 75, right: 75),
      child: Center(
        child: Stack(
          children: [
            buildImage(),
            isSettingsPage
                ? const SizedBox(height: 0)
                : Positioned(
                    bottom: 0,
                    right: 20,
                    child: buildEditIcon(color),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Utils.imageFromBase64String(
          imagePath,
          width: 300.0,
          height: 300.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: color,
        all: 0,
        child: IconButton(
          icon: const Icon(Icons.edit),
          color: Colors.white,
          iconSize: 20,
          onPressed: onClicked,
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
