
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:globalhealth/Constants/dbConnection.dart';
import 'package:globalhealth/Pages/getUserList.dart';
import 'package:globalhealth/drawer.dart';
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
    //
    dbconnection.getConnection();
    super.initState();
  }



  String? serverHealth = '';
  fetchServerStatus() async {
    var response = await serverFunctions.fetchData(
      url: "http://10.0.2.2:3000/api/health",
      // data: data,
    );
    print("response----health-----${response}");
    var mainrespo = jsonDecode(response);
    serverHealth = mainrespo["message"];
    setState(() {
      serverHealth = mainrespo["message"];
    });
  }

  // Future<List<Map<String, dynamic>>> fetchUsersDetails() async {
  //   final response = await http.get(Uri.parse('http://localhost:3000/users'));
  //   print("Details----response");
  //   if (response.statusCode == 200) {
  //     return List<Map<String, dynamic>>.from(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load users');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Users"),
      ),
      drawer: AppDrawer(),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            serverHealth == '' ? Container() : Text(
              '$serverHealth', style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
            ),

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
                    fetchServerStatus();
                  },
                  child: Text('Check Server Status', style: TextStyle(fontSize: 18),),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetUsersList()));
                  },
                  child: Text('View Users', style: TextStyle(fontSize: 18),),
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
