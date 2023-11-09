part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class GetUsersEvent extends UsersEvent {}

class NextUserEvent extends UsersEvent {}

class PrevUserEvent extends UsersEvent {}

class GetAlbumsEvent extends UsersEvent {}

class GetPhotosEvent extends UsersEvent {
  final int albumId;

  GetPhotosEvent({required this.albumId});
}

class GetAllPhotosEvent extends UsersEvent {}
