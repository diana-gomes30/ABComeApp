import 'dart:io';
import 'package:abcome_app/repositories/person_repository.dart';
import 'package:abcome_app/responsive/mobile/members/mobile_member_details_page.dart';
import 'package:abcome_app/responsive/responsive_layout.dart';
import 'package:abcome_app/responsive/tablet/members/tablet_member_details_page.dart';
import 'package:abcome_app/screens/members/members_page.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:abcome_app/widgets/icon_bottom_sheet_widget.dart';
import 'package:abcome_app/widgets/my_app_bar.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
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
        actions: [
          Visibility(
            visible: isEditing,
            child: PopupMenuButton<int>(
              onSelected: (value) async {
                if (value == 1) {
                  await onClickDeletePerson();
                }
              },
              offset: Offset(0.0, AppBar().preferredSize.height),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
                      Text('Apagar Membro'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
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
        child: ResponsiveLayout(
          mobileBody: MobileMemberDetailsPage(
            imagePath: imagePath,
            nameController: nameController,
            wasPresident: wasPresident,
            wasTreasurer: wasTreasurer,
            onClickedImage: () async => await modalBottomSheet(),
            onChangedPresident: (value) {
              setState(() => wasPresident = value);
            },
            onChangedTreasurer: (value) {
              setState(() => wasTreasurer = value);
            },
          ),
          tabletBody: TabletMemberDetailsPage(
            imagePath: imagePath,
            nameController: nameController,
            wasPresident: wasPresident,
            wasTreasurer: wasTreasurer,
            onClickedImage: () async => await modalBottomSheet(),
            onChangedPresident: (value) {
              setState(() => wasPresident = value);
            },
            onChangedTreasurer: (value) {
              setState(() => wasTreasurer = value);
            },
          ),
        ),
      ),
    );
  }

  Future<void> onClickDeletePerson() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          title: const Text('Atenção!'),
          content: const Text(
              'Tem a certeza que pretende remover o membro do grupo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () async {
                setState(() => isLoading = true);
                final statusPersonUpdated = person!.copy(
                  inactive: 1,
                );

                await PersonRepository.update(statusPersonUpdated);
                setState(() => isLoading = true);
                Navigator.popAndPushNamed(context, MembersPage.id);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshData() async {
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
        print('President: $wasPresident');
        wasTreasurer = person!.wasTreasurer == 0 ? false : true;
        print('Treasurer: $wasTreasurer');
      }
    } else {
      isEditing = false;
    }

    setState(() => isLoading = false);
  }

  Future<void> insertPerson() async {
    if (nameController.text != '') {
      print('Controller Name: ${nameController.text}');
      final person = Person(
        name: nameController.text,
        image: imagePath,
        wasPresident: wasPresident ? 1 : 0,
        wasTreasurer: wasTreasurer ? 1 : 0,
        isVoting: 0, // True
        inactive: 0, // False
      );

      print('Person Name: ${person.name}');
      print('Person Image: ${person.image}');
      await PersonRepository.insert(person);
      Navigator.pop(context);
    }
    // por fazer show dialog
  }

  Future<void> updatePerson() async {
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
