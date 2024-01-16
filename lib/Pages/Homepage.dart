
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:globalhealth/Constants/dbConnection.dart';
import 'package:globalhealth/Pages/getUserList.dart';
import 'package:http/http.dart' as http;
import '../APIs/Apis.dart';
import '../Models/UserModel.dart';

ServerFunctions serverFunctions = new ServerFunctions();

class HomePage extends StatefulWidget {
  const HomePage({super.key,});
  static const route = '/homepage-screen';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var dbconnection = DBConnection();

  @override
  void initState() {
    fetchUsers();
    dbconnection.getConnection();
    super.initState();
  }


    fetchUsers() async {
    // var response = await serverFunctions.fetchData(
    //   url: "http://localhost:3000/users",
    //   // data: data,
    // );
    final response = await http.get(Uri.parse('http://localhost:3000/users'));
    print("response----Users-----${response}");
    if (response.statusCode == 200) {
      Iterable itemsJson = json.decode(response.body);
      List<UserModel> items = itemsJson.map((item) => UserModel.fromJson(item)).toList();
      print("Users-----${items}");
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Users"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Check Server Status',
            ),
            // Text(
            //   '',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black12,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.height,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    fetchUsers();
                    // var response = dbconnection.getConnection();
                    // print("response-----$response");
                    // fetchUsers();
                  },
                  child: Text('Check Server Status'),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black12,
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    fetchUsers();
                    // var response = dbconnection.getConnection();
                    // print("response-----$response");
                    // fetchUsers();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetUsersList()));
                  },
                  child: Text('View Users'),
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
