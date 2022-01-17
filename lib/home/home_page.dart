import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tarstest/core/app_colors.dart';
import 'package:tarstest/create_person/create_person_page.dart';
import 'package:tarstest/shared/models/person_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tarstest/home/widgets/list_view_widget.dart';
import 'package:tarstest/shared/widgets/button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<PersonModel>?> futureListPersons;

  @override
  void initState() {
    futureListPersons = fetchListPersons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(color: AppColors.green500),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Good morning, Jardel Urban!",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ButtonWidget(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreatePersonPage(),
                              ),
                            );
                          },
                          text: "Add person")
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FutureBuilder<List<PersonModel>?>(
                        future: futureListPersons,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isEmpty) {
                            return Text("Vazio");
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return ListView.separated(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListViewWidget(
                                    id: snapshot.data![index].id,
                                    name: snapshot.data![index].name,
                                    age: snapshot.data![index].age,
                                    career: snapshot.data![index].career,
                                    photoURL: snapshot.data![index].photoURL);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(color: Colors.transparent),
                            );
                          } else if (snapshot.hasError) {
                            return Text("erro");
                          }
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<List<PersonModel>?> fetchListPersons() async {
    Response response;
    Dio dio = new Dio();

    try {
      response = await dio.get("${dotenv.env["URL"]}/person");

      if (response.statusCode == 200) {
        var listPersons = (response.data as List).map((item) {
          return PersonModel.fromJson(item);
        }).toList();

        return listPersons;
      } else {
        throw Exception('Failed to load list of peoples');
      }
    } on DioError catch (err) {
      print(err);
    }
  }
}
