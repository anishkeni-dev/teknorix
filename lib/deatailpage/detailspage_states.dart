

import '../repository/user_model.dart';

abstract class DetailsPageStates{}
class DetailsPageInitial extends DetailsPageStates{

}
class DetailsPageLoaded extends DetailsPageStates{
  late User userData ;

  DetailsPageLoaded(this.userData);
}
class DetailsPageLoading extends DetailsPageStates{

}
class DetailsPageError extends DetailsPageStates{
  String error = "Something went wrong! Try again later." ;
}
