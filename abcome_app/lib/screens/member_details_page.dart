import 'package:abcome_app/components/my_app_bar.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class MemberDetailsPage extends StatefulWidget {
  const MemberDetailsPage({Key? key, this.memberId}) : super(key: key);
  static const String id = '/member_details_page';

  final int? memberId;

  @override
  _MemberDetailsPageState createState() => _MemberDetailsPageState();
}

class _MemberDetailsPageState extends State<MemberDetailsPage> {
  late Person person;
  //final ImagePicker _picker = ImagePicker();

  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title:
              widget.memberId == null ? 'Adicionar Membro' : 'Editar Membro'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kSecondaryColor,
        ),
        onPressed: () {},
      ),
      body: Center(
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(50),
              width: 400,
              height: 400,
              child: const Image(
                image: AssetImage('images/logotipo.png'),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nome:',
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 20),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      autofocus: false,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
