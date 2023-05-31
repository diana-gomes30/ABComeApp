import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PersonImage extends StatelessWidget {
  const PersonImage({
    Key? key,
    required this.imagePath,
    required this.size,
  }) : super(key: key);

  final String imagePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: imagePath == ''
            ? Image(
                image: const AssetImage(kLogoImagePath),
                width: size,
                height: size,
                fit: BoxFit.cover,
              )
            : Utils.imageFromBase64String(
                imagePath,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
