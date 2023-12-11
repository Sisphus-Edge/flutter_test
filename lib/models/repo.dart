import 'package:json_annotation/json_annotation.dart';

part 'repo.g.dart';

@JsonSerializable()
class Repo {
  Repo();

  late num id;
  late String name;
  late String full_name;
  late String description;
  late String fork;
  String? language;
  late String size;
  late String default_branch;
  late String pushed_at;
  late String created_at;
  late String updated_at;
  Map<String,dynamic>? license;
  
  factory Repo.fromJson(Map<String,dynamic> json) => _$RepoFromJson(json);
  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
