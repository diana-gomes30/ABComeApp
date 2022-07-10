import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/screens/members/member_details_page.dart';
import 'package:abcome_app/widgets/item_members_list_widget.dart';
import 'package:flutter/material.dart';

class TabletMembersPage extends StatefulWidget {
  const TabletMembersPage({
    Key? key,
  }) : super(key: key);


  @override
  State<TabletMembersPage> createState() => _TabletMembersPageState();
}

class _TabletMembersPageState extends State<TabletMembersPage> {
  bool isLoading = false;

  List<Person> personList = [];
  int personLimit = 20;

  @override
  void initState() {
    super.initState();

    print('tablet_page');
    getData();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);
    personList = await PersonRepository.readAll();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: personList.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemMembersListWidget(
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
                setState(() => isLoading = true);
                personList = await PersonRepository.readAll();
                setState(() => isLoading = false);
              });
            },
          );
        },
      ),
    );
  }
}
