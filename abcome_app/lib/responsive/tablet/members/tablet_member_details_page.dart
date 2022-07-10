import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabletMemberDetailsPage extends StatefulWidget {
  const TabletMemberDetailsPage({
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
  State<TabletMemberDetailsPage> createState() =>
      _TabletMemberDetailsPageState();
}

class _TabletMemberDetailsPageState extends State<TabletMemberDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          children: [
            ProfileWidget(
              imagePath: widget.imagePath != '' ? widget.imagePath : kLogoImagePath,
              onClicked: widget.onClickedImage,
              isTablet: true,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        autofocus: false,
                        controller: widget.nameController,
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: kSecondaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: CheckboxListTile(
                        activeColor: kPrimaryColor,
                        title: const Text(
                          'Já foi Presidente?',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: widget.wasPresident,
                        onChanged: (value) => widget.onChangedPresident(value),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: CheckboxListTile(
                        activeColor: kPrimaryColor,
                        title: const Text(
                          'Já foi Tesoureiro?',
                          style: TextStyle(fontSize: 20),
                        ),
                        value: widget.wasTreasurer,
                        onChanged: (value) => widget.onChangedTreasurer(value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
