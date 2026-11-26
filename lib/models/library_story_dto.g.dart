// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_story_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LibraryStoryDto _$LibraryStoryDtoFromJson(Map<String, dynamic> json) =>
    _LibraryStoryDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      content: json['content'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      genre: json['genre'] as String?,
      moralLesson: json['moralLesson'] as String?,
      ageBand: json['ageBand'] as String? ?? '',
      source: json['source'] as String? ?? '',
      status: json['status'] as String? ?? '',
      isPublished: json['isPublished'] as bool? ?? false,
      authorUserId: (json['authorUserId'] as num?)?.toInt(),
      authorName: json['authorName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      viewCount: (json['viewCount'] as num?)?.toInt(),
      favoriteCount: (json['favoriteCount'] as num?)?.toInt(),
      hasQuiz: json['hasQuiz'] as bool?,
    );

Map<String, dynamic> _$LibraryStoryDtoToJson(_LibraryStoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'coverImageUrl': instance.coverImageUrl,
      'genre': instance.genre,
      'moralLesson': instance.moralLesson,
      'ageBand': instance.ageBand,
      'source': instance.source,
      'status': instance.status,
      'isPublished': instance.isPublished,
      'authorUserId': instance.authorUserId,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'viewCount': instance.viewCount,
      'favoriteCount': instance.favoriteCount,
      'hasQuiz': instance.hasQuiz,
    };

_LibraryStoryPageDto _$LibraryStoryPageDtoFromJson(Map<String, dynamic> json) =>
    _LibraryStoryPageDto(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => LibraryStoryDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LibraryStoryDto>[],
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
    );

Map<String, dynamic> _$LibraryStoryPageDtoToJson(
  _LibraryStoryPageDto instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'hasNextPage': instance.hasNextPage,
};

_MediaIllustrationDto _$MediaIllustrationDtoFromJson(
  Map<String, dynamic> json,
) => _MediaIllustrationDto(
  beatOrder: (json['beatOrder'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? '',
  url: json['url'] as String?,
);

Map<String, dynamic> _$MediaIllustrationDtoToJson(
  _MediaIllustrationDto instance,
) => <String, dynamic>{
  'beatOrder': instance.beatOrder,
  'status': instance.status,
  'url': instance.url,
};

_MediaAudioDto _$MediaAudioDtoFromJson(Map<String, dynamic> json) =>
    _MediaAudioDto(
      segmentOrder: (json['segmentOrder'] as num?)?.toInt() ?? 0,
      text: json['text'] as String? ?? '',
      status: json['status'] as String? ?? '',
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MediaAudioDtoToJson(_MediaAudioDto instance) =>
    <String, dynamic>{
      'segmentOrder': instance.segmentOrder,
      'text': instance.text,
      'status': instance.status,
      'url': instance.url,
    };

_MediaSceneDto _$MediaSceneDtoFromJson(Map<String, dynamic> json) =>
    _MediaSceneDto(
      sceneIndex: (json['sceneIndex'] as num?)?.toInt() ?? 0,
      text: json['text'] as String?,
      illustrations:
          (json['illustrations'] as List<dynamic>?)
              ?.map(
                (e) => MediaIllustrationDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <MediaIllustrationDto>[],
      audio:
          (json['audio'] as List<dynamic>?)
              ?.map((e) => MediaAudioDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MediaAudioDto>[],
    );

Map<String, dynamic> _$MediaSceneDtoToJson(_MediaSceneDto instance) =>
    <String, dynamic>{
      'sceneIndex': instance.sceneIndex,
      'text': instance.text,
      'illustrations': instance.illustrations,
      'audio': instance.audio,
    };

_StoryMediaPackageDto _$StoryMediaPackageDtoFromJson(
  Map<String, dynamic> json,
) => _StoryMediaPackageDto(
  scenes:
      (json['scenes'] as List<dynamic>?)
          ?.map((e) => MediaSceneDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MediaSceneDto>[],
);

Map<String, dynamic> _$StoryMediaPackageDtoToJson(
  _StoryMediaPackageDto instance,
) => <String, dynamic>{'scenes': instance.scenes};
