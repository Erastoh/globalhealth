
import 'package:http/http.dart' as http;

class ServerFunctions {

  fetchData({String? url}) async {
    print("Url-------$url");
    try {
      var response = await http.get(
        Uri.parse(url!),
      );
      return response.body;
    } catch (e) {
      // printError(e);
    }
  }

  crudfunction({ Map<String, String>? data, String? url}) async {
    try {
      var response = await http.get(
        Uri.parse(url!),
        // body: data,
        // headers: {HEADER: user!.loginToken!},
      );
      return response.body;
    } catch (e) {
      // printError(e);
    }
  }

}
