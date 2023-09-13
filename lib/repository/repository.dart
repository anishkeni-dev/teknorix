import 'dart:convert';

import 'package:teknorix/deatailpage/detailspage_states.dart';
import 'package:teknorix/repository/services.dart';
import 'package:teknorix/repository/user_model.dart';

class ApiRepository {
  getUsers() async {
    List<User> userData = [];
    //triggers api call
    final responseJson = await getRequest();
    //converts  data to json from response
    final jsonData = jsonDecode(responseJson.body);
    //converts to dart model from json data
    for (var i = 0; i < jsonData['data'].length; i++) {
      User temp = User.fromJson(jsonData['data'][i]);
      userData.add(temp);
    }
    return userData;
  }

   getUserById(userId) async {
    List<User> userData = await getUsers();
    if(userData.isNotEmpty){
    for (var i = 0; i < userData.length; i++) {
      if (userData[i].id == userId) {
        return DetailsPageLoaded(userData[i]);
      }
    }}
    else if(userData.isEmpty) {
      return DetailsPageError();
    }
    else {
      return DetailsPageLoading();
    }
  }
}