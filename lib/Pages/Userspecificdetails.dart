import 'package:flutter/material.dart';

class UserSpecificDetails extends StatefulWidget {
  const UserSpecificDetails({super.key,});

  @override
  State<UserSpecificDetails> createState() => _UserSpecificDetailsState();
}

class _UserSpecificDetailsState extends State<UserSpecificDetails> {
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
                  'FirstName:',
                ),
                Spacer(),
                Text("FirstName",
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
                  'LastName:',
                ),
                Spacer(),
                Text("LastName",
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
                Spacer(),
                Text("lastName!",
                ),
                SizedBox(width: 10,),
              ],
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
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {

                },
                child: Text('Delete User', style: TextStyle(fontSize: 20),),
              ),
            ),
          )

        ],
      ),
    );
  }
}
