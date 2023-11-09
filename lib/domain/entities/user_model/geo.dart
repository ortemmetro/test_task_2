import 'package:json_annotation/json_annotation.dart';

part 'geo.g.dart';

@JsonSerializable(explicitToJson: true)
class Geo {
  final String lat;
  final String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  @override
  String toString() => 'Geo(lat: $lat, lng: $lng)';

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}
