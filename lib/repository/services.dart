import 'package:http/http.dart' as http;


Future<dynamic> getRequest() async {
  //replace your restFull API here.
  final response = await http.get(Uri.https('reqres.in','api/users'));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return response;
  }
  // else if(response.statusCode)
  else {
    throw Exception('Failed to load data from the API');
  }

}