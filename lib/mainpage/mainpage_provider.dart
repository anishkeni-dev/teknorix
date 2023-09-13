
import 'package:teknorix/repository/user_model.dart';

import '../repository/repository.dart';
import 'mainpage_states.dart';

class MainPageProvider{
  ApiRepository repo = ApiRepository();

  getState(int size) async{
    List<User> userData = await repo.getUsersBySize(size);
    if(userData.isNotEmpty){
      return MainPageLoaded(userData);
    }
    else{
      return MainPageError();
    }

  }

  getMaxSize()async {
   var size= await repo.getMaxSize();
   return size;
  }




}