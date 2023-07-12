import 'package:bloc/bloc.dart';

class MainBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("ON EVENT, BLOC : $bloc, EVENT : $event");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("ON ERROR, BLOC : $bloc, ERROR : $error, STACKTRACE : $stackTrace");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("ON CHANGE, BLOC : $bloc, CHAHNGE : $change");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("ON TRANSITION, BLOC : $bloc, TRANSITION : $transition");
  }
}
