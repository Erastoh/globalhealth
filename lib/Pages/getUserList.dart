
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:globalhealth/Constants/dbConnection.dart';
import 'package:globalhealth/Pages/EditSpecificDetails.dart';
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
  List<dynamic>? decodedList;

  fetchUsers() async {
    // var response = dbconnection.getHealthData();
    var response = await serverFunctions.fetchData(
      url: "http://10.0.2.2:3000/users",
      // data: data,
    );
    print("response----Users-----${response}");
    setState(() {
      decodedList = json.decode(response);
      loadingdata = true;
    });

    // for (var item in decodedList) {
    //   print(item["_id"]);
    //   print(item["firstName"]);
    // }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              itemCount: decodedList!.length,
              itemBuilder: (BuildContext context, int index) {
              return
                  InkWell(
                  onTap: (){
                    // da.Data? job = parseJob(list[index].toString());
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => UserSpecificDetails(
                    //         )));
                  },
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.white,
                      child: ListTile(
                        // title: ,
                        subtitle:
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'FirstName:',
                                ),
                                Spacer(),
                                Text(decodedList![index]["firstName"],
                                ),
                                SizedBox(width: 2,),

                              ],
                            ),
                            // Divider(),
                            Row(
                              children: [
                                Divider(),

                                const Text(
                                  'LastName:',
                                ),
                                Spacer(),
                                Text(decodedList![index]["lastName"],
                                ),
                                SizedBox(width: 2,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            // Divider(),
                            Row(
                              children: [
                                const Text(
                                  'Email:',
                                ),
                                Spacer(),
                                Text(decodedList![index]["email"],
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
                                var details = jsonEncode(decodedList![index]);
                                UserModel user = userModelFromJson(details);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UserSpecificDetails(userdetails: user)));
                                },
                                child: Container(child: Icon(Icons.remove_red_eye))),
                            SizedBox(height: 6,),
                            InkWell(
                                onTap:(){
                                  var details = jsonEncode(decodedList![index]);
                                  UserModel user = userModelFromJson(details);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditSpecificDetails(userdetails: user)));
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
