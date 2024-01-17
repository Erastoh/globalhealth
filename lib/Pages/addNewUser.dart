import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:globalhealth/Models/UserModel.dart';
import 'package:globalhealth/Pages/getUserList.dart';

ServerFunctions serverFunctions = new ServerFunctions();
class AddNewUser extends StatefulWidget {

  const AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _secondnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool loadinghit = false;
  addNewUser() async{
    setState(() {
      loadinghit = true;
    });
    var data = {
      "firstName": "testingrzzr",
      "lastName":"namerzzr",
      "email":"testrzzr@gmail.com"
    };

    // var data = {
    //   "firstName": _firstnameController.text,
    //   "lastName": _secondnameController.text,
    //   "email": _emailController.text
    // };
    var response = await serverFunctions.adduserData(
      url: "http://10.0.2.2:3000/users",
      data: data,
    );
    var message = jsonDecode(response);
    print("response----Users-----${message}---errr ${message["error"]}");
    if(message["_id"] == "id"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetUsersList()));
      Fluttertoast.showToast(
          msg: message["message"],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM);

    }else if(message["error"].Contains("User validation failed")){
      Fluttertoast.showToast(
          msg: "Failed to Add",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM);
      setState(() {
        loadinghit = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Add User"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 8, right: 8),
            child: Text(
              'FirstName:',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              child: TextFormField(
                // keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty || !val!.contains("@")
                    ? "Enter Name"
                    : null,
                controller: _firstnameController,
                decoration: const InputDecoration(
                  labelText: 'Enter name...',
                  labelStyle: TextStyle(color: Colors.grey),
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.blue), // Change the color here
                  // ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Change the color here
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 8, right: 8),
            child: Text(
              'LastName:',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty || !val!.contains("@")
                    ? "Enter a valid email"
                    : null,
                controller: _secondnameController,
                decoration: const InputDecoration(
                  labelText: 'Enter Lastname...',
                  labelStyle: TextStyle(color: Colors.grey),
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.blue), // Change the color here
                  // ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Change the color here
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 8, right: 8),
            child: Text(
              'Email:',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty || !val!.contains("@")
                    ? "Enter a valid email"
                    : null,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Enter email...',
                  labelStyle: TextStyle(color: Colors.grey),
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.blue), // Change the color here
                  // ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Change the color here
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.black12,
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  addNewUser();
                },
                child: loadinghit == false ?
                Text('Submit', style: TextStyle(fontSize: 20),): Center(child: CircularProgressIndicator()),
              ),
            ),
          )

        ],
      ),
    );
  }
}
