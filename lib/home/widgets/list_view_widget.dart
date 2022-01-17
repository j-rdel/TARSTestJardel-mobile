import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tarstest/update_person/update_person_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListViewWidget extends StatelessWidget {
  final int id;
  final String name;
  final int age;
  final String career;
  final String photoURL;

  ListViewWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.age,
    required this.career,
    required this.photoURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(photoURL),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${name} - ${age} years old'),
                          Text('${career}'),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdatePersonPage(
                                          id: id,
                                        )));
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.greenAccent,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(
                                          "Do you want delete this person?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "No",
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            var response =
                                                await deletePerson(id);

                                            if (response == true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      snackBarSuccess);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBarError);
                                            }

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Yes",
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final snackBarSuccess = SnackBar(
      content: Text("Person deleted successfully", textAlign: TextAlign.center),
      backgroundColor: Colors.greenAccent);

  final snackBarError = SnackBar(
      content: Text("Failed to delete a person", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);

  Future<bool?> deletePerson(int id) async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.delete("${dotenv.env["URL"]}/person/${id}");
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
