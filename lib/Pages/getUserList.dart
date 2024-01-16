
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:globalhealth/Constants/dbConnection.dart';
import 'package:globalhealth/Pages/Userspecificdetails.dart';
import 'package:http/http.dart' as http;
import '../APIs/Apis.dart';
import '../Models/UserModel.dart';

ServerFunctions serverFunctions = new ServerFunctions();

class GetUsersList extends StatefulWidget {
  const GetUsersList({super.key,});
  static const route = '/userlistscreen';
  @override
  State<GetUsersList> createState() => _GetUsersListState();
}

class _GetUsersListState extends State<GetUsersList> {

  var dbconnection = DBConnection();

  @override
  void initState() {
    fetchUsers();
    // dbconnection.getConnection();

    super.initState();
  }

  List<UserModel>? items;

  bool loadingdata = false;
  var responsebody = [{"_id":"65a6382a74efb95e4780237b",
    "firstName":"testing","lastName":"name","email":"test@gmail.com","__v":0},
    {"_id":"65a63a58bd9ee7ab35c00a4d","firstName":"testingrrr",
      "lastName":"namerrr","email":"testrrr@gmail.com","__v":0}];


  fetchUsers() async {

    setState(() {
      loadingdata = true;
    });
    // var response = await serverFunctions.fetchData(
    //   url: "http://localhost:3000/users",
    //   // data: data,
    // );
    final response = await http.get(Uri.parse('http://localhost:3000/users'));
    print("response----Users-----${response}");
    // if (response.statusCode == 200) {
    //   Iterable itemsJson = json.decode(responsebody);
      items = responsebody.map((item) => UserModel.fromJson(item)).toList();
      print("Users-----${items}");
      setState(() {
        loadingdata = false;
      });
      return items;
    // } else {
    //   setState(() {
    //     loadingdata = true;
    //   });
    //   throw Exception('Failed to load items');
    // }
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
        title: Text("All Users"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            loadingdata == false ?
              Center(child: CircularProgressIndicator()):
              ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: responsebody.length,
              itemBuilder: (BuildContext context, int index) {
              return
                  InkWell(
                  onTap: (){
                    // da.Data? job = parseJob(list[index].toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSpecificDetails(
                            )));
                  },
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.white,
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              'FirstName:',
                            ),
                            Spacer(),
                            Text(responsebody![index].length.toString(),
                            ),
                            SizedBox(width: 2,),
                          ],
                        ),
                        subtitle:
                        Column(
                          children: [
                            Row(
                              children: [

                                const Text(
                                  'LastName:',
                                ),
                                Spacer(),
                                Text(responsebody![index]!.length.toString(),
                                ),
                                SizedBox(width: 2,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                const Text(
                                  'Email:',
                                ),
                                Spacer(),
                                Text(responsebody![index]!.length.toString(),
                                ),
                                SizedBox(width: 2,),
                              ],
                            ),
                          ],
                        ),
                        trailing: Column(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UserSpecificDetails()));
                                },
                                child: Container(child: Icon(Icons.remove_red_eye))),
                            SizedBox(height: 6,),
                            InkWell(
                                onTap:(){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditSpecificDetails()));
                                },
                                child: Icon(Icons.edit)),
                            // Icon(Icons.delete_forever),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ;
              },
            ),
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
