import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ApiResponse{}

class ResponseSuccessful extends ApiResponse{
  late Response response;

  ResponseSuccessful(this.response);

}
class ResponseUnsuccessful extends ApiResponse{
  String error = "Something went wrong! Please try again later.";
}

Future<ApiResponse> getRequest() async {
  //replace your restFull API here.

  final response = await http.get(Uri.https('reqres.in','api/users'));

  if (response.statusCode == 200) {
    return ResponseSuccessful(response);
  }
  else {
    return ResponseUnsuccessful();
  }

}