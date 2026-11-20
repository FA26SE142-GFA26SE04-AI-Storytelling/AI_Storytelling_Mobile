// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_reading_feedback_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParentReadingFeedbackItemDto _$ParentReadingFeedbackItemDtoFromJson(
  Map<String, dynamic> json,
) => _ParentReadingFeedbackItemDto(
  sessionId: (json['sessionId'] as num).toInt(),
  storyId: (json['storyId'] as num).toInt(),
  title: json['title'] as String,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  feeling: json['feeling'] as String?,
  feelingLabel: json['feelingLabel'] as String?,
  quizTotalQuestions: (json['quizTotalQuestions'] as num?)?.toInt() ?? 0,
  quizBestPercent: (json['quizBestPercent'] as num?)?.toDouble(),
  conversationAnswers:
      (json['conversationAnswers'] as List<dynamic>?)
          ?.map(
            (e) => ConversationAnswerDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ConversationAnswerDto>[],
  status: json['status'] as String?,
  startedAt: json['startedAt'] as String?,
  timeSpentSeconds: (json['timeSpentSeconds'] as num?)?.toInt() ?? 0,
  pagesCompleted: (json['pagesCompleted'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  readCount: (json['readCount'] as num?)?.toInt() ?? 0,
  readOrdinal: (json['readOrdinal'] as num?)?.toInt(),
  laterCompleted: json['laterCompleted'] as bool? ?? false,
  quizRunCount: (json['quizRunCount'] as num?)?.toInt() ?? 0,
  quizLatestPercent: (json['quizLatestPercent'] as num?)?.toDouble(),
  readAloud: json['readAloud'] == null
      ? null
      : ParentReadAloudSummaryDto.fromJson(
          json['readAloud'] as Map<String, dynamic>,
        ),
  readAloudPractice: json['readAloudPractice'] == null
      ? null
      : ParentReadAloudPracticeDto.fromJson(
          json['readAloudPractice'] as Map<String, dynamic>,
        ),
  readAloudRecordingCount:
      (json['readAloudRecordingCount'] as num?)?.toInt() ?? 0,
  emotions:
      (json['emotions'] as List<dynamic>?)
          ?.map((e) => StoryEmotionDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StoryEmotionDto>[],
  reflection: json['reflection'] == null
      ? null
      : ParentReflectionBriefDto.fromJson(
          json['reflection'] as Map<String, dynamic>,
        ),
  expEarned: (json['expEarned'] as num?)?.toInt() ?? 0,
  wordsCollected:
      (json['wordsCollected'] as List<dynamic>?)
          ?.map(
            (e) => ParentCollectedWordDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <ParentCollectedWordDto>[],
  readingMode: json['readingMode'] as String?,
  retell: json['retell'] == null
      ? null
      : ParentRetellBriefDto.fromJson(json['retell'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ParentReadingFeedbackItemDtoToJson(
  _ParentReadingFeedbackItemDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'storyId': instance.storyId,
  'title': instance.title,
  'completedAt': instance.completedAt?.toIso8601String(),
  'feeling': instance.feeling,
  'feelingLabel': instance.feelingLabel,
  'quizTotalQuestions': instance.quizTotalQuestions,
  'quizBestPercent': instance.quizBestPercent,
  'conversationAnswers': instance.conversationAnswers,
  'status': instance.status,
  'startedAt': instance.startedAt,
  'timeSpentSeconds': instance.timeSpentSeconds,
  'pagesCompleted': instance.pagesCompleted,
  'totalPages': instance.totalPages,
  'readCount': instance.readCount,
  'readOrdinal': instance.readOrdinal,
  'laterCompleted': instance.laterCompleted,
  'quizRunCount': instance.quizRunCount,
  'quizLatestPercent': instance.quizLatestPercent,
  'readAloud': instance.readAloud,
  'readAloudPractice': instance.readAloudPractice,
  'readAloudRecordingCount': instance.readAloudRecordingCount,
  'emotions': instance.emotions,
  'reflection': instance.reflection,
  'expEarned': instance.expEarned,
  'wordsCollected': instance.wordsCollected,
  'readingMode': instance.readingMode,
  'retell': instance.retell,
};

_ConversationAnswerDto _$ConversationAnswerDtoFromJson(
  Map<String, dynamic> json,
) => _ConversationAnswerDto(
  question: json['question'] as String? ?? '',
  kind: json['kind'] as String? ?? '',
  answerText: json['answerText'] as String? ?? '',
  sceneIndex: (json['sceneIndex'] as num?)?.toInt(),
  answeredAt: json['answeredAt'] == null
      ? null
      : DateTime.parse(json['answeredAt'] as String),
);

Map<String, dynamic> _$ConversationAnswerDtoToJson(
  _ConversationAnswerDto instance,
) => <String, dynamic>{
  'question': instance.question,
  'kind': instance.kind,
  'answerText': instance.answerText,
  'sceneIndex': instance.sceneIndex,
  'answeredAt': instance.answeredAt?.toIso8601String(),
};

_ParentReadAloudSummaryDto _$ParentReadAloudSummaryDtoFromJson(
  Map<String, dynamic> json,
) => _ParentReadAloudSummaryDto(
  attempts: (json['attempts'] as num?)?.toInt() ?? 0,
  segmentsPracticed: (json['segmentsPracticed'] as num?)?.toInt() ?? 0,
  goodWords: (json['goodWords'] as num?)?.toInt() ?? 0,
  retryWords: (json['retryWords'] as num?)?.toInt() ?? 0,
  totalWords: (json['totalWords'] as num?)?.toInt() ?? 0,
  goodPercent: (json['goodPercent'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$ParentReadAloudSummaryDtoToJson(
  _ParentReadAloudSummaryDto instance,
) => <String, dynamic>{
  'attempts': instance.attempts,
  'segmentsPracticed': instance.segmentsPracticed,
  'goodWords': instance.goodWords,
  'retryWords': instance.retryWords,
  'totalWords': instance.totalWords,
  'goodPercent': instance.goodPercent,
};

_ParentReadAloudPracticeDto _$ParentReadAloudPracticeDtoFromJson(
  Map<String, dynamic> json,
) => _ParentReadAloudPracticeDto(
  attempts: (json['attempts'] as num?)?.toInt() ?? 0,
  totalWords: (json['totalWords'] as num?)?.toInt() ?? 0,
  latestGoodWords: (json['latestGoodWords'] as num?)?.toInt() ?? 0,
  latestGoodPercent: (json['latestGoodPercent'] as num?)?.toDouble() ?? 0.0,
  bestGoodPercent: (json['bestGoodPercent'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$ParentReadAloudPracticeDtoToJson(
  _ParentReadAloudPracticeDto instance,
) => <String, dynamic>{
  'attempts': instance.attempts,
  'totalWords': instance.totalWords,
  'latestGoodWords': instance.latestGoodWords,
  'latestGoodPercent': instance.latestGoodPercent,
  'bestGoodPercent': instance.bestGoodPercent,
};

_StoryEmotionDto _$StoryEmotionDtoFromJson(Map<String, dynamic> json) =>
    _StoryEmotionDto(
      code: json['code'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$StoryEmotionDtoToJson(_StoryEmotionDto instance) =>
    <String, dynamic>{'code': instance.code, 'label': instance.label};

_ParentReflectionBriefDto _$ParentReflectionBriefDtoFromJson(
  Map<String, dynamic> json,
) => _ParentReflectionBriefDto(
  favoriteSceneId: (json['favoriteSceneId'] as num?)?.toInt() ?? 0,
  favoriteSceneIndex: (json['favoriteSceneIndex'] as num?)?.toInt(),
  hasNoteText: json['hasNoteText'] as bool? ?? false,
  hasNoteRecording: json['hasNoteRecording'] as bool? ?? false,
);

Map<String, dynamic> _$ParentReflectionBriefDtoToJson(
  _ParentReflectionBriefDto instance,
) => <String, dynamic>{
  'favoriteSceneId': instance.favoriteSceneId,
  'favoriteSceneIndex': instance.favoriteSceneIndex,
  'hasNoteText': instance.hasNoteText,
  'hasNoteRecording': instance.hasNoteRecording,
};

_ParentCollectedWordDto _$ParentCollectedWordDtoFromJson(
  Map<String, dynamic> json,
) => _ParentCollectedWordDto(
  vocabularyId: (json['vocabularyId'] as num?)?.toInt() ?? 0,
  term: json['term'] as String? ?? '',
);

Map<String, dynamic> _$ParentCollectedWordDtoToJson(
  _ParentCollectedWordDto instance,
) => <String, dynamic>{
  'vocabularyId': instance.vocabularyId,
  'term': instance.term,
};

_ParentRetellBriefDto _$ParentRetellBriefDtoFromJson(
  Map<String, dynamic> json,
) => _ParentRetellBriefDto(
  summaryId: (json['summaryId'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] as String? ?? '',
  hasRecording: json['hasRecording'] as bool? ?? false,
  flagCount: (json['flagCount'] as num?)?.toInt() ?? 0,
  unansweredCount: (json['unansweredCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ParentRetellBriefDtoToJson(
  _ParentRetellBriefDto instance,
) => <String, dynamic>{
  'summaryId': instance.summaryId,
  'createdAt': instance.createdAt,
  'hasRecording': instance.hasRecording,
  'flagCount': instance.flagCount,
  'unansweredCount': instance.unansweredCount,
};

_ParentFavoriteSceneDto _$ParentFavoriteSceneDtoFromJson(
  Map<String, dynamic> json,
) => _ParentFavoriteSceneDto(
  sceneId: (json['sceneId'] as num?)?.toInt() ?? 0,
  sceneIndex: (json['sceneIndex'] as num?)?.toInt() ?? 0,
  sceneText: json['sceneText'] as String? ?? '',
  illustrationUrl: json['illustrationUrl'] as String?,
);

Map<String, dynamic> _$ParentFavoriteSceneDtoToJson(
  _ParentFavoriteSceneDto instance,
) => <String, dynamic>{
  'sceneId': instance.sceneId,
  'sceneIndex': instance.sceneIndex,
  'sceneText': instance.sceneText,
  'illustrationUrl': instance.illustrationUrl,
};

_ParentStoryReflectionDto _$ParentStoryReflectionDtoFromJson(
  Map<String, dynamic> json,
) => _ParentStoryReflectionDto(
  sessionId: (json['sessionId'] as num?)?.toInt() ?? 0,
  emotions:
      (json['emotions'] as List<dynamic>?)
          ?.map((e) => StoryEmotionDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StoryEmotionDto>[],
  favoriteScene: json['favoriteScene'] == null
      ? null
      : ParentFavoriteSceneDto.fromJson(
          json['favoriteScene'] as Map<String, dynamic>,
        ),
  noteText: json['noteText'] as String?,
  noteAudioUrl: json['noteAudioUrl'] as String?,
  noteSentAt: json['noteSentAt'] as String?,
);

Map<String, dynamic> _$ParentStoryReflectionDtoToJson(
  _ParentStoryReflectionDto instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'emotions': instance.emotions,
  'favoriteScene': instance.favoriteScene,
  'noteText': instance.noteText,
  'noteAudioUrl': instance.noteAudioUrl,
  'noteSentAt': instance.noteSentAt,
};

_ParentReadingFeedbackPageDto _$ParentReadingFeedbackPageDtoFromJson(
  Map<String, dynamic> json,
) => _ParentReadingFeedbackPageDto(
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => ParentReadingFeedbackItemDto.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const <ParentReadingFeedbackItemDto>[],
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  pageIndex: (json['pageIndex'] as num?)?.toInt() ?? 0,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  hasNextPage: json['hasNextPage'] as bool? ?? false,
  hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
);

Map<String, dynamic> _$ParentReadingFeedbackPageDtoToJson(
  _ParentReadingFeedbackPageDto instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'pageIndex': instance.pageIndex,
  'pageSize': instance.pageSize,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};
