import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MobileMemberDetailsPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileWidget(
            imagePath: imagePath != '' ? imagePath : kLogoImagePath,
            onClicked: onClickedImage,
            isTablet: false,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05),
            width: MediaQuery.of(context).size.width*0.8,
            child: TextField(
              style: const TextStyle(
                fontSize: 14,
              ),
              autofocus: false,
              controller: nameController,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 1.0,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 1.0,
                  ),
                ),
                border: const OutlineInputBorder(),
                labelText: 'Nome',
                labelStyle: const TextStyle(
                  color: kSecondaryColor,
                ),
                hintText: 'Insira o seu nome',
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: kPrimaryColor.withOpacity(0.5),
                ),
                prefixIcon: const Icon(
                  FontAwesomeIcons.user,
                  color: kSecondaryColor,
                  size: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: CheckboxListTile(
              activeColor: kPrimaryColor,
              title: const Text(
                'Já foi Presidente?',
                style: TextStyle(fontSize: 14),
              ),
              value: wasPresident,
              onChanged: (value) => onChangedPresident(value),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: CheckboxListTile(
              activeColor: kPrimaryColor,
              title: const Text(
                'Já foi Tesoureiro?',
                style: TextStyle(fontSize: 14),
              ),
              value: wasTreasurer,
              onChanged: (value) => onChangedTreasurer(value),
            ),
          ),
        ]
      ),
    );
  }
}
