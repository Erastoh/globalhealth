
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:http/http.dart' as http;

import '../APIs/Apis.dart';
import '../Constants/ServerFunctions.dart';
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

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }


  Future<List<UserModel>> fetchUsers() async {
    var response = await serverFunctions.fetchData(
      url: allusers,
      // data: data,
    );
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
            Text(
              '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
