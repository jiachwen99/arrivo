import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class InitEvent extends HomeEvent {
  InitEvent();
  @override
  List<Object?> get props => [];
}

class FetchHomeEvent extends HomeEvent {
  final String? menu;
  FetchHomeEvent({required this.menu});
  @override
  List<Object?> get props => [];
}

class TestEvent extends HomeEvent {
  TestEvent();
  @override
  List<Object?> get props => [];
}
