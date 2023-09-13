import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:teknorix/mainpage/mainpage_states.dart';
import 'package:teknorix/repository/services.dart';
import 'package:teknorix/repository/user_model.dart';

import '../detailpage/detailspage_states.dart';

class ApiRepository {
  getUsersBySize(size) async {
    List<User> userData = [];
    //triggers api call
    final responseStatus = await getRequest();
    //converts  data to json from response
    if (responseStatus is ResponseSuccessful) {
      final jsonData = jsonDecode((responseStatus).response.body);

      //converts to dart model from json data
      if (responseStatus.response.body != '') {
        for (var i = 0; i < size; i++) {
          User temp = User.fromJson(jsonData['data'][i]);
          userData.add(temp);
        }

        return userData;
      }
    }
  }

  getMaxSize() async {
    //triggers api call
    final responseStatus = await getRequest();
    //converts  data to json from response
    if (responseStatus is ResponseSuccessful) {
      final jsonData = jsonDecode((responseStatus).response.body);
      return jsonData['data'].length;
    }
  }

  getUserById(userId) async {
    List<User> userData = [];
    //triggers api call
    final responseStatus = await getRequest();
    //converts  data to json from response
    if (responseStatus is ResponseSuccessful) {
      final jsonData = jsonDecode((responseStatus).response.body);

      //converts to dart model from json data
      if (responseStatus.response.body != '') {
        for (var i = 0; i < jsonData['data'].length; i++) {
          User temp = User.fromJson(jsonData['data'][i]);
          userData.add(temp);
        }
      }

      for (var i = 0; i < userData.length; i++) {
        if (userData[i].id == userId) {
          return userData[i];
        }
      }
    }
  }
}
