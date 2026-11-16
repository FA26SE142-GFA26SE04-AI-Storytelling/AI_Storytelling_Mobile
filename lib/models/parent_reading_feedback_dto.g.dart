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
