import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/repositories/mandate_repository.dart';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/responsive/mobile/members/mobile_members_page.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/responsive/tablet/members/tablet_members_page.dart';
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
  int personLimit = 20;

  Mandate? currentMandate;

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() async {
    setState(() => isLoading = true);

    personsList = await PersonRepository.readAll();

    currentMandate = await MandateRepository.readActive();
    currentMandate ??= await MandateRepository.readLast();
    if(currentMandate != null) {
      personLimit = currentMandate!.personLimit;
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const MyAppBar(title: 'Membros'),
      drawer: const MyAppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kWhiteColor,
        ),
        onPressed: () {
          if (personsList.length < personLimit) {
            Navigator.pushNamed(context, MemberDetailsPage.id).whenComplete(
              () async {
                await getData();
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  title: const Center(
                    child: Text('Aviso!'),
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text(
                        'Desculpe, mas não é possível adicionar mais membros! '
                        '\nO limite está definido para $personLimit membros.'),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
            child: ResponsiveLayout(
                mobileBody: MobileMembersPage(
                  personList: personsList,
                  updateState: () => getData(),
                ),
                tabletBody: TabletMembersPage(
                  personList: personsList,
                  updateState: () => getData(),
                ),
              ),
          ),
    );
  }
}
