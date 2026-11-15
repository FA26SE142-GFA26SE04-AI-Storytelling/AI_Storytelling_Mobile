// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentCategoryDto _$ContentCategoryDtoFromJson(Map<String, dynamic> json) =>
    _ContentCategoryDto(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      displayName: json['displayName'] as String,
      isActive: json['isActive'] as bool,
      defaultBlockedAgeBands:
          (json['defaultBlockedAgeBands'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ContentCategoryDtoToJson(_ContentCategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'displayName': instance.displayName,
      'isActive': instance.isActive,
      'defaultBlockedAgeBands': instance.defaultBlockedAgeBands,
    };
