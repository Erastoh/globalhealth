import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:globalhealth/Models/UserModel.dart';
import 'package:globalhealth/Pages/getUserList.dart';

ServerFunctions serverFunctions = new ServerFunctions();
class EditSpecificDetails extends StatefulWidget {
  final UserModel? userdetails;
  const EditSpecificDetails({super.key, this.userdetails});

  @override
  State<EditSpecificDetails> createState() => _EditSpecificDetailsState();
}

class _EditSpecificDetailsState extends State<EditSpecificDetails> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _secondnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    values();
    super.initState();
  }
  values(){
    setState(() {
      _firstnameController.text = widget.userdetails!.firstName!;
      _secondnameController.text = widget.userdetails!.lastName!;
      _emailController.text = widget.userdetails!.email!;
    });

  }

  bool loadinghit = false;
  updateUser(String id) async{
    setState(() {
      loadinghit = true;
    });
    var data = {
      "firstName": _firstnameController.text,
      "lastName": _secondnameController.text,
      "email": _emailController.text
    };
    var response = await serverFunctions.updateData(
      url: "http://10.0.2.2:3000/users/$id",
      data: data,
    );
    var message = jsonDecode(response);
    print("response----Users-----${message}");
    if(message["_id"] == "$id"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetUsersList()));
      Fluttertoast.showToast(
          msg: message["message"],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM);

    }else{
      Fluttertoast.showToast(
          msg: "Failed to Update",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Edit Users"),
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
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                 updateUser(widget.userdetails!.sId!);
                },
                child: loadinghit == false ?
                Text('Update', style: TextStyle(fontSize: 20),): Center(child: CircularProgressIndicator()),
              ),
            ),
          )

        ],
      ),
    );
  }
}
