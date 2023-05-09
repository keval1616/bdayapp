import 'dart:io';

import 'package:bdayapp/app_route.dart';
import 'package:bdayapp/common/buttons.dart';
import 'package:bdayapp/common/custom_text_field.dart';
import 'package:bdayapp/common/input_field.dart';
import 'package:bdayapp/db/db_helper.dart';
import 'package:bdayapp/db/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  var selectedTime = TimeOfDay.now();
  var selectedDate = DateTime.now();
  _chooseTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> addTask() async {
    selectedDate.mobirthdab
    final BirthDayModel birthday = BirthDayModel(
      name: nameController.text,
      date: selectedDate.toString(),
      time: formattingTimeOfDay(selectedTime),
      image: imageFile!.path,
    );
    final int id = await DBHelper.insert(birthday);
  }

  _chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String formattingTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final date = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final format = DateFormat.jm();
    return format.format(date);
  }

  File? imageFile;

  Future getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // cropImage();
    } else {
      print("no image selected");
    }
  }

  Future getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // cropImage();
    } else {
      print("no image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Person"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Name',
                hintText: 'Name',
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Flexible(
                    child: CustomTextField(
                      readOnly: true,
                      label: ('Date'),
                      hintText: DateFormat.yMd().format(selectedDate),
                      onTap: () => _chooseDate(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: CustomTextField(
                      readOnly: true,
                      label: ('Time'),
                      hintText: formattingTimeOfDay(selectedTime),
                      onTap: () => _chooseTime(context),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Stack(fit: StackFit.loose, children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: (imageFile != null)
                            ? Image.file(
                                imageFile!,
                                height: 140,
                                width: 140,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/gallery.jpg",
                                width: 140.0,
                                height: 140.0,
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 90.0, right: 100.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 25.0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                            ),
                            color: Colors.white,
                            onPressed: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: Wrap(
                                        children: <Widget>[
                                          ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text('Gallery'),
                                              onTap: () async {
                                                Navigator.pop(context);
                                                await getFromGallery();
                                              }),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_camera),
                                            title: const Text('Camera'),
                                            onTap: () async {
                                              Navigator.pop(context);

                                              await getFromCamera();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 15,
              ),
              CommonAppButton(
                borderRadius: 10,
                onTap: () async {
                  addTask();
                  Navigator.pushReplacementNamed(context, MyRoutes.addBday);
                },
                icon: Icons.arrow_forward,
                text: "Send",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
