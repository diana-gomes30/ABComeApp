import 'dart:io';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/icon_bottom_sheet_widget.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String defaultImagePath = kLogoImagePath;
  bool wasPresident = false;
  bool wasTreasurer = false;

  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    print('IdPerson: ${widget.personId}');
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: isEditing ? 'Editar Membro' : 'Adicionar Membro',
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          isEditing ? Icons.save : Icons.add,
          color: kWhiteColor,
        ),
        onPressed: () async {
          print('AQUI - Update: $isEditing');
          isEditing ? await updatePerson() : await insertPerson();
        },
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              ProfileWidget(
                imagePath: imagePath != '' ? imagePath : defaultImagePath,
                onClicked: () async {
                  await modalBottomSheet();
                },
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*Container(
                        width: MediaQuery.of(context).size.width*0.50,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                      ),*/
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          autofocus: false,
                          controller: nameController,
                          decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kPrimaryColor,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kPrimaryColor,
                                width: 1.0,
                              ),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: 'Nome',
                            labelStyle: const TextStyle(
                              color: kSecondaryColor,
                            ),
                            hintText: 'Insira o seu nome',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15.0),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: kSecondaryColor,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: CheckboxListTile(
                          activeColor: kPrimaryColor,
                          title: const Text(
                            'Já foi Presidente?',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: wasPresident,
                          onChanged: (value) {
                            setState(() {
                              wasPresident = value!;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: CheckboxListTile(
                          activeColor: kPrimaryColor,
                          title: const Text(
                            'Já foi Tesoureiro?',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: wasTreasurer,
                          onChanged: (value) {
                            setState(() {
                              wasTreasurer = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refreshData() async {
    setState(() => isLoading = true);

    nameController = TextEditingController(text: '');
    personId = widget.personId;

    if (personId != null) {
      isEditing = true;
      person = await PersonRepository.readById(personId!);
      if (person != null) {
        nameController = TextEditingController(text: person!.name);
        imagePath = person!.image;
        wasPresident = person!.wasPresident == 0 ? false : true;
        wasTreasurer = person!.wasTreasurer == 0 ? false : true;
      }
    } else {
      isEditing = false;
    }

    setState(() => isLoading = false);
  }

  Future insertPerson() async {
    if (nameController.text != '') {
      print('Controller Name: ${nameController.text}');
      final person = Person(
        name: nameController.text,
        image: imagePath,
        wasPresident: wasPresident ? 1 : 0,
        wasTreasurer: wasTreasurer ? 1 : 0,
        isVoting: 1, // True
        inactive: 0, // False
      );

      print('Person Name: ${person.name}');
      print('Person Image: ${person.image}');
      await PersonRepository.insert(person);
      Navigator.pop(context);
    }
    // por fazer show dialog
  }

  Future updatePerson() async {
    if (nameController.text != '') {
      final person = this.person!.copy(
            name: nameController.text,
            image: imagePath,
            wasPresident: wasPresident ? 1 : 0,
            wasTreasurer: wasTreasurer ? 1 : 0,
          );

      await PersonRepository.update(person);
      Navigator.pop(context);
    }
    // por fazer show dialog
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
