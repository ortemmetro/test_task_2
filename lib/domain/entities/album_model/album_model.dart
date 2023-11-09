import 'package:json_annotation/json_annotation.dart';

part 'album_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  @override
  String toString() => 'AlbumModel(userId: $userId, id: $id, title: $title)';

  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}
