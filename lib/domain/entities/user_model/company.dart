import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable(explicitToJson: true)
class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  @override
  String toString() =>
      'Company(name: $name, catchPhrase: $catchPhrase, bs: $bs)';

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
