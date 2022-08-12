part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}


class LoadHomeScreenDataEvent extends HomeEvent {}


class UserMessageShown extends HomeEvent {
  final int id;

  UserMessageShown(this.id);
}
