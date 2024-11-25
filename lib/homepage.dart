import 'dart:convert';

import 'package:api_integration/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as webClient;

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  UserDataModel? uData;
  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    getQuotes();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: uData != null
            ? uData!.data.isNotEmpty
                ? ListView.builder(
                    itemCount: uData!.data.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              '${uData!.data[index].first_name} ${uData!.data[index].last_name}'),
                          subtitle: Text(uData!.data[index].email),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(uData!.data[index].avatar),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text("No Data Found"),
                  )
            : Center(
                child: Text("Data not received"),
              ),
      ),
    );
  }

  void getQuotes() async {
    String url = "https://reqres.in/api/users?page=2";
    webClient.Response response = await webClient.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);

      var actualData = jsonDecode(response.body);
      uData = UserDataModel.fromJson(actualData);
      setState(() {});
    }
  }
  // Future<UserDataModel> getQuotes() async {
  //   final response =
  //       await webClient.get(Uri.parse("https://reqres.in/api/users?page=2"));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responsedata = jsonDecode(response.body);
  //     UserDataModel newUser = UserDataModel.fromJson(responsedata);
  //     return newUser;
  //   }
  // }
}
