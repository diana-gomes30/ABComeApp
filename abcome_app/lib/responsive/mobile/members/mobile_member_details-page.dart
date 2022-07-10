import 'package:flutter/material.dart';

class MobileMemberDetailsPage extends StatefulWidget {
  const MobileMemberDetailsPage({
    Key? key,
    required this.imagePath,
    required this.nameController,
    required this.wasPresident,
    required this.wasTreasurer,
    required this.onClickedImage,
    required this.onChangedPresident,
    required this.onChangedTreasurer,
  }) : super(key: key);

  final String imagePath;
  final TextEditingController nameController;
  final bool wasPresident;
  final bool wasTreasurer;
  final VoidCallback onClickedImage;
  final Function onChangedPresident;
  final Function onChangedTreasurer;

  @override
  State<MobileMemberDetailsPage> createState() =>
      _MobileMemberDetailsPageState();
}

class _MobileMemberDetailsPageState extends State<MobileMemberDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green,);
  }
}
