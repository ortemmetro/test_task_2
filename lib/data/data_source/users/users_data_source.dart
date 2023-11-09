import 'package:tinder_like_application/data/data_source/remote/dio/dio_client.dart';
import 'package:tinder_like_application/data/data_source/remote/dio/endpoints/dio_endpoints.dart';
import 'package:tinder_like_application/domain/entities/album_model/album_model.dart';
import 'package:tinder_like_application/domain/entities/photo_model/photo_model.dart';
import 'package:tinder_like_application/domain/entities/user_model/user_model.dart';

class UserDataSource {
  final DioClient client;
  const UserDataSource(this.client);

  Future<List<UserModel>> getUsers() async {
    final response = await client.get(
      DioEndpoints.userEndpoint,
    );

    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<AlbumModel>> getAlbums() async {
    final response = await client.get(
      DioEndpoints.albumsEndpoint,
    );

    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((album) => AlbumModel.fromJson(album))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<PhotoModel>> getPhotosById(int albumId) async {
    final response = await client.get(
      DioEndpoints.photosEndpoint(albumId),
    );

    if (response.statusCode == 200) {
      return (response.data as List<dynamic>)
          .map((photo) => PhotoModel.fromJson(photo))
          .toList();
    } else {
      return [];
    }
  }
}
