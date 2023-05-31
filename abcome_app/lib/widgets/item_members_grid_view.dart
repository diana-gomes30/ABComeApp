import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemMembersGridView extends StatelessWidget {
  const ItemMembersGridView({
    Key? key,
    required this.person,
    required this.onClicked,
    required this.isTablet,
  }) : super(key: key);

  final Person person;
  final VoidCallback onClicked;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: person.image == ''
                    ? Image(
                        image: const AssetImage(kLogoImagePath),
                        width: isTablet ? MediaQuery.of(context).size.width*0.1 : MediaQuery.of(context).size.width*0.2,
                        height: isTablet ? MediaQuery.of(context).size.width*0.1 : MediaQuery.of(context).size.width*0.2,
                        fit: BoxFit.cover,
                      )
                    : Utils.imageFromBase64String(
                        person.image,
                        width: isTablet ? MediaQuery.of(context).size.width*0.1 : MediaQuery.of(context).size.width*0.2,
                        height: isTablet ? MediaQuery.of(context).size.width*0.1 : MediaQuery.of(context).size.width*0.2,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                person.name,
                style: TextStyle(fontSize: isTablet ? 20 : 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
