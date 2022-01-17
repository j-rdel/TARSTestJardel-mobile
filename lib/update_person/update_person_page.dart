import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tarstest/core/core.dart';
import 'package:tarstest/home/home_page.dart';
import 'package:tarstest/shared/models/person_model.dart';
import 'package:tarstest/shared/widgets/button_widget.dart';
import 'package:tarstest/shared/widgets/form_input_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UpdatePersonPage extends StatefulWidget {
  final int id;
  const UpdatePersonPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _UpdatePersonPageState createState() => _UpdatePersonPageState();
}

class _UpdatePersonPageState extends State<UpdatePersonPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _careerController = TextEditingController();
  final _photoURLController = TextEditingController();

  var numMask =
      new MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')});

  late Future<PersonModel?> futureRoom;

  @override
  void initState() {
    super.initState();
    futureRoom = fetchPerson()
      ..then((result) {
        setState(() {
          PersonModel? someVal = result;
          _nameController.text = "${someVal!.name}";
          _ageController.text = "${someVal.age}";
          _careerController.text = "${someVal.career}";
          _photoURLController.text = "${someVal.photoURL}";
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.green500,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.green500),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update person",
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormInputWidget(
                        label: "Full name",
                        icon: Icons.person,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                      ),
                      FormInputWidget(
                        label: "Age",
                        icon: Icons.calendar_today,
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        mask: [numMask],
                      ),
                      FormInputWidget(
                        label: "Career",
                        icon: Icons.business_center,
                        controller: _careerController,
                        keyboardType: TextInputType.text,
                      ),
                      FormInputWidget(
                        label: "Photo URL",
                        icon: Icons.image,
                        controller: _photoURLController,
                        keyboardType: TextInputType.url,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                            width: double.infinity,
                            child: ButtonWidget(
                                onPressed: () async {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (_formKey.currentState!.validate()) {
                                    var response = await updatePerson();
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    if (response == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBarSuccess);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBarError);
                                    }
                                  }
                                },
                                text: "Update")),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  final snackBarSuccess = SnackBar(
      content: Text("Person updated successfully", textAlign: TextAlign.center),
      backgroundColor: Colors.greenAccent);

  final snackBarError = SnackBar(
      content: Text("Failed to update a person", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);

  Future<PersonModel?> fetchPerson() async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get("${dotenv.env["URL"]}/person/${widget.id}");

      if (response.statusCode == 200) {
        var person = response.data;
        return PersonModel.fromJson(person);
      } else {
        throw Exception('Failed to load list of peoples');
      }
    } on DioError catch (err) {
      print(err);
    }
  }

  Future<bool?> updatePerson() async {
    Response response;
    Dio dio = new Dio();

    Map data = {
      "name": _nameController.text,
      "age": _ageController.text,
      "career": _careerController.text,
      "photoURL": _photoURLController.text,
    };

    String body = json.encode(data);

    try {
      response = await dio.patch("http://127.0.0.1:5001/person/${widget.id}",
          data: body);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (err) {
      print(err);
    }
  }
}
