// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tinder_like_application/domain/entities/album_model/album_model.dart';
import 'package:tinder_like_application/domain/entities/common/error_model.dart';
import 'package:tinder_like_application/domain/entities/photo_model/photo_model.dart';
import 'package:tinder_like_application/domain/entities/user_model/user_model.dart';
import 'package:tinder_like_application/domain/repositories/i_user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final IUserRepository _userRepository;

  UsersBloc(this._userRepository)
      : super(
          const UsersInitial(
            users: [],
            albums: [],
            currentUser: null,
            mapAlbumPhotos: {},
            currentUserPhotos: [],
            currentAlbumId: 0,
          ),
        ) {
    on<GetUsersEvent>(
      (event, emit) async {
        await _getUsersEvent(event, emit);
      },
      transformer: sequential(),
    );

    on<GetAlbumsEvent>(
      (event, emit) async {
        await _getAlbumsEvent(event, emit);
      },
      transformer: sequential(),
    );

    on<GetPhotosEvent>(
      (event, emit) async {
        await _getPhotosByIdEvent(event, emit);
      },
      transformer: sequential(),
    );

    on<NextUserEvent>(
      (event, emit) {
        _nextUser(event, emit);
      },
      transformer: sequential(),
    );

    on<PrevUserEvent>(
      (event, emit) {
        _prevUser(event, emit);
      },
      transformer: sequential(),
    );

    on<GetAllPhotosEvent>(
      (event, emit) async {
        await _getAllPhotosOfUser(event, emit);
      },
      transformer: sequential(),
    );
  }

  Future<void> _getUsersEvent(
    GetUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(
        UsersLoading(
          users: const [],
          albums: state.albums,
          currentUser: null,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentUserPhotos: state.currentUserPhotos,
          currentAlbumId: state.currentAlbumId,
        ),
      );

      final users = await _userRepository.getUsers();

      emit(
        UsersLoaded(
          users: users,
          albums: state.albums,
          currentUser: users[0],
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentUserPhotos: state.currentUserPhotos,
          currentAlbumId: state.currentAlbumId,
        ),
      );
    } on ErrorModel catch (e) {
      emit(
        UsersError(
          errorMessage: e.toString(),
          albums: state.albums,
          users: state.users,
          currentUser: state.currentUser,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentUserPhotos: state.currentUserPhotos,
          currentAlbumId: state.currentAlbumId,
        ),
      );
    }
  }

  Future<void> _getAlbumsEvent(
    GetAlbumsEvent event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(
        UsersLoading(
          users: state.users,
          albums: const [],
          currentUser: null,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentAlbumId: state.currentAlbumId,
          currentUserPhotos: state.currentUserPhotos,
        ),
      );

      final albums = await _userRepository.getAlbums();

      emit(
        UsersLoaded(
          users: state.users,
          albums: albums,
          currentUser: state.currentUser,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentAlbumId: state.currentAlbumId,
          currentUserPhotos: state.currentUserPhotos,
        ),
      );

      _setAlbumId();
    } on ErrorModel catch (e) {
      emit(
        UsersError(
          errorMessage: e.toString(),
          users: state.users,
          albums: state.albums,
          currentUser: state.currentUser,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentAlbumId: state.currentAlbumId,
          currentUserPhotos: state.currentUserPhotos,
        ),
      );
    }
  }

  Future<void> _getPhotosByIdEvent(
    GetPhotosEvent event,
    Emitter<UsersState> emit,
  ) async {
    if (event.albumId == 0) {
      return;
    }
    try {
      emit(
        UsersLoading(
          users: state.users,
          albums: state.albums,
          currentUser: state.currentUser,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentAlbumId: state.currentAlbumId,
          currentUserPhotos: state.currentUserPhotos,
        ),
      );

      if (state.mapAlbumPhotos.containsKey(event.albumId)) {
        emit(
          UsersLoaded(
            users: state.users,
            albums: state.albums,
            currentUser: state.currentUser,
            mapAlbumPhotos: state.mapAlbumPhotos,
            currentAlbumId: state.currentAlbumId,
            currentUserPhotos: state.currentUserPhotos,
          ),
        );
      } else {
        final photos = await _userRepository.getPhotosById(event.albumId);

        final Map<int, List<PhotoModel>> map = Map.from(state.mapAlbumPhotos);
        map.putIfAbsent(event.albumId, () => photos);

        emit(
          UsersLoaded(
            users: state.users,
            albums: state.albums,
            currentUser: state.currentUser,
            mapAlbumPhotos: map,
            currentAlbumId: state.currentAlbumId,
            currentUserPhotos: state.currentUserPhotos,
          ),
        );
      }
    } on ErrorModel catch (e) {
      emit(
        UsersError(
          errorMessage: e.toString(),
          users: state.users,
          albums: state.albums,
          currentUser: state.currentUser,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentAlbumId: state.currentAlbumId,
          currentUserPhotos: state.currentUserPhotos,
        ),
      );
    }
  }

  void _nextUser(
    NextUserEvent event,
    Emitter<UsersState> emit,
  ) {
    if (state.currentUser != null) {
      if (state.users.indexOf(state.currentUser!) == state.users.length - 1) {
        emit(
          UsersLoaded(
            users: state.users,
            albums: state.albums,
            currentUser: state.users[0],
            mapAlbumPhotos: state.mapAlbumPhotos,
            currentAlbumId: state.currentAlbumId,
            currentUserPhotos: state.currentUserPhotos,
          ),
        );

        _setAlbumId();
      } else {
        emit(
          UsersLoaded(
            users: state.users,
            albums: state.albums,
            currentUser:
                state.users[state.users.indexOf(state.currentUser!) + 1],
            mapAlbumPhotos: state.mapAlbumPhotos,
            currentAlbumId: state.currentAlbumId,
            currentUserPhotos: state.currentUserPhotos,
          ),
        );

        _setAlbumId();
      }
    }
  }

  void _prevUser(
    PrevUserEvent event,
    Emitter<UsersState> emit,
  ) {
    if (state.currentUser != null) {
      if (state.users.indexOf(state.currentUser!) == 0) {
        emit(
          UsersLoaded(
            users: state.users,
            albums: state.albums,
            currentUser: state.users[state.users.length - 1],
            mapAlbumPhotos: state.mapAlbumPhotos,
            currentAlbumId: state.currentAlbumId,
            currentUserPhotos: state.currentUserPhotos,
          ),
        );
        _setAlbumId();
      } else {
        emit(
          UsersLoaded(
            users: state.users,
            albums: state.albums,
            currentUser:
                state.users[state.users.indexOf(state.currentUser!) - 1],
            mapAlbumPhotos: state.mapAlbumPhotos,
            currentAlbumId: state.currentAlbumId,
            currentUserPhotos: state.currentUserPhotos,
          ),
        );
        _setAlbumId();
      }
    }
  }

  void _setAlbumId() {
    if (state.albums
        .where((element) => element.userId == state.currentUser?.id)
        .isNotEmpty) {
      emit(
        UsersLoaded(
          users: state.users,
          albums: state.albums,
          currentUser: state.currentUser,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentAlbumId: state.albums
              .where((element) => element.userId == state.currentUser?.id)
              .first
              .id,
          currentUserPhotos: state.currentUserPhotos,
        ),
      );
    } else {
      emit(
        UsersLoaded(
          users: state.users,
          albums: state.albums,
          currentUser: state.currentUser,
          mapAlbumPhotos: state.mapAlbumPhotos,
          currentAlbumId: state.currentAlbumId,
          currentUserPhotos: state.currentUserPhotos,
        ),
      );
    }
  }

  Future<void> _getAllPhotosOfUser(
    GetAllPhotosEvent event,
    Emitter<UsersState> emit,
  ) async {
    final albumsMap = Map.from(state.mapAlbumPhotos);
    final userId = state.currentUser!.id;
    final userAlbums =
        state.albums.where((element) => element.userId == userId).toList();

    final List<PhotoModel> photos = [];

    final tempPhotos = await _userRepository.getPhotosById(userAlbums[0].id);
    photos.addAll(tempPhotos);
    albumsMap.putIfAbsent(userAlbums[0].id, () => tempPhotos);

    emit(
      UsersLoaded(
        users: state.users,
        albums: state.albums,
        currentUser: state.currentUser,
        mapAlbumPhotos: state.mapAlbumPhotos,
        currentAlbumId: state.currentAlbumId,
        currentUserPhotos: photos,
      ),
    );
  }
}
