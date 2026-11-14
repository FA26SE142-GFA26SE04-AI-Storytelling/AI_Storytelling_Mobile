// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_reading_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildStory _$ChildStoryFromJson(Map<String, dynamic> json) => _ChildStory(
  storyId: (json['storyId'] as num).toInt(),
  title: json['title'] as String,
  coverImageUrl: json['coverImageUrl'] as String?,
  description: json['description'] as String?,
  source: json['source'] as String,
);

Map<String, dynamic> _$ChildStoryToJson(_ChildStory instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'title': instance.title,
      'coverImageUrl': instance.coverImageUrl,
      'description': instance.description,
      'source': instance.source,
    };

_ChildStoryPage _$ChildStoryPageFromJson(Map<String, dynamic> json) =>
    _ChildStoryPage(
      isLocked: json['isLocked'] as bool? ?? false,
      unlockStoryId: (json['unlockStoryId'] as num?)?.toInt(),
      message: json['message'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ChildStory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ChildStory>[],
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      pageIndex: (json['pageIndex'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ChildStoryPageToJson(_ChildStoryPage instance) =>
    <String, dynamic>{
      'isLocked': instance.isLocked,
      'unlockStoryId': instance.unlockStoryId,
      'message': instance.message,
      'items': instance.items,
      'totalCount': instance.totalCount,
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };

_ReadingStartBody _$ReadingStartBodyFromJson(Map<String, dynamic> json) =>
    _ReadingStartBody(
      storyId: (json['storyId'] as num?)?.toInt(),
      communitySubmissionId: (json['communitySubmissionId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReadingStartBodyToJson(_ReadingStartBody instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'communitySubmissionId': instance.communitySubmissionId,
    };

_ReadingStarted _$ReadingStartedFromJson(Map<String, dynamic> json) =>
    _ReadingStarted(
      sessionId: (json['sessionId'] as num).toInt(),
      storyId: (json['storyId'] as num).toInt(),
      resumed: json['resumed'] as bool? ?? false,
      lastPage: (json['lastPage'] as num?)?.toInt() ?? 0,
      lastReadingMode: json['lastReadingMode'] as String?,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      isFavorited: json['isFavorited'] as bool? ?? false,
      listenOnly: json['listenOnly'] as bool?,
    );

Map<String, dynamic> _$ReadingStartedToJson(_ReadingStarted instance) =>
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

_ReadingFlags _$ReadingFlagsFromJson(Map<String, dynamic> json) =>
    _ReadingFlags(
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      isFavorited: json['isFavorited'] as bool? ?? false,
      listenOnly: json['listenOnly'] as bool?,
    );

Map<String, dynamic> _$ReadingFlagsToJson(_ReadingFlags instance) =>
    <String, dynamic>{
      'isBookmarked': instance.isBookmarked,
      'isFavorited': instance.isFavorited,
      'listenOnly': instance.listenOnly,
    };

_ReadingContent _$ReadingContentFromJson(Map<String, dynamic> json) =>
    _ReadingContent(
      sessionId: (json['sessionId'] as num).toInt(),
      storyId: (json['storyId'] as num).toInt(),
      title: json['title'] as String,
      lesson: json['lesson'] as String?,
      listenOnly: json['listenOnly'] as bool? ?? false,
      scenes:
          (json['scenes'] as List<dynamic>?)
              ?.map((e) => ReadingScene.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReadingScene>[],
      vocabulary:
          (json['vocabulary'] as List<dynamic>?)
              ?.map(
                (e) => ReadingVocabulary.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ReadingVocabulary>[],
    );

Map<String, dynamic> _$ReadingContentToJson(_ReadingContent instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'storyId': instance.storyId,
      'title': instance.title,
      'lesson': instance.lesson,
      'listenOnly': instance.listenOnly,
      'scenes': instance.scenes,
      'vocabulary': instance.vocabulary,
    };

_ReadingVocabulary _$ReadingVocabularyFromJson(Map<String, dynamic> json) =>
    _ReadingVocabulary(
      id: (json['id'] as num).toInt(),
      term: json['term'] as String,
    );

Map<String, dynamic> _$ReadingVocabularyToJson(_ReadingVocabulary instance) =>
    <String, dynamic>{'id': instance.id, 'term': instance.term};

_ReadingScene _$ReadingSceneFromJson(Map<String, dynamic> json) =>
    _ReadingScene(
      sceneId: (json['sceneId'] as num).toInt(),
      sceneIndex: (json['sceneIndex'] as num).toInt(),
      text: json['text'] as String,
      illustrationUrl: json['illustrationUrl'] as String?,
      illustrations: (json['illustrations'] as List<dynamic>?)
          ?.map((e) => SceneIllustration.fromJson(e as Map<String, dynamic>))
          .toList(),
      segments:
          (json['segments'] as List<dynamic>?)
              ?.map((e) => ReadingSegment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReadingSegment>[],
      interaction: json['interaction'] as Map<String, dynamic>?,
      attemptedInSession: json['attemptedInSession'] as bool? ?? false,
    );

Map<String, dynamic> _$ReadingSceneToJson(_ReadingScene instance) =>
    <String, dynamic>{
      'sceneId': instance.sceneId,
      'sceneIndex': instance.sceneIndex,
      'text': instance.text,
      'illustrationUrl': instance.illustrationUrl,
      'illustrations': instance.illustrations,
      'segments': instance.segments,
      'interaction': instance.interaction,
      'attemptedInSession': instance.attemptedInSession,
    };

_ReadingSegment _$ReadingSegmentFromJson(Map<String, dynamic> json) =>
    _ReadingSegment(
      segmentId: (json['segmentId'] as num).toInt(),
      segmentOrder: (json['segmentOrder'] as num).toInt(),
      startOffset: (json['startOffset'] as num?)?.toInt(),
      endOffset: (json['endOffset'] as num?)?.toInt(),
      text: json['text'] as String,
      audioUrl: json['audioUrl'] as String?,
      wordTimingsJson: json['wordTimingsJson'] as String?,
    );

Map<String, dynamic> _$ReadingSegmentToJson(_ReadingSegment instance) =>
    <String, dynamic>{
      'segmentId': instance.segmentId,
      'segmentOrder': instance.segmentOrder,
      'startOffset': instance.startOffset,
      'endOffset': instance.endOffset,
      'text': instance.text,
      'audioUrl': instance.audioUrl,
      'wordTimingsJson': instance.wordTimingsJson,
    };

_SceneIllustration _$SceneIllustrationFromJson(Map<String, dynamic> json) =>
    _SceneIllustration(
      beatOrder: (json['beatOrder'] as num).toInt(),
      startOffset: (json['startOffset'] as num).toInt(),
      endOffset: (json['endOffset'] as num).toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SceneIllustrationToJson(_SceneIllustration instance) =>
    <String, dynamic>{
      'beatOrder': instance.beatOrder,
      'startOffset': instance.startOffset,
      'endOffset': instance.endOffset,
      'url': instance.url,
    };

_ReadingProgress _$ReadingProgressFromJson(Map<String, dynamic> json) =>
    _ReadingProgress(
      sessionId: (json['sessionId'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      readingMode: json['readingMode'] as String?,
      timeSpentSeconds: (json['timeSpentSeconds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReadingProgressToJson(_ReadingProgress instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'page': instance.page,
      'readingMode': instance.readingMode,
      'timeSpentSeconds': instance.timeSpentSeconds,
    };

_ReadingCompleted _$ReadingCompletedFromJson(Map<String, dynamic> json) =>
    _ReadingCompleted(
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

Map<String, dynamic> _$ReadingCompletedToJson(_ReadingCompleted instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'storyId': instance.storyId,
      'isRetake': instance.isRetake,
      'roadmapStepCompleted': instance.roadmapStepCompleted,
      'expGained': instance.expGained,
      'newBadges': instance.newBadges,
    };

_ReadingSignal _$ReadingSignalFromJson(Map<String, dynamic> json) =>
    _ReadingSignal(
      shouldExit: json['shouldExit'] as bool? ?? false,
      returnTo: json['returnTo'] as String?,
      message: json['message'] as String?,
      sessionStatus: json['sessionStatus'] as String,
    );

Map<String, dynamic> _$ReadingSignalToJson(_ReadingSignal instance) =>
    <String, dynamic>{
      'shouldExit': instance.shouldExit,
      'returnTo': instance.returnTo,
      'message': instance.message,
      'sessionStatus': instance.sessionStatus,
    };

_VocabularyDefinition _$VocabularyDefinitionFromJson(
  Map<String, dynamic> json,
) => _VocabularyDefinition(
  vocabularyId: (json['vocabularyId'] as num).toInt(),
  term: json['term'] as String,
  definition: json['definition'] as String,
  isCollected: json['isCollected'] as bool? ?? false,
);

Map<String, dynamic> _$VocabularyDefinitionToJson(
  _VocabularyDefinition instance,
) => <String, dynamic>{
  'vocabularyId': instance.vocabularyId,
  'term': instance.term,
  'definition': instance.definition,
  'isCollected': instance.isCollected,
};

_NotebookEntry _$NotebookEntryFromJson(Map<String, dynamic> json) =>
    _NotebookEntry(
      entryId: (json['entryId'] as num).toInt(),
      vocabularyId: (json['vocabularyId'] as num).toInt(),
      term: json['term'] as String,
      definition: json['definition'] as String,
      storyId: (json['storyId'] as num).toInt(),
      storyTitle: json['storyTitle'] as String,
      sceneIndex: (json['sceneIndex'] as num?)?.toInt(),
      collectedAt: json['collectedAt'] as String,
    );

Map<String, dynamic> _$NotebookEntryToJson(_NotebookEntry instance) =>
    <String, dynamic>{
      'entryId': instance.entryId,
      'vocabularyId': instance.vocabularyId,
      'term': instance.term,
      'definition': instance.definition,
      'storyId': instance.storyId,
      'storyTitle': instance.storyTitle,
      'sceneIndex': instance.sceneIndex,
      'collectedAt': instance.collectedAt,
    };

_ReadingFeelingResult _$ReadingFeelingResultFromJson(
  Map<String, dynamic> json,
) => _ReadingFeelingResult(
  sessionId: (json['sessionId'] as num).toInt(),
  feeling: json['feeling'] as String,
  label: json['label'] as String,
);

Map<String, dynamic> _$ReadingFeelingResultToJson(
  _ReadingFeelingResult instance,
) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'feeling': instance.feeling,
  'label': instance.label,
};

_ChildQuizItem _$ChildQuizItemFromJson(Map<String, dynamic> json) =>
    _ChildQuizItem(
      quizItemId: (json['quizItemId'] as num).toInt(),
      type: json['type'] as String? ?? 'MultipleChoice',
      question: json['question'] as String,
      choices: (json['choices'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChildQuizItemToJson(_ChildQuizItem instance) =>
    <String, dynamic>{
      'quizItemId': instance.quizItemId,
      'type': instance.type,
      'question': instance.question,
      'choices': instance.choices,
    };

_ChildQuiz _$ChildQuizFromJson(Map<String, dynamic> json) => _ChildQuiz(
  sessionId: (json['sessionId'] as num).toInt(),
  totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
  bestPercent: (json['bestPercent'] as num?)?.toInt(),
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => ChildQuizItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChildQuizItem>[],
);

Map<String, dynamic> _$ChildQuizToJson(_ChildQuiz instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'totalQuestions': instance.totalQuestions,
      'bestPercent': instance.bestPercent,
      'questions': instance.questions,
    };

_QuizAnswerResult _$QuizAnswerResultFromJson(Map<String, dynamic> json) =>
    _QuizAnswerResult(
      quizItemId: (json['quizItemId'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool? ?? false,
      feedback: json['feedback'] as String,
      expGained: (json['expGained'] as num?)?.toInt() ?? 0,
      newBadges:
          (json['newBadges'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      runCompleted: json['runCompleted'] as bool? ?? false,
      currentPercent: (json['currentPercent'] as num?)?.toInt() ?? 0,
      bestPercent: (json['bestPercent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QuizAnswerResultToJson(_QuizAnswerResult instance) =>
    <String, dynamic>{
      'quizItemId': instance.quizItemId,
      'isCorrect': instance.isCorrect,
      'feedback': instance.feedback,
      'expGained': instance.expGained,
      'newBadges': instance.newBadges,
      'runCompleted': instance.runCompleted,
      'currentPercent': instance.currentPercent,
      'bestPercent': instance.bestPercent,
    };

_ChildQuizResult _$ChildQuizResultFromJson(Map<String, dynamic> json) =>
    _ChildQuizResult(
      sessionId: (json['sessionId'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
      answered: (json['answered'] as num?)?.toInt() ?? 0,
      correct: (json['correct'] as num?)?.toInt() ?? 0,
      currentPercent: (json['currentPercent'] as num?)?.toInt() ?? 0,
      bestPercent: (json['bestPercent'] as num?)?.toInt(),
      runCompleted: json['runCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$ChildQuizResultToJson(_ChildQuizResult instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'totalQuestions': instance.totalQuestions,
      'answered': instance.answered,
      'correct': instance.correct,
      'currentPercent': instance.currentPercent,
      'bestPercent': instance.bestPercent,
      'runCompleted': instance.runCompleted,
    };

_StorySummarySent _$StorySummarySentFromJson(Map<String, dynamic> json) =>
    _StorySummarySent(
      summaryId: (json['summaryId'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$StorySummarySentToJson(_StorySummarySent instance) =>
    <String, dynamic>{
      'summaryId': instance.summaryId,
      'message': instance.message,
    };
