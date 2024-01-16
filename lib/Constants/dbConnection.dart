import 'dart:convert';

import 'package:globalhealth/APIs/Apis.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection, ObjectId;
import 'package:http/http.dart' as http;
class DBConnection {

  static DBConnection? _instance;

  final String _host = "127.0.0.1";
  final String _port = "27017";
  // final String _host =
      // "192.168.0.101";
      // "192.168.0.1";
  final String _dbName = "globalhealth NAME";
  Db? _db;

  static getInstance(){
    if(_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async{
    if (_db == null){
      try {
        _db = Db(_getConnectionString());
        await _db!.open();
        print("response db success----$_db");
      } catch(e){
        print("response db e----$e");
        print(e);
      }
    }
    return _db!;
  }

  _getConnectionString(){
    return "mongodb://$_host:$_port/$_dbName";
  }

  closeConnection() {
    _db!.close();
  }

  Future<List<Map<String, dynamic>>> getHealthData() async {
    final response = await http.get(Uri.parse(BASEURL+'health'));
    if (response.statusCode == 200) {
      // Assuming the API returns a list of health data
      return List<Map<String, dynamic>>.from(
        json.decode(response.body) as List<dynamic>,
      );
    } else {
      throw Exception('Failed to load health data');
    }
  }


  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    final db = await getConnection();
    final collection = db.collection('users');
    final user = await collection.findOne({'_id': ObjectId()});
    return user ?? {}; // Return an empty map if user is not found
  }

  // Function to update user details in MongoDB
  Future<void> updateUserDetails(String userId, Map<String, dynamic> newData) async {
    final db = await getConnection();
    final collection = db.collection('users');
    await collection.update(
      {'_id': ObjectId()},
      {'\$set': newData},
    );
  }

}