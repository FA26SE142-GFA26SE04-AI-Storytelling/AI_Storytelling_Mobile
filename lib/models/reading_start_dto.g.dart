// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_start_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReadingStartedDto _$ReadingStartedDtoFromJson(Map<String, dynamic> json) =>
    _ReadingStartedDto(
      sessionId: (json['sessionId'] as num).toInt(),
      storyId: (json['storyId'] as num).toInt(),
      resumed: json['resumed'] as bool? ?? false,
      lastPage: (json['lastPage'] as num?)?.toInt() ?? 1,
      lastReadingMode: json['lastReadingMode'] as String?,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      isFavorited: json['isFavorited'] as bool? ?? false,
      listenOnly: json['listenOnly'] as bool?,
    );

Map<String, dynamic> _$ReadingStartedDtoToJson(_ReadingStartedDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'storyId': instance.storyId,
      'resumed': instance.resumed,
      'lastPage': instance.lastPage,
      'lastReadingMode': instance.lastReadingMode,
      'isBookmarked': instance.isBookmarked,
      'isFavorited': instance.isFavorited,
      'listenOnly': instance.listenOnly,
    };

_ReadingFlagsDto _$ReadingFlagsDtoFromJson(Map<String, dynamic> json) =>
    _ReadingFlagsDto(
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      isFavorited: json['isFavorited'] as bool? ?? false,
      listenOnly: json['listenOnly'] as bool?,
    );

Map<String, dynamic> _$ReadingFlagsDtoToJson(_ReadingFlagsDto instance) =>
    <String, dynamic>{
      'isBookmarked': instance.isBookmarked,
      'isFavorited': instance.isFavorited,
      'listenOnly': instance.listenOnly,
    };

_ReadingProgressDto _$ReadingProgressDtoFromJson(Map<String, dynamic> json) =>
    _ReadingProgressDto(
      sessionId: (json['sessionId'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      readingMode: json['readingMode'] as String?,
      timeSpentSeconds: (json['timeSpentSeconds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReadingProgressDtoToJson(_ReadingProgressDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'page': instance.page,
      'readingMode': instance.readingMode,
      'timeSpentSeconds': instance.timeSpentSeconds,
    };

_ReadingCompletedDto _$ReadingCompletedDtoFromJson(Map<String, dynamic> json) =>
    _ReadingCompletedDto(
      sessionId: (json['sessionId'] as num).toInt(),
      storyId: (json['storyId'] as num).toInt(),
      isRetake: json['isRetake'] as bool? ?? false,
      roadmapStepCompleted: json['roadmapStepCompleted'] as bool? ?? false,
      expGained: (json['expGained'] as num?)?.toInt() ?? 0,
      newBadges:
          (json['newBadges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ReadingCompletedDtoToJson(
  _ReadingCompletedDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'storyId': instance.storyId,
  'isRetake': instance.isRetake,
  'roadmapStepCompleted': instance.roadmapStepCompleted,
  'expGained': instance.expGained,
  'newBadges': instance.newBadges,
};

_ReadingSignalDto _$ReadingSignalDtoFromJson(Map<String, dynamic> json) =>
    _ReadingSignalDto(
      shouldExit: json['shouldExit'] as bool? ?? false,
      returnTo: json['returnTo'] as String?,
      message: json['message'] as String?,
      sessionStatus: json['sessionStatus'] as String?,
    );

Map<String, dynamic> _$ReadingSignalDtoToJson(_ReadingSignalDto instance) =>
    <String, dynamic>{
      'shouldExit': instance.shouldExit,
      'returnTo': instance.returnTo,
      'message': instance.message,
      'sessionStatus': instance.sessionStatus,
    };

_VocabularyDefinitionDto _$VocabularyDefinitionDtoFromJson(
  Map<String, dynamic> json,
) => _VocabularyDefinitionDto(
  vocabularyId: (json['vocabularyId'] as num).toInt(),
  term: json['term'] as String,
  definition: json['definition'] as String? ?? '',
  isCollected: json['isCollected'] as bool? ?? false,
);

Map<String, dynamic> _$VocabularyDefinitionDtoToJson(
  _VocabularyDefinitionDto instance,
) => <String, dynamic>{
  'vocabularyId': instance.vocabularyId,
  'term': instance.term,
  'definition': instance.definition,
  'isCollected': instance.isCollected,
};
