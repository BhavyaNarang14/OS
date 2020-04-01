import 'package:bloc/bloc.dart';
import 'package:sidebar/pages/February.dart';
import 'package:sidebar/pages/January.dart';
import 'package:sidebar/pages/homepage.dart';

enum NavigationEvents {
  HomepageClickedEvent, //March
  FebruaryClickedEvent,
  JanuaryClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();
  

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
   switch(event){
      case NavigationEvents.HomepageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.FebruaryClickedEvent:
        yield February();
        break;
      case NavigationEvents.JanuaryClickedEvent:
        yield January();
        break;
  }
  }
}
  
  //return null;


