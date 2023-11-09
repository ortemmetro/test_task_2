import 'package:tinder_like_application/data/data_source/users/users_data_source.dart';
import 'package:tinder_like_application/domain/entities/album_model/album_model.dart';
import 'package:tinder_like_application/domain/entities/common/error_model.dart';
import 'package:tinder_like_application/domain/entities/photo_model/photo_model.dart';
import 'package:tinder_like_application/domain/entities/user_model/user_model.dart';
import 'package:tinder_like_application/domain/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final UserDataSource _userDataSource;

  UserRepository({
    required UserDataSource userDataSource,
  }) : _userDataSource = userDataSource;

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      return await _userDataSource.getUsers();
    } catch (e) {
      throw mapToErrorModel(e);
    }
  }

  @override
  Future<List<AlbumModel>> getAlbums() async {
    try {
      return await _userDataSource.getAlbums();
    } catch (e) {
      throw mapToErrorModel(e);
    }
  }

  @override
  Future<List<PhotoModel>> getPhotosById(int albumId) async {
    try {
      return await _userDataSource.getPhotosById(albumId);
    } catch (e) {
      throw mapToErrorModel(e);
    }
  }
}
