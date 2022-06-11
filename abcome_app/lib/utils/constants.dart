import 'package:flutter/cupertino.dart';

const kPrimaryColor = Color(0xff161837);
const kSecondaryColor = Color(0xFFD74500);
const kWhiteColor = Color(0xffffffff);

const String kBackgroundImagePath = 'assets/images/background.jpg';
const String kLogoImagePath = 'assets/images/logotipo.png';

BoxDecoration get textBoxDecoration {
  return BoxDecoration(
      color: kWhiteColor,
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          offset: const Offset(2.0, 2.0),
          blurRadius: 3.0,
          color: kPrimaryColor.withOpacity(0.5),
        ),
      ]);
}
