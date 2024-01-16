import 'package:flutter/material.dart';

class EditSpecificDetails extends StatefulWidget {
  const EditSpecificDetails({super.key,});

  @override
  State<EditSpecificDetails> createState() => _EditSpecificDetailsState();
}

class _EditSpecificDetailsState extends State<EditSpecificDetails> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _secondnameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();


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

                },
                child: Text('Update', style: TextStyle(fontSize: 20),),
              ),
            ),
          )

        ],
      ),
    );
  }
}
