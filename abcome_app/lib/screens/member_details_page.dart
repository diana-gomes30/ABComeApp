import 'dart:io';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/icon_bottom_sheet_widget.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MemberDetailsPage extends StatefulWidget {
  const MemberDetailsPage({Key? key, this.personId}) : super(key: key);
  static const String id = '/member_details_page';

  final int? personId;

  @override
  _MemberDetailsPageState createState() => _MemberDetailsPageState();
}

class _MemberDetailsPageState extends State<MemberDetailsPage> {
  late int? personId;
  late Person? person;
  late TextEditingController nameController;
  late String imagePath = '';

  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title:
              personId == null ? 'Adicionar Membro' : 'Editar Membro'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kSecondaryColor,
        ),
        onPressed: () async {
          await insertPerson();
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Row(
          children: [
            ProfileWidget(
              imagePath: imagePath != '' ? imagePath : 'images/logotipo.png',
              onClicked: () async {
                await modalBottomSheet();
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nome:',
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 75, vertical: 20),
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

  void refreshData() async {
    setState(() => isLoading = true);

    nameController = TextEditingController(text: '');
    personId = widget.personId ?? 1;

    if(personId != null) {
      person = await PersonRepository.readById(personId!);
      if (person != null) {
        nameController = TextEditingController(text: person!.name);
        imagePath = person!.image;
      }
    }

    setState(() => isLoading = false);
  }

  Future insertPerson() async {
    if (nameController.text != '') {
      final person = Person(
        name: nameController.text,
        image: imagePath,
      );

      await PersonRepository.insert(person);
    }
  }

  Future updatePerson() async {
    if (nameController.text != '') {
      final person = this.person!.copy(
            name: nameController.text,
            image: imagePath,
          );

      await PersonRepository.update(person);
    }
  }

  Future<void> _imgFromCamera() async {
    await _picker
        .pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    )
        .then((imgPicked) {
      if (imgPicked != null) {
        File imgFile = File(imgPicked.path);
        setState(() {
          imagePath = Utils.base64String(imgFile.readAsBytesSync());
        });
      }
    });
  }

  Future<void> _imgFromGallery() async {
    await _picker
        .pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    )
        .then((imgPicked) {
      if (imgPicked != null) {
        File imgFile = File(imgPicked.path);
        setState(() {
          imagePath = Utils.base64String(imgFile.readAsBytesSync());
        });
      }
    });
  }

  Future<void> modalBottomSheet() async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(30.0),
          height: 150.0,
          //color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IconBottomSheetWidget(
                color: Colors.pinkAccent,
                title: 'Galeria',
                icon: Icons.image,
                onPressed: () async {
                  await _imgFromGallery();
                },
              ),
              IconBottomSheetWidget(
                color: Colors.green,
                title: 'Câmara',
                icon: Icons.camera_alt,
                onPressed: () async {
                  await _imgFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
