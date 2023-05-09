import 'dart:io';
import 'dart:io';

import 'package:bdayapp/app_route.dart';
import 'package:bdayapp/db/db_helper.dart';
import 'package:bdayapp/db/model.dart';
import 'package:flutter/material.dart';

class AddBdayScreen extends StatefulWidget {
  const AddBdayScreen({Key? key}) : super(key: key);

  @override
  State<AddBdayScreen> createState() => _AddBdayScreenState();
}

class _AddBdayScreenState extends State<AddBdayScreen> {
  var birthdayList = <BirthDayModel>[];
  void getAllBirthDay() async {
    List<Map<String, dynamic>> birthday =
        await DBHelper.query() as List<Map<String, dynamic>>;
    setState(() {
      birthdayList =
          birthday.map((data) => BirthDayModel.fromJson(data)).toList();
      print(birthdayList);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllBirthDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Birthday Person"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, MyRoutes.home).then((value) {
            setState(() {});
          });
        },
      ),
      body: ListView.builder(
          itemCount: birthdayList.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Image.file(
                  File("${birthdayList[index].image}"),
                  height: 100,
                  width: 100,
                ),
                Column(
                  children: [
                    Text(
                      "${birthdayList[index].name}",
                    ),
                    Text(
                      "${birthdayList[index].date}",
                    ),
                    Text(
                      "${birthdayList[index].time}",
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
