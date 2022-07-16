import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemMembersListView extends StatelessWidget {
  const ItemMembersListView({
    Key? key,
    required this.person,
    required this.onClicked,
  }) : super(key: key);

  final Person person;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 8.0,
      ),
      child: GestureDetector(
        onTap: onClicked,
        child: Card(
          elevation: 4.0,
          child: ListTile(
            leading: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: person.image == ''
                    ? const Image(
                        image: AssetImage(kLogoImagePath),
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                      )
                    : Utils.imageFromBase64String(
                        person.image,
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                      ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: Text(
                person.name,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
