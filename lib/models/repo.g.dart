// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) => Repo()
  ..id = json['id'] as num
  ..name = json['name'] as String
  ..full_name = json['full_name'] as String
  ..description = json['description'] as String
  ..fork = json['fork'] as String
  ..language = json['language'] as String?
  ..size = json['size'] as String
  ..default_branch = json['default_branch'] as String
  ..pushed_at = json['pushed_at'] as String
  ..created_at = json['created_at'] as String
  ..updated_at = json['updated_at'] as String
  ..license = json['license'] as Map<String, dynamic>?;

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'full_name': instance.full_name,
      'description': instance.description,
      'fork': instance.fork,
      'language': instance.language,
      'size': instance.size,
      'default_branch': instance.default_branch,
      'pushed_at': instance.pushed_at,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'license': instance.license,
    };
