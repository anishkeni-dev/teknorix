//no specific reason to use this format, I just didn't want to use a state management library like bloc.

import '../repository/user_model.dart';

abstract class MainPageStates{}
class MainPageInitial extends MainPageStates{

}
class MainPageLoaded extends MainPageStates{
  List<User> userData = [];

  MainPageLoaded(this.userData);
}
class MainPageLoading extends MainPageStates{

}
class MainPageError extends MainPageStates{
  String error = "Something went wrong! Try again later." ;
}
