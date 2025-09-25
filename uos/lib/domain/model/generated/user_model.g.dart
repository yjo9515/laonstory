// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      idx: (json['idx'] as num?)?.toInt(),
      id: json['id'] as String?,
      name: json['name'] as String?,
      nameEn: json['name_en'] as String?,
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      country: json['country'] as String?,
      countryEn: json['country_en'] as String?,
      city: json['city'] as String?,
      cityEn: json['city_en'] as String?,
      affiliation: json['affiliation'] as String?,
      dept: json['dept'] as String?,
      position: json['position'] as String?,
      major: json['major'] as String?,
      majorEn: json['major_en'] as String?,
      researchField: json['research_field'] as String?,
      admission: json['admission'] as String?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      img: json['img'] as String?,
      roleUser: json['ROLE_USER'] as String?,
      sns: (json['sns'] as List<dynamic>?)
          ?.map((e) => Sns.fromJson(e as Map<String, dynamic>))
          .toList(),
      imgPath: json['img_path'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'idx': instance.idx,
      'id': instance.id,
      'name': instance.name,
      'name_en': instance.nameEn,
      'nickname': instance.nickname,
      'email': instance.email,
      'phone': instance.phone,
      'country': instance.country,
      'country_en': instance.countryEn,
      'city': instance.city,
      'city_en': instance.cityEn,
      'affiliation': instance.affiliation,
      'dept': instance.dept,
      'position': instance.position,
      'major': instance.major,
      'major_en': instance.majorEn,
      'research_field': instance.researchField,
      'admission': instance.admission,
      'birthday': instance.birthday?.toIso8601String(),
      'img': instance.img,
      'img_path': instance.imgPath,
      'ROLE_USER': instance.roleUser,
      'sns': instance.sns,
    };

Sns _$SnsFromJson(Map<String, dynamic> json) => Sns(
      social: json['social'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SnsToJson(Sns instance) => <String, dynamic>{
      'social': instance.social,
      'url': instance.url,
    };
