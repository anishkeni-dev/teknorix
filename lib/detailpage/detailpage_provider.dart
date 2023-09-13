//no specific reason to use this format, I just didn't want to use a state management library like bloc.

import '../repository/repository.dart';
import '../repository/user_model.dart';
import 'detailspage_states.dart';

class DetailPageProvider{

  ApiRepository repo = ApiRepository();

  getState(id) async{
    User userData = await repo.getUserById(id);
    if(userData.id!="") {
      return DetailsPageLoaded(userData);
    }
    else{
      return DetailsPageError();
    }

  }


}