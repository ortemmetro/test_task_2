part of 'users_bloc.dart';

@immutable
sealed class UsersState extends Equatable {
  final List<UserModel> users;
  final List<AlbumModel> albums;
  final UserModel? currentUser;
  final int currentAlbumId;
  final Map<int, List<PhotoModel>> mapAlbumPhotos;
  final List<PhotoModel> currentUserPhotos;

  const UsersState({
    required this.currentUserPhotos,
    required this.currentAlbumId,
    required this.mapAlbumPhotos,
    required this.albums,
    required this.users,
    this.currentUser,
  });

  @override
  List<Object?> get props => [
        users,
        albums,
        currentUser,
        mapAlbumPhotos,
        currentAlbumId,
        currentUserPhotos,
      ];
}

final class UsersInitial extends UsersState {
  const UsersInitial({
    required super.users,
    required super.currentUser,
    required super.albums,
    required super.mapAlbumPhotos,
    required super.currentAlbumId,
    required super.currentUserPhotos,
  });
}

final class UsersLoading extends UsersState {
  const UsersLoading({
    required super.users,
    required super.currentUser,
    required super.albums,
    required super.mapAlbumPhotos,
    required super.currentAlbumId,
    required super.currentUserPhotos,
  });
}

final class UsersLoaded extends UsersState {
  const UsersLoaded({
    required super.users,
    required super.currentUser,
    required super.albums,
    required super.mapAlbumPhotos,
    required super.currentAlbumId,
    required super.currentUserPhotos,
  });
}

final class UsersError extends UsersState {
  final String errorMessage;

  const UsersError({
    required this.errorMessage,
    required super.users,
    required super.currentUser,
    required super.albums,
    required super.mapAlbumPhotos,
    required super.currentAlbumId,
    required super.currentUserPhotos,
  });
}
