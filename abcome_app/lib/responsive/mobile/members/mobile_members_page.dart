import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/screens/members/member_details_page.dart';
import 'package:abcome_app/widgets/mobile/mobile_item_members_list.dart';
import 'package:flutter/material.dart';

class MobileMembersPage extends StatefulWidget {
  const MobileMembersPage({Key? key}) : super(key: key);

  @override
  State<MobileMembersPage> createState() => _MobileMembersPageState();
}

class _MobileMembersPageState extends State<MobileMembersPage> {
  bool isLoading = false;

  List<Person> personList = [];
  int personLimit = 20;

  @override
  void initState() {
    super.initState();

    print('mobile_page');
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
      child: ListView.builder(
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
    );
  }
}
