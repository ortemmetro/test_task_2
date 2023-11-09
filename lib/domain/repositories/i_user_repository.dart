import 'package:tinder_like_application/domain/entities/album_model/album_model.dart';
import 'package:tinder_like_application/domain/entities/photo_model/photo_model.dart';
import 'package:tinder_like_application/domain/entities/user_model/user_model.dart';

abstract class IUserRepository {
  Future<List<UserModel>> getUsers();
  Future<List<AlbumModel>> getAlbums();
  Future<List<PhotoModel>> getPhotosById(int albumId);
}
