import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tarstest/core/app_colors.dart';
import 'package:tarstest/home/models/people_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tarstest/home/widgets/list_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<PeopleModel>?> futureListPeople;

  @override
  void initState() {
    futureListPeople = fetchListPeople();
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
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Add person",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(5.0),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30.00))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.all(15))),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: FutureBuilder<List<PeopleModel>?>(
                        future: futureListPeople,
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

  Future<List<PeopleModel>?> fetchListPeople() async {
    Response response;
    Dio dio = new Dio();
    try {
      response = await dio.get("http://127.0.0.1:5001/peoples");

      if (response.statusCode == 200) {
        var listPeople = (response.data as List).map((item) {
          return PeopleModel.fromJson(item);
        }).toList();

        return listPeople;
      } else {
        throw Exception('Failed to load list of peoples');
      }
    } on DioError catch (err) {
      print(err);
    }
  }
}
