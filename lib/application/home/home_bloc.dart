import 'package:arrivo/application/home/home_event.dart';
import 'package:arrivo/application/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchHomeEvent>(
      (_, emit) async {
        try {
          emit(HomeSuccess(_.menu!));
        } catch (e) {
          emit(
            HomeError(e.toString()),
          );
        }
      },
    );
    on<TestEvent>((_, emit) {
      print('here');
    });
  }
}
