import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tarstest/core/app_colors.dart';
import 'package:tarstest/home/models/list_people_response.dart';
import 'package:tarstest/home/models/people.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tarstest/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  late HttpService http;

  late ListPeopleResponse listPeopleResponse;

  late List<People> peoples;

  Future getListPeople() async {
    Response response;

    try {
      isLoading = true;

      response = await http.getRequest("peoples");

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          listPeopleResponse = ListPeopleResponse.fromJson(response.data);
          peoples = listPeopleResponse.peoples;
        });
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpService();
    getListPeople();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : peoples != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final people = peoples[index];

                      return ListTile(title: Text(people.name));
                    },
                    itemCount: peoples.length)
                : Center(child: Text("No people")),
      ),
    );
  }
}
