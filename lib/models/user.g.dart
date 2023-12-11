// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..login = json['login'] as String
  ..avatar_url = json['avatar_url'] as String
  ..name = json['name'] as String?
  ..location = json['location'] as String?
  ..email = json['email'] as String?
  ..created_at = json['created_at'] as String
  ..updated_at = json['updated_at'] as String;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatar_url,
      'name': instance.name,
      'location': instance.location,
      'email': instance.email,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
