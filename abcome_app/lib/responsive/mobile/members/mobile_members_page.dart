import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/screens/members/member_details_page.dart';
import 'package:abcome_app/widgets/item_members_list_widget.dart';
import 'package:flutter/material.dart';

class MobileMembersPage extends StatelessWidget {
  const MobileMembersPage({
    Key? key,
    required this.personList,
    required this.updateState,
  }) : super(key: key);

  final List<Person> personList;
  final VoidCallback updateState;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: personList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemMembersListWidget(
            isTablet: false,
            person: personList[index],
            onClicked: () {
              final int? personId = personList[index].id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberDetailsPage(
                    personId: personId,
                  ),
                ),
              ).whenComplete(updateState);
            },
          );
        },
      ),
    );
  }
}

/*
ListView.builder(
        itemCount: personList.length,
        itemBuilder: (BuildContext context, int index) {
          return MobileItemMembersList(
            person: personList[index],
            onClicked: () {
              final int? personId = personList[index].id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberDetailsPage(
                    personId: personId,
                  ),
                ),
              ).whenComplete(() async {
                await getData();
              });
            },
          );
        },
      ),
*/
