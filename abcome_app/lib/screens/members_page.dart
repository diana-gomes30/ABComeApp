import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/widgets/item_members_list_widget.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/widgets/my_app_drawer.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'member_details_page.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({Key? key}) : super(key: key);
  static const String id = '/members_page';

  @override
  _MembersPageState createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  bool isLoading = false;

  List<Person> personsList = [];

  @override
  void initState() {
    super.initState();

    getPersons();
  }

  Future<void> getPersons() async {
    setState(() => isLoading = true);

    personsList = await PersonRepository.readAll();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Membros'),
      drawer: const MyAppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kSecondaryColor,
        ),
        onPressed: () {
          Navigator.pushNamed(context, MemberDetailsPage.id).whenComplete(
            () async {
              setState(() => isLoading = true);
              await getPersons();
              setState(() => isLoading = false);
            },
          );
        },
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: personsList.length,
        itemBuilder: (BuildContext context, int index) {
          final person = personsList[index];
          //get your item data here ...
          return ItemMembersListWidget(
            person: personsList[index],
            onClicked: () {
              final int? personId = personsList[index].id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberDetailsPage(
                    personId: personId,
                  ),
                ),
              ).whenComplete(() async {
                setState(() => isLoading = true);
                await getPersons();
                setState(() => isLoading = false);
              });
            },
          );
        },
      ),
    );
  }
}
