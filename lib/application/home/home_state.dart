import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
  get temp => null;
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final String menu;
  const HomeSuccess(this.menu);
  @override
  List<Object> get props => [menu];
}

class HomeError extends HomeState {
  final String errMessage;
  const HomeError(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}
