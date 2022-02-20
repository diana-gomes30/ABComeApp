import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemMembersListWidget extends StatelessWidget {
  const ItemMembersListWidget({
    Key? key,
    required this.person,
    required this.onClicked,
  }) : super(key: key);

  final Person person;
  final VoidCallback onClicked;

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
                    ? const Image(
                        image: AssetImage(kLogoImagePath),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Utils.imageFromBase64String(
                        person.image,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                '${person.id} - ${person.name}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
