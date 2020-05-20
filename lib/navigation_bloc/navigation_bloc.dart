import 'package:bloc/bloc.dart';
import 'package:travel_budget/views/myaccountspage.dart';
import 'package:travel_budget/views/myorderspage.dart';
//import 'package:travel_budget/views/homepage.dart';
//import 'package:travel_budget/views/Dashboard.dart';
import 'package:travel_budget/views/dashmain.dart';


enum NavigationEvents {
  // HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
  DashboardClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
 NavigationStates get initialState =>  MyApp();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield MyApp();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrdersPage();
        break;
    }
  }
}