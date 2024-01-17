import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:globalhealth/Constants/ServerFunctions.dart';
import 'package:globalhealth/Models/UserModel.dart';
import 'package:globalhealth/Pages/Homepage.dart';
import 'package:globalhealth/Pages/getUserList.dart';

ServerFunctions serverFunctions = new ServerFunctions();
class UserSpecificDetails extends StatefulWidget {
  final UserModel? userdetails;
  const UserSpecificDetails({super.key, this.userdetails});

  @override
  State<UserSpecificDetails> createState() => _UserSpecificDetailsState();
}

class _UserSpecificDetailsState extends State<UserSpecificDetails> {
  bool loadinghit = false;
  deleteUser(String id) async{
    setState(() {
      loadinghit = true;
    });
    var response = await serverFunctions.deleteData(
      url: "http://10.0.2.2:3000/users/$id",
      // data: data,
    );
    print("response----Users-----${response}");
    var message = jsonDecode(response);

    if(message["message"] == "User deleted successfully"){
      Fluttertoast.showToast(
          msg: message["message"],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          gravity: ToastGravity.BOTTOM);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetUsersList()));

    }else if(message["error"] == "User not found"){
      Fluttertoast.showToast(
          msg: message["error"],
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
        title: Text("Users"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Text(
                  'FirstName: ',
                ),
                SizedBox(width: 10,),
                Text(widget.userdetails!.firstName!,
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                const Text(
                  'LastName: ',
                ),
                // Spacer(),
                SizedBox(width: 10,),
                Text(widget.userdetails!.lastName!,
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                const Text(
                  'Email:',
                ),
                // Spacer(),
                SizedBox(width: 10,),
                Text(widget.userdetails!.email!,
                ),
                SizedBox(width: 10,),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.1
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.black12,
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  deleteUser(widget.userdetails!.sId!);
                },
                child: loadinghit == false ?
                Text('Delete User', style: TextStyle(fontSize: 20),): Center(child: CircularProgressIndicator()),
              ),
            ),
          )

        ],
      ),
    );
  }
}
